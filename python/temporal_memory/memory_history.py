# memory_history.py: SQLite-backed temporal state history
#
# Description:
# Keeps the history of state values in SQLite and reconstructs the value
# valid at a given time from each row's validity interval. The module
# docstring below states the storage model.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     from memory_history import as_of, connect, current, remember, revoke
#
#     Run the tests from the python/temporal_memory directory:
#     python -m pytest -q
#
# Requirements:
# - Python 3.12 or later
# - Only the Python standard library is required at runtime

"""SQLite-backed temporal state history.

Each (subject, attribute) keeps its history as rows valid over the half-open
interval [valid_from, valid_to). Times are UTC Unix time integers.
"""

from __future__ import annotations

import sqlite3
from pathlib import Path
from time import time

SCHEMA = """
CREATE TABLE IF NOT EXISTS memory_history (
    id INTEGER PRIMARY KEY,
    subject TEXT NOT NULL,
    attribute TEXT NOT NULL,
    value TEXT NOT NULL,
    valid_from INTEGER NOT NULL,
    valid_to INTEGER,
    CHECK (valid_to IS NULL OR valid_from < valid_to),
    UNIQUE (subject, attribute, valid_from)
);

CREATE INDEX IF NOT EXISTS idx_memory_history_lookup
    ON memory_history(subject, attribute, valid_from DESC);
"""

LATEST = """
SELECT id, valid_from, valid_to
FROM memory_history
WHERE subject = ? AND attribute = ?
ORDER BY valid_from DESC
LIMIT 1
"""


def connect(path: str | Path = ":memory:") -> sqlite3.Connection:
    con = sqlite3.connect(path, isolation_level=None)
    con.executescript(SCHEMA)
    return con


def remember(
    con: sqlite3.Connection,
    subject: str,
    attribute: str,
    value: str,
    valid_from: int,
) -> None:
    con.execute("BEGIN IMMEDIATE")
    try:
        latest = con.execute(LATEST, (subject, attribute)).fetchone()
        if latest is not None:
            latest_id, latest_from, latest_to = latest
            if valid_from <= latest_from:
                raise ValueError("valid_from must be later than the latest history row")
            if latest_to is not None:
                if valid_from < latest_to:
                    raise ValueError("valid_from overlaps the latest closed interval")
            else:
                con.execute(
                    "UPDATE memory_history SET valid_to = ? WHERE id = ?",
                    (valid_from, latest_id),
                )
        con.execute(
            "INSERT INTO memory_history (subject, attribute, value, valid_from, valid_to)"
            " VALUES (?, ?, ?, ?, NULL)",
            (subject, attribute, value, valid_from),
        )
        con.execute("COMMIT")
    except Exception:
        con.execute("ROLLBACK")
        raise


def as_of(
    con: sqlite3.Connection,
    subject: str,
    attribute: str,
    at: int,
) -> str | None:
    row = con.execute(
        """
        SELECT value
        FROM memory_history
        WHERE subject = ?
          AND attribute = ?
          AND valid_from <= ?
          AND (valid_to IS NULL OR ? < valid_to)
        ORDER BY valid_from DESC
        LIMIT 1
        """,
        (subject, attribute, at, at),
    ).fetchone()
    return None if row is None else row[0]


def current(
    con: sqlite3.Connection,
    subject: str,
    attribute: str,
    now: int | None = None,
) -> str | None:
    return as_of(con, subject, attribute, int(time()) if now is None else now)


def revoke(
    con: sqlite3.Connection,
    subject: str,
    attribute: str,
    at: int,
) -> None:
    con.execute("BEGIN IMMEDIATE")
    try:
        latest = con.execute(LATEST, (subject, attribute)).fetchone()
        if latest is None:
            raise KeyError((subject, attribute))
        latest_id, latest_from, latest_to = latest
        if latest_to is not None:
            raise ValueError("the latest history row is already closed")
        if at <= latest_from:
            raise ValueError("revocation time must be later than valid_from")
        con.execute(
            "UPDATE memory_history SET valid_to = ? WHERE id = ?",
            (at, latest_id),
        )
        con.execute("COMMIT")
    except Exception:
        con.execute("ROLLBACK")
        raise
