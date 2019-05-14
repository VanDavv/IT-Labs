import sys
from numba import cuda

import numpy as np

from common import allocated_gpu, timed, init

N = int(sys.argv[1]) if len(sys.argv) > 1 else 1000000
print("N = {}".format(N))

init()


@cuda.jit
def calculate_gpu(A):
    i = cuda.grid(1)

    if i < A.size:
        tmp = 4 * A[i] ** 2
        A[i] = tmp / (tmp - 1)


def calculate_cpu(A):
    for i in range(A.size):
        tmp = 4 * A[i] ** 2
        A[i] = tmp / (tmp - 1)


with allocated_gpu() as gpu:
    threadsperblock = gpu.MAX_THREADS_PER_BLOCK
    blockspergrid = (N + (threadsperblock - 1)) // threadsperblock

    an_array = np.arange(N, dtype=np.float32) + 1
    with cuda.profiling(), timed("on GPU"):
        calculate_gpu[blockspergrid, threadsperblock](an_array)
    print(np.prod(an_array))

    an_array = np.arange(N, dtype=np.float32) + 1
    with timed("on CPU"):
        calculate_cpu(an_array)

    with timed("to multiply"):
        print(np.prod(an_array))

