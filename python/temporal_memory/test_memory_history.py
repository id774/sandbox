from datetime import datetime, timezone

import pytest

from memory_history import as_of, connect, current, remember, revoke


def ts(value: str) -> int:
    return int(
        datetime.fromisoformat(value)
        .replace(tzinfo=timezone.utc)
        .timestamp()
    )


def test_reconstructs_past_and_current_value():
    con = connect()
    remember(con, "user", "employer", "Company A", ts("2026-04-01"))
    remember(con, "user", "employer", "Company B", ts("2026-09-01"))

    assert as_of(con, "user", "employer", ts("2026-06-01")) == "Company A"
    assert as_of(con, "user", "employer", ts("2026-09-01")) == "Company B"


def test_revoke_closes_validity_without_deleting_history():
    con = connect()
    remember(con, "user", "allow_external_upload", "true", ts("2026-09-01"))
    revoke(con, "user", "allow_external_upload", ts("2026-09-15"))

    assert as_of(con, "user", "allow_external_upload", ts("2026-09-10")) == "true"
    assert as_of(con, "user", "allow_external_upload", ts("2026-09-20")) is None
    rows = con.execute("SELECT valid_to FROM memory_history").fetchall()
    assert rows == [(ts("2026-09-15"),)]


def test_future_value_becomes_current_at_valid_from():
    con = connect()
    remember(con, "project", "release_status", "stable", ts("2026-09-01"))
    remember(con, "project", "release_status", "maintenance", ts("2026-10-01"))

    assert current(con, "project", "release_status", now=ts("2026-09-30 23:59:59")) == "stable"
    assert current(con, "project", "release_status", now=ts("2026-10-01 00:00:00")) == "maintenance"


def test_rejects_out_of_order_history():
    con = connect()
    remember(con, "user", "employer", "Company B", ts("2026-09-01"))

    with pytest.raises(ValueError):
        remember(con, "user", "employer", "Company A", ts("2026-04-01"))
