# List the local devices TensorFlow can see.

from tensorflow.python.client import device_lib
results = device_lib.list_local_devices()
print(results)
