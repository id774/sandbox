import pandas as pd
filename = "product.csv"
data = pd.read_csv(filename)  # header is conveniently inferred by default
top10 = data.groupby("Product")["ItemsSold"].sum().order(ascending=False)[:10]
print(top10)
