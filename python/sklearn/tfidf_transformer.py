from sklearn.feature_extraction.text import TfidfTransformer
import numpy as np
transformer = TfidfTransformer()
transformer
TfidfTransformer(norm='l2', smooth_idf=True, sublinear_tf=False, use_idf=True)

sample = np.array([
    [3, 0, 1],
    [2, 0, 0],
    [3, 0, 0],
    [4, 0, 0],
    [3, 2, 0],
    [3, 0, 2]
])

tfidf = transformer.fit_transform(sample)
print(tfidf.toarray())
