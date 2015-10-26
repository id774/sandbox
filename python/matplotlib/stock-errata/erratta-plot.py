import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

df = pd.read_csv("stock_N225.csv", sep="\t", index_col=0)
fig = plt.figure(figsize=(12.80, 10.24))
ax1 = fig.add_subplot(2, 1, 1)
ax2 = fig.add_subplot(2, 1, 2)
df['Adj Close'].plot(label="Close", ax=ax1, color="b")
df['Trend-Correct-Ratio'].plot(label="Trend", ax=ax2, color="g")
df['Predict-Mean-Ratio'] = df['Predict-mean'] + 50
df['Predict-Mean-Ratio'].plot(label="Predict", ax=ax2, color="r")
plt.savefig("image.png")
plt.close()
