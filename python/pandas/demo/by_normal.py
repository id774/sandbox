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
