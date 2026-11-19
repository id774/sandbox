# hello2.py: Evaluate a constant and an addition in a TensorFlow session
#
# Description:
# Evaluate a constant and an addition through a TensorFlow session.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 hello2.py
#
# Requirements:
# - Python 3
# - TensorFlow 1.x, which provides tf.Session
#

import tensorflow as tf

hello = tf.constant('Hello, TensorFlow!')
sess = tf.Session()
print(sess.run(hello))
a = tf.constant(10)
b = tf.constant(32)
print(sess.run(a + b))
sess.close()
