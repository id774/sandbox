
# https://github.com/matsuken92/Qiita_Contents/blob/master/chainer-MNIST/chainer-MNIST_forPubs.ipynb

import matplotlib.pyplot as plt
import numpy as np
from sklearn.datasets import fetch_mldata
from chainer import cuda, Variable, FunctionSet, optimizers
import chainer.functions as F

plt.style.use('ggplot')
# Batch size for one step of stochastic gradient descent
batchsize = 100
# Number of training epochs
n_epoch = 20
# Number of hidden units
n_units = 1000
# Download the MNIST handwritten digit data
# It is cached under $HOME/scikit_learn_data/mldata/mnist-original.mat
print('fetch MNIST dataset')
mnist = fetch_mldata('MNIST original', data_home=".")
# mnist.data holds 70,000 vectors of 784 dimensions
mnist.data = mnist.data.astype(np.float32)
mnist.data /= 255     # Scale into 0-1
# mnist.target holds the correct labels
mnist.target = mnist.target.astype(np.int32)

# Draw one handwritten digit
def draw_digit(data):
    size = 28
    plt.figure(figsize=(2.5, 3))

    X, Y = np.meshgrid(list(range(size)), list(range(size)))
    Z = data.reshape(size, size)   # convert from vector to 28x28 matrix
    Z = Z[::-1, :]             # flip vertical
    plt.xlim(0, 27)
    plt.ylim(0, 27)
    plt.pcolor(X, Y, Z)
    plt.gray()
    plt.tick_params(labelbottom="off")
    plt.tick_params(labelleft="off")

    return plt

plt = draw_digit(mnist.data[5])
plt.savefig('sample1.png')
plt = draw_digit(mnist.data[12345])
plt.savefig('sample2.png')
plt = draw_digit(mnist.data[33456])
plt.savefig('sample3.png')
plt = draw_digit(mnist.data[12345])
plt.savefig('sample4.png')

# Use N rows for training and the rest for validation
N = 60000
x_train, x_test = np.split(mnist.data, [N])
y_train, y_test = np.split(mnist.target, [N])
N_test = y_test.size

# Prepare multi-layer perceptron model
# Configure the multi layer perceptron
# 784 inputs and 10 outputs
model = FunctionSet(l1=F.Linear(784, n_units),
                    l2=F.Linear(n_units, n_units),
                    l3=F.Linear(n_units, 10))

# Neural net architecture
# Structure of the neural network
def forward(x_data, y_data, train=True):
    x, t = Variable(x_data), Variable(y_data)
    h1 = F.dropout(F.relu(model.l1(x)), train=train)
    h2 = F.dropout(F.relu(model.l2(h1)), train=train)
    y = model.l3(h2)
    # This is multi class classification, so derive the loss from the
    # softmax cross entropy function
    return F.softmax_cross_entropy(y, t), F.accuracy(y, t)

# Setup optimizer
optimizer = optimizers.Adam()
optimizer.setup(model)

train_loss = []
train_acc = []
test_loss = []
test_acc = []

l1_W = []
l2_W = []
l3_W = []

for epoch in range(1, n_epoch + 1):
    print('epoch', epoch)

    # Training
    # Shuffle the order of the N rows
    perm = np.random.permutation(N)
    sum_accuracy = 0
    sum_loss = 0
    # Train on rows 0 to N one batch at a time
    for i in range(0, N, batchsize):
        x_batch = x_train[perm[i:i + batchsize]]
        y_batch = y_train[perm[i:i + batchsize]]

        # Clear the gradients
        optimizer.zero_grads()
        # Run the forward pass to get the loss and accuracy
        loss, acc = forward(x_batch, y_batch)
        # Compute the gradients by back propagation
        loss.backward()
        optimizer.update()
        sum_loss += float(cuda.to_cpu(loss.data)) * batchsize
        sum_accuracy += float(cuda.to_cpu(acc.data)) * batchsize

    # Print the loss and accuracy on the training data
    print('train mean loss={}, accuracy={}'.format(
        sum_loss / N, sum_accuracy / N))

    train_loss.append(sum_loss / N)
    train_acc.append(sum_accuracy / N)

    # Evaluation
    # Measure loss and accuracy on the test data to check generalization
    sum_accuracy = 0
    sum_loss = 0
    for i in range(0, N_test, batchsize):
        x_batch = x_test[i:i + batchsize]
        y_batch = y_test[i:i + batchsize]

        # Run the forward pass to get the loss and accuracy
        loss, acc = forward(x_batch, y_batch, train=False)

        sum_loss += float(cuda.to_cpu(loss.data)) * batchsize
        sum_accuracy += float(cuda.to_cpu(acc.data)) * batchsize

    # Print the loss and accuracy on the test data
    print('test  mean loss={}, accuracy={}'.format(
        sum_loss / N_test, sum_accuracy / N_test))
    test_loss.append(sum_loss / N_test)
    test_acc.append(sum_accuracy / N_test)

    # Save the trained parameters
    l1_W.append(model.l1.W)
    l2_W.append(model.l2.W)
    l3_W.append(model.l3.W)

# Plot the accuracy and loss
plt.figure(figsize=(8, 6))
plt.plot(list(range(len(train_acc))), train_acc)
plt.plot(list(range(len(test_acc))), test_acc)
plt.legend(["train_acc", "test_acc"], loc=4)
plt.title("Accuracy of digit recognition.")
plt.plot()
plt.savefig('image.png')

train_loss = []
train_acc = []
test_loss = []
test_acc = []

l1_W = []
l2_W = []
l3_W = []

plt.style.use('fivethirtyeight')
def draw_digit3(data, n, ans, recog):
    size = 28
    plt.subplot(5, 5, n)
    Z = data.reshape(size, size)   # convert from vector to 28x28 matrix
    Z = Z[::-1, :]             # flip vertical
    plt.xlim(0, 27)
    plt.ylim(0, 27)
    plt.pcolor(Z)
    plt.title("answer=%d, predict=%d" % (ans, recog), size=8)
    plt.gray()
    plt.tick_params(labelbottom="off")
    plt.tick_params(labelleft="off")

plt.figure(figsize=(6.40, 6.40))

cnt = 0
for idx in np.random.permutation(N)[:25]:
    # Forwarding for prediction
    xxx = x_train[idx].astype(np.float32)
    h1 = F.dropout(
        F.relu(model.l1(Variable(xxx.reshape(1, 784)))), train=False)
    h2 = F.dropout(F.relu(model.l2(h1)), train=False)
    y = model.l3(h2)
    cnt += 1
    draw_digit3(x_train[idx], cnt, y_train[idx], np.argmax(y.data))

plt.savefig('image2.png')
