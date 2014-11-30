from collections import namedtuple

Doc = namedtuple('Doc', 'tf idf')
doc = Doc(tf=0.1, idf=0.01)

print(doc.tf, doc.idf)
