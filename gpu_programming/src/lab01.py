import os
import sys
from numba import cuda

import numpy as np

from common import allocated_gpu, timed

N = int(sys.argv[1]) if len(sys.argv) > 1 else 1000
print("N = {}".format(N))

# Suppress printing debug info
if os.getenv('NO_DEBUG') is not None:
    sys.stdout = open(os.devnull, 'w')


@cuda.jit
def calculate_gpu(A):
    i = cuda.grid(1)

    if i < A.size:
        A[i] = A[i] * A[i] * A[i] + A[i] * A[i] + A[i]


def calculate_cpu(A):
    for i in range(A.size):
        A[i] = A[i] * A[i] * A[i] + A[i] * A[i] + A[i]


with allocated_gpu() as gpu:
    threadsperblock = gpu.MAX_THREADS_PER_BLOCK
    blockspergrid = (N + (threadsperblock - 1)) // threadsperblock

    an_array = np.arange(N, dtype=np.float32) + 1
    print(an_array[:10])

    with timed("on GPU"):
        calculate_gpu[blockspergrid, threadsperblock](an_array)

    print(an_array[:10])

    an_array = np.arange(N, dtype=np.float32) + 1

    with timed("on CPU"):
        calculate_cpu(an_array)
    print(an_array[:10])

    an_array = np.arange(N, dtype=np.float32) + 1

    with cuda.profiling():
        calculate_gpu[blockspergrid, threadsperblock](an_array)
