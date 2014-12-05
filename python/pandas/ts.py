import numpy as np
import pandas
from datetime import datetime

dates = [
    datetime(2014, 12, 1),
    datetime(2014, 12, 2),
    datetime(2014, 12, 3),
    datetime(2014, 12, 4),
    datetime(2014, 12, 5),
    datetime(2014, 12, 6)
]

ts = pandas.Series(np.random.randn(6), index=dates)

print(ts)
print(type(ts))
