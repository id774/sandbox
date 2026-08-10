#!/usr/bin/env python3
# Print 10 rows of Pascal's triangle, each row zipped from the previous one shifted both ways.

ROWS = 10

row = [1]
for _ in range(ROWS):
    print(" ".join(str(value) for value in row))
    row = [left + right for left, right in zip([0] + row, row + [0])]
