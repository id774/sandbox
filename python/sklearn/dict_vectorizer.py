from sklearn.feature_extraction import DictVectorizer
vec = DictVectorizer()
print (vec.fit_transform([{'住所': '北海道'}, {'住所': '沖縄'}, {'住所': '東京'}, {'住所': '東京'}, {'出身地': '北海道'}]).toarray())
