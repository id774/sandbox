# Evaluate a constant through a TensorFlow session.

import tensorflow as tf

hello = tf.constant('Hello, TensorFlow!')
s = tf.Session()
print(s.run(hello))
