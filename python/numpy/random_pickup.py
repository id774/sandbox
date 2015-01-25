from numpy import *

city = ["Sapporo", "Sendai", "Tokyo", "Nagoya", "Kyoto", "Osaka", "Fukuoka"]
print(city)

print(random.choice(city))                     # 1 個をランダム抽出
print(random.choice(city, 5))                  # 5 個をランダム抽出（重複あり）
print(random.choice(city, 3, replace=False))   # 3 個をランダム抽出（重複なし)

# 確率を重み付けする場合
weight = [0.1, 0.1, 0.3, 0.1, 0.1, 0.2, 0.1]
print(random.choice(city, p=weight))           # 指定した確率で 1 個を抽出
