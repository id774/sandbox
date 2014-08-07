# -*- coding: utf-8 -*-

# http://www.kde.cs.tut.ac.jp/~atsushi/?p=468

import scipy.linalg
import numpy
	 
def svd(A, num_sigval):
  num_dimension = A.shape[0]
  num_sample = A.shape[1]
  B = numpy.dot(A, A.T)
  eigen_value, eigen_vector = scipy.linalg.eigh(B,
    eigvals=(num_dimension - num_sigval, num_dimension - 1))
  eigen_id = numpy.argsort(eigen_value)[::-1]
  U = eigen_vector[:,eigen_id]
  s = numpy.sqrt(eigen_value[eigen_id])
  V = numpy.dot(A.T, U * (1.0 / s)).T
  return U, s, V

def main():
  X = numpy.random.randn(3,5)
  print("X=")
  print(X)
  print()

  U, s, V = svd(X,2)
  print("svd")
  print("U=")
  print(U)
  print("s=")
  print(s)
  print("V=")
  print(V)
  print()

  U, s, V = scipy.linalg.svd(X)
  print("scipy.linalg.svd")
  print("U=")
  print(U)
  print("s=")
  print(s)
  print("V=")
  print(V)

if __name__ == "__main__":
  main()
