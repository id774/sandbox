# is_device_type_gpu.py: List the local devices TensorFlow can see
#
# Description:
# List the local devices TensorFlow can see.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 is_device_type_gpu.py
#
# Requirements:
# - Python 3
# - TensorFlow
#

from tensorflow.python.client import device_lib
results = device_lib.list_local_devices()
print(results)
