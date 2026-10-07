#!/usr/bin/env python3

# binary_quantization.py: Binary quantization search with sqlite-vec
#
# Description:
# Stores a few float32 vectors in an in-memory SQLite database twice, once as
# they are and once reduced to one bit per element with vec_quantize_binary().
# It narrows the candidates by Hamming distance on the bit vectors, then
# reranks them by L2 distance on the float32 vectors, and checks that the
# expected row comes out on top.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Reference: https://github.com/asg017/sqlite-vec/releases/tag/v0.1.9
# Reference: https://github.com/asg017/sqlite-vec/blob/v0.1.9/site/guides/binary-quant.md
# Reference: https://github.com/asg017/sqlite-vec/blob/v0.1.9/site/api-reference.md
#
# Usage:
#     ./binary_quantization.py
#
# Requirements:
# - Python 3.10 or later, built with SQLite extension loading enabled
# - sqlite-vec 0.1.9 or later
#
# Notes:
# - The data is fixed in the source, so no network access or dataset is needed.
# - The script exits with a non-zero status when a check fails.

import sqlite3
import struct
import sys

import sqlite_vec

DIMENSION = 8
COARSE_K = 3

# Each vector has DIMENSION elements; a bit vector needs a multiple of 8.
# Rows 1 and 2 share the query's signs, so the bit vectors cannot tell them
# apart; the float32 rerank puts row 2, the nearer one, first.
VECTORS = {
    1: [0.3, 0.2, 0.9, 0.1, -0.9, -0.1, -0.2, -0.3],
    2: [0.8, 0.9, 0.6, 0.7, -0.4, -0.7, -0.6, -0.9],
    3: [-0.9, -0.8, -0.7, -0.6, 0.5, 0.6, 0.7, 0.8],
    4: [0.7, -0.8, 0.6, -0.7, 0.5, -0.6, 0.4, -0.5],
    5: [-0.6, 0.7, -0.5, 0.8, -0.4, 0.9, -0.3, 0.6],
}
QUERY = [0.85, 0.85, 0.65, 0.65, -0.45, -0.65, -0.65, -0.85]
EXPECTED_TOP = 2


def serialize(vector):
    return struct.pack(f"{len(vector)}f", *vector)


assert DIMENSION % 8 == 0
assert all(len(v) == DIMENSION for v in VECTORS.values()) and len(QUERY) == DIMENSION

db = sqlite3.connect(":memory:")
db.enable_load_extension(True)
sqlite_vec.load(db)
db.enable_load_extension(False)

sqlite_version, vec_version = db.execute("select sqlite_version(), vec_version()").fetchone()

db.execute(
    f"create virtual table items using vec0("
    f"id integer primary key, embedding float[{DIMENSION}], coarse bit[{DIMENSION}])"
)
for row_id, vector in VECTORS.items():
    db.execute(
        "insert into items(id, embedding, coarse) values (?, ?, vec_quantize_binary(?))",
        (row_id, serialize(vector), serialize(vector)),
    )

float_bytes = db.execute(
    "select length(embedding) from items where id = 1"
).fetchone()[0]
binary_bytes = db.execute(
    "select length(vec_quantize_binary(embedding)) from items where id = 1"
).fetchone()[0]

query_blob = serialize(QUERY)

coarse = db.execute(
    "select id, distance from items "
    "where coarse match vec_quantize_binary(?) and k = ? order by distance",
    (query_blob, COARSE_K),
).fetchall()
coarse_ids = [row_id for row_id, _ in coarse]

placeholders = ",".join("?" * len(coarse_ids))
reranked = db.execute(
    f"select id, vec_distance_L2(embedding, ?) as distance from items "
    f"where id in ({placeholders}) order by distance",
    (query_blob, *coarse_ids),
).fetchall()

print(f"sqlite: {sqlite_version}")
print(f"sqlite-vec: {vec_version}")
print(f"dimension: {DIMENSION}")
print(f"float32 bytes per vector: {float_bytes}")
print(f"binary bytes per vector: {binary_bytes}")
print(f"theoretical compression ratio: {float_bytes // binary_bytes}x")
print(f"coarse binary search (top {COARSE_K}, Hamming distance):")
for row_id, distance in coarse:
    print(f"  id={row_id} distance={int(distance)}")
print("reranked by float32 L2 distance:")
for row_id, distance in reranked:
    print(f"  id={row_id} distance={distance:.4f}")

if float_bytes // binary_bytes != 32:
    sys.exit("expected a 32x size reduction")
if reranked[0][0] != EXPECTED_TOP:
    sys.exit(f"expected id={EXPECTED_TOP} first, got id={reranked[0][0]}")
print(f"top result: id={reranked[0][0]}: PASS")
