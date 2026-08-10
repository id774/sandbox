# Draw from a list with numpy choice, with and without replacement and weights.

from numpy import *

city = ["Sapporo", "Sendai", "Tokyo", "Nagoya", "Kyoto", "Osaka", "Fukuoka"]
print(city)

print(random.choice(city))                     # draw one at random
print(random.choice(city, 5))                  # draw five at random, with replacement
print(random.choice(city, 3, replace=False))   # draw three at random, without replacement

# Weighting the probabilities
weight = [0.1, 0.1, 0.3, 0.1, 0.1, 0.2, 0.1]
print(random.choice(city, p=weight))           # draw one with the given probabilities
