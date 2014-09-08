import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

x = np.array([0.0, 1.0, 2.0, 3.0, 4.0, 5.0])
y = np.array([0.0, 0.8, 0.9, 0.1, -0.8, -1.0])

result = stats.linregress(x, y)
print("単回帰分析 (scipy.stats)", result)

result = np.polyfit(x, y, 1)
print("単回帰分析 (np.polyfit)", result)

result = np.polyfit(x, y, 3)
print("重回帰分析 (np.polyfit)", result)

p = np.poly1d(result)
print('p', p)
print("p(0.5)", p(0.5))
print("p(3.5)", p(3.5))
print("p(10)", p(10))

p30 = np.poly1d(np.polyfit(x, y, 30))
print("p30", p30)

xp = np.linspace(-2, 6, 100)

plt.plot(x, y, '.', xp, p(xp), '-', xp, p30(xp), '*')
plt.ylim(-2, 2)
plt.show()
plt.savefig('image.png')
