import numpy as np
from sklearn import datasets
from sklearn import cross_validation
from sklearn import svm

def main():
    iris = datasets.load_iris()
    features = iris.data
    target = iris.target
    target_names = iris.target_names
    labels = target_names[target]

    setosa_petal_length = features[labels == 'setosa', 2]
    setosa_petal_width = features[labels == 'setosa', 3]
    setosa = np.c_[setosa_petal_length, setosa_petal_width]
    versicolor_petal_length = features[labels == 'versicolor', 2]
    versicolor_petal_width = features[labels == 'versicolor', 3]
    versicolor = np.c_[versicolor_petal_length, versicolor_petal_width]
    virginica_petal_length = features[labels == 'virginica', 2]
    virginica_petal_width = features[labels == 'virginica', 3]
    virginica = np.c_[virginica_petal_length, virginica_petal_width]

    training_data = np.r_[setosa, versicolor, virginica]
    training_labels = np.r_[
        np.zeros(len(setosa)),
        np.ones(len(versicolor)),
        np.ones(len(versicolor)) * 2,
    ]

    kernels = [
        'linear',
        'poly',
        'rbf',
        'sigmoid',
    ]
    for kernel in kernels:

        kfold = cross_validation.KFold(len(training_data), n_folds=10)
        results = np.array([])
        for training, test in kfold:

            clf = svm.SVC(kernel=kernel)
            clf.fit(training_data[training], training_labels[training])

            answers = clf.predict(training_data[test])
            are_correct = answers == training_labels[test]
            results = np.r_[results, are_correct]

        print('Kernel: {kernel}'.format(kernel=kernel))
        correct = np.sum(results)
        N = len(training_data)
        percent = (float(correct) / N) * 100
        print('Accuracy: {percent:.2f}% ({correct}/{all})'.format(
            correct=correct,
            all=len(training_data),
            percent=percent,
        ))

if __name__ == '__main__':
    main()
