# hello.py: MPI rank, size, and host name from each process
#
# Description:
# Print the MPI rank, size, and host name from each process.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     mpiexec -n 4 python3 hello.py
#
# Requirements:
# - Python 3
# - mpi4py and an MPI implementation that provides mpiexec
#

from mpi4py import MPI
import os

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

prefix = '[%s]' % os.uname()[1]

print(f"Hello, world! from rank {rank} out of {size} on {prefix}")
