# engram_fixed_lookup.py: Fixed lookup values and Backbone output comparison
#
# Description:
#   Verify identical reference-table bytes while changing Backbone weights,
#   candidate scores, and argmax token selection in a deterministic NumPy sample.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root with Python 3.12 and NumPy 2.2.6 installed:
#     python -B python/engram_fixed_lookup/engram_fixed_lookup.py
#
# Requirements:
#   - Python 3.12
#   - NumPy 2.2.6
#   - Do not run with -O; the sample uses assertions.

import numpy as np

DTYPE = np.dtype("<f8")
LOOKUP_INDEX = 0
CANDIDATES = ("A", "B")

D_ORIGINAL = np.array([[1.0, 0.0], [0.0, 1.0]], dtype=DTYPE)
D_COPY = np.array([[1.0, 0.0], [0.0, 1.0]], dtype=DTYPE)
D_MODIFIED = np.array([[1.0, 0.5], [0.0, 1.0]], dtype=DTYPE)

W_ORIGINAL = np.array([[2.001, 0.0], [2.000, 0.0]], dtype=DTYPE)
W_FLIP = np.array([[1.999, 0.0], [2.000, 0.0]], dtype=DTYPE)
W_KEEP = np.array([[2.0005, 0.0], [2.000, 0.0]], dtype=DTYPE)


def same_bytes(a, b):
    return (
        a.dtype == b.dtype
        and a.shape == b.shape
        and a.tobytes(order="C") == b.tobytes(order="C")
    )


def infer(table, backbone):
    reference = table[LOOKUP_INDEX]
    scores = backbone @ reference
    token = CANDIDATES[int(np.argmax(scores))]
    return scores, token


original_scores, original_token = infer(D_ORIGINAL, W_ORIGINAL)
flip_scores, flip_token = infer(D_COPY, W_FLIP)
keep_scores, keep_token = infer(D_COPY, W_KEEP)

assert same_bytes(D_ORIGINAL, D_COPY)
assert not same_bytes(D_ORIGINAL, D_MODIFIED)
assert np.array_equal(original_scores, infer(D_COPY, W_ORIGINAL)[0])
assert not np.array_equal(original_scores, flip_scores)
assert not np.array_equal(original_scores, keep_scores)
assert (original_token, flip_token, keep_token) == ("A", "B", "A")

print(f"参照テーブル一致: {same_bytes(D_ORIGINAL, D_COPY)}")
print(f"変更した参照テーブルとの一致: {same_bytes(D_ORIGINAL, D_MODIFIED)}")
for name, scores, token in (
    ("元モデル", original_scores, original_token),
    ("順位逆転", flip_scores, flip_token),
    ("順位維持", keep_scores, keep_token),
):
    print(f"{name}: A={scores[0]:.4f}, B={scores[1]:.4f}, token={token}")
print(f"スコア一致（順位逆転）: {np.array_equal(original_scores, flip_scores)}")
print(f"スコア一致（順位維持）: {np.array_equal(original_scores, keep_scores)}")
