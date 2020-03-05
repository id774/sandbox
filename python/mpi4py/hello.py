from mpi4py import MPI
import os

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

prefix = '[%s]' % os.uname()[1]

print(f"Hello, world! from rank {rank} out of {size} on {prefix}")
