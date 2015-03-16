import numpy as np
import matplotlib.pyplot as plt
import statsmodels.api as sm
from statsmodels.tsa.api import VAR
from scipy.signal import lfilter

mdata = sm.datasets.macrodata.load().data
mdata = mdata[['realgdp', 'realcons', 'realinv']]
names = mdata.dtype.names
data = mdata.view((float, 3))
data = np.diff(np.log(data), axis=0)
model = VAR(data)
res = model.fit(2)

res.plot_sample_acorr()

irf = res.irf(10)
irf.plot()
plt.show()
plt.savefig('image.png')

res.plot_forecast(5)

res.fevd().plot()
plt.show()
plt.savefig('image2.png')
