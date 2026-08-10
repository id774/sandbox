
# http://kivantium.hateblo.jp/entry/2015/11/18/233834

import cv2
import numpy as np
import tensorflow as tf
import tensorflow.python.platform

NUM_CLASSES = 2
IMAGE_SIZE = 28
IMAGE_PIXELS = IMAGE_SIZE * IMAGE_SIZE * 3

flags = tf.app.flags
FLAGS = flags.FLAGS
flags.DEFINE_string('train', 'train.txt', 'File name of train data')
flags.DEFINE_string('test', 'test.txt', 'File name of train data')
flags.DEFINE_string(
    'train_dir', '/tmp/data', 'Directory to put the training data.')
flags.DEFINE_integer('max_steps', 200, 'Number of steps to run trainer.')
flags.DEFINE_integer('batch_size', 10, 'Batch size'
                     'Must divide evenly into the dataset sizes.')
flags.DEFINE_float('learning_rate', 1e-4, 'Initial learning rate.')

def inference(images_placeholder, keep_prob):
    """ Build the prediction model

    Args:
      images_placeholder: placeholder for the images
      keep_prob: placeholder for the dropout rate

    Returns:
      y_conv: something like a probability for each class
    """
    # Initialize weights from a normal distribution with standard deviation 0.1
    def weight_variable(shape):
        initial = tf.truncated_normal(shape, stddev=0.1)
        return tf.Variable(initial)

    # Initialize biases from a normal distribution with standard deviation 0.1
    def bias_variable(shape):
        initial = tf.constant(0.1, shape=shape)
        return tf.Variable(initial)

    # Create a convolution layer
    def conv2d(x, W):
        return tf.nn.conv2d(x, W, strides=[1, 1, 1, 1], padding='SAME')

    # Create a pooling layer
    def max_pool_2x2(x):
        return tf.nn.max_pool(x, ksize=[1, 2, 2, 1],
                              strides=[1, 2, 2, 1], padding='SAME')

    # Reshape the input to 28x28x3
    x_image = tf.reshape(images_placeholder, [-1, 28, 28, 3])

    # Create convolution layer 1
    with tf.name_scope('conv1') as scope:
        W_conv1 = weight_variable([5, 5, 3, 32])
        b_conv1 = bias_variable([32])
        h_conv1 = tf.nn.relu(conv2d(x_image, W_conv1) + b_conv1)

    # Create pooling layer 1
    with tf.name_scope('pool1') as scope:
        h_pool1 = max_pool_2x2(h_conv1)

    # Create convolution layer 2
    with tf.name_scope('conv2') as scope:
        W_conv2 = weight_variable([5, 5, 32, 64])
        b_conv2 = bias_variable([64])
        h_conv2 = tf.nn.relu(conv2d(h_pool1, W_conv2) + b_conv2)

    # Create pooling layer 2
    with tf.name_scope('pool2') as scope:
        h_pool2 = max_pool_2x2(h_conv2)

    # Create fully connected layer 1
    with tf.name_scope('fc1') as scope:
        W_fc1 = weight_variable([7 * 7 * 64, 1024])
        b_fc1 = bias_variable([1024])
        h_pool2_flat = tf.reshape(h_pool2, [-1, 7 * 7 * 64])
        h_fc1 = tf.nn.relu(tf.matmul(h_pool2_flat, W_fc1) + b_fc1)
        # Configure dropout
        h_fc1_drop = tf.nn.dropout(h_fc1, keep_prob)

    # Create fully connected layer 2
    with tf.name_scope('fc2') as scope:
        W_fc2 = weight_variable([1024, NUM_CLASSES])
        b_fc2 = bias_variable([NUM_CLASSES])

    # Normalize with the softmax function
    with tf.name_scope('softmax') as scope:
        y_conv = tf.nn.softmax(tf.matmul(h_fc1_drop, W_fc2) + b_fc2)

    # Return something like a probability for each label
    return y_conv

def loss(logits, labels):
    """ Compute the loss

    Args:
      logits: tensor of logits, float - [batch_size, NUM_CLASSES]
      labels: tensor of labels, int32 - [batch_size, NUM_CLASSES]

    Returns:
      cross_entropy: tensor of cross entropy, float

    """

    # Compute the cross entropy
    cross_entropy = -tf.reduce_sum(labels * tf.log(logits))
    # Register the value for display in TensorBoard
    tf.scalar_summary("cross_entropy", cross_entropy)
    return cross_entropy

def training(loss, learning_rate):
    """ Define the training op

    Args:
      loss: tensor of the loss, the result of loss()
      learning_rate: the learning rate

    Returns:
      train_step: the training op

    """

    train_step = tf.train.AdamOptimizer(learning_rate).minimize(loss)
    return train_step

def accuracy(logits, labels):
    """ Compute the accuracy

    Args:
      logits: the result of inference()
      labels: tensor of labels, int32 - [batch_size, NUM_CLASSES]

    Returns:
      accuracy: the accuracy, float

    """
    correct_prediction = tf.equal(tf.argmax(logits, 1), tf.argmax(labels, 1))
    accuracy = tf.reduce_mean(tf.cast(correct_prediction, "float"))
    tf.scalar_summary("accuracy", accuracy)
    return accuracy

if __name__ == '__main__':
    # Open the file
    f = open(FLAGS.train, 'r')
    # Arrays to hold the data
    train_image = []
    train_label = []
    for line in f:
        # Strip the newline and split on spaces
        line = line.rstrip()
        l = line.split()
        # Read the image and shrink it to 28x28
        img = cv2.imread(l[0])
        img = cv2.resize(img, (28, 28))
        # Flatten it, then scale the values into 0-1 floats
        train_image.append(img.flatten().astype(np.float32) / 255.0)
        # Build the label in one-of-k form
        tmp = np.zeros(NUM_CLASSES)
        tmp[int(l[1])] = 1
        train_label.append(tmp)
    # Convert to numpy arrays
    train_image = np.asarray(train_image)
    train_label = np.asarray(train_label)
    f.close()

    f = open(FLAGS.test, 'r')
    test_image = []
    test_label = []
    for line in f:
        line = line.rstrip()
        l = line.split()
        img = cv2.imread(l[0])
        img = cv2.resize(img, (28, 28))
        test_image.append(img.flatten().astype(np.float32) / 255.0)
        tmp = np.zeros(NUM_CLASSES)
        tmp[int(l[1])] = 1
        test_label.append(tmp)
    test_image = np.asarray(test_image)
    test_label = np.asarray(test_label)
    f.close()

    with tf.Graph().as_default():
        # Placeholder tensor for the images
        images_placeholder = tf.placeholder(
            "float", shape=(None, IMAGE_PIXELS))
        # Placeholder tensor for the labels
        labels_placeholder = tf.placeholder("float", shape=(None, NUM_CLASSES))
        # Placeholder tensor for the dropout rate
        keep_prob = tf.placeholder("float")

        # Call inference() to build the model
        logits = inference(images_placeholder, keep_prob)
        # Call loss() to compute the loss
        loss_value = loss(logits, labels_placeholder)
        # Call training() to build the training op
        train_op = training(loss_value, FLAGS.learning_rate)
        # Compute the accuracy
        acc = accuracy(logits, labels_placeholder)

        # Prepare the saver
        saver = tf.train.Saver()
        # Create the session
        sess = tf.Session()
        # Initialize the variables
        sess.run(tf.initialize_all_variables())
        # Set up the values to display in TensorBoard
        summary_op = tf.merge_all_summaries()
        summary_writer = tf.train.SummaryWriter(
            FLAGS.train_dir, sess.graph_def)

        # Run the training
        for step in range(FLAGS.max_steps):
            for i in range(len(train_image) / FLAGS.batch_size):
                # Train on one batch_size worth of images
                batch = FLAGS.batch_size * i
                # Supply the placeholder data through feed_dict
                sess.run(train_op, feed_dict={
                    images_placeholder: train_image[batch:batch + FLAGS.batch_size],
                    labels_placeholder: train_label[batch:batch + FLAGS.batch_size],
                    keep_prob: 0.5})

            # Compute the accuracy after every step
            train_accuracy = sess.run(acc, feed_dict={
                images_placeholder: train_image,
                labels_placeholder: train_label,
                keep_prob: 1.0})
            print("step %d, training accuracy %g" % (step, train_accuracy))

            # Append the TensorBoard values after every step
            summary_str = sess.run(summary_op, feed_dict={
                images_placeholder: train_image,
                labels_placeholder: train_label,
                keep_prob: 1.0})
            summary_writer.add_summary(summary_str, step)

    # Print the accuracy on the test data once training finishes
    print("test accuracy %g" % sess.run(acc, feed_dict={
        images_placeholder: test_image,
        labels_placeholder: test_label,
        keep_prob: 1.0}))

    # Save the final model
    save_path = saver.save(sess, "model.ckpt")
