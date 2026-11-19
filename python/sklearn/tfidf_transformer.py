# tfidf_transformer.py: TF-IDF weights from a term count matrix
#
# Description:
# Convert a term count matrix into TF-IDF weights.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 tfidf_transformer.py
#
# Requirements:
# - Python 3
# - NumPy and scikit-learn
#

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
