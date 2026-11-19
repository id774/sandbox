# by_normal.py: Total sales per product with plain Python
#
# Description:
# Total sales per product by parsing a CSV with plain Python.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 by_normal.py
#
# Requirements:
# - Python 3
# - product.csv in the current directory
#

from collections import defaultdict

filename = "product.csv"
header_skipped = False
sales = defaultdict(lambda: 0)
with open(filename, 'r') as f:
    for line in f:
        if not header_skipped:
            header_skipped = True
            continue
        line = line.split(",")
        product = line[0]
        num_sales = int(line[1])
        sales[product] += num_sales
top10 = sorted(sales.items(), key=lambda x: x[1], reverse=True)[:10]
print(top10)
