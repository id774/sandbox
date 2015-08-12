from sklearn import linear_model
clf = linear_model.Lasso(alpha=0.1)
clf.fit([[0, 0], [1, 1], [2, 2]], [0, 1, 2])
# => Lasso(alpha=0.1, copy_X=True, fit_intercept=True, max_iter=1000,
#         normalize=False, positive=False, precompute=False, random_state=None,
#         selection='cyclic', tol=0.0001, warm_start=False)
print(clf.coef_)
# => [ 0.85  0.  ]
print(clf.intercept_)
# => 0.15
