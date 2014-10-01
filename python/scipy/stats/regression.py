import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

x = [290, 50, 80, 100, 200, 350, 430, 80, 210, 110,
     70, 260, 220, 330, 170, 420, 80, 300, 290, 230]
print('X の分散', np.var(x))

y = [350, 70, 100, 130, 250, 430, 520, 100, 260, 140,
     90, 320, 270, 400, 210, 510, 100, 370, 350, 280]
print('Y の分散', np.var(y))

corr = np.corrcoef(x, y)
print('相関係数', corr)

xticks = np.arange(0, 700, step=100)
yticks = np.arange(0, 7)

fig = plt.figure()

ax1 = fig.add_subplot(211)
plt.xticks(xticks)
plt.yticks(yticks)
ax1.hist(x)

ax2 = fig.add_subplot(212)
plt.xticks(xticks)
plt.yticks(yticks)
ax2.hist(y)

plt.savefig('image.png')

plt.close()

plt.figure()
plt.xticks(xticks)
plt.yticks(xticks)

plt.scatter(x, y)

plt.savefig('image2.png')

regres = stats.linregress(x, y)
print('回帰式', regres)
