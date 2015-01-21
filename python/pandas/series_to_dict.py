import pandas as pd

mapping = {"a": "red", "b": "red", "c": "blue", "d": "blue", "e": "red", "f": "orange"}
result = pd.Series(mapping).to_dict()
print(result)
