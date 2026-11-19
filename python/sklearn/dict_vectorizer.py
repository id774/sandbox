# dict_vectorizer.py: One-hot vectors from categorical dictionaries
#
# Description:
# Turn dictionaries of categorical values into one hot vectors.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 dict_vectorizer.py
#
# Requirements:
# - Python 3
# - scikit-learn
#

from sklearn.feature_extraction import DictVectorizer
vec = DictVectorizer()
print(vec.fit_transform([{'住所': '北海道'}, {'住所': '沖縄'}, {
      '住所': '東京'}, {'住所': '東京'}, {'出身地': '北海道'}]).toarray())
