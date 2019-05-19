import math

import numpy as np
from PIL import Image
from numba import cuda, types
from common import allocated_gpu, timed, init

init()


@cuda.jit()
def calculate_gpu(x, n, factors, out):
    pos = cuda.grid(1)
    if pos < factors.shape[0]:
        val = factors[pos] * math.pow(x, pos)
        cuda.atomic.add(out, 0, val)


wages = np.array([1] * 10)

with allocated_gpu() as gpu:
    threadsperblock = gpu.MAX_THREADS_PER_BLOCK
    blockspergrid = (wages.size + (threadsperblock - 1)) // threadsperblock

    gpu_result = np.array([0])
    calculate_gpu[blockspergrid, threadsperblock](12, len(wages), wages, gpu_result)
    print(gpu_result, gpu_result[0], type(gpu_result[0]))
