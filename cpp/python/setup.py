from distutils.core import setup, Extension
module = Extension('myupper', ['myupper.cpp'])
setup(name='myupper',
      version='1.0',
      ext_modules=[module],
     )
