import math

import numpy as np
from PIL import Image
from numba import cuda, types
from common import allocated_gpu, timed, init

init()


@cuda.jit()
def calculate_gpu(arr, out, fact):
    x = cuda.grid(1)
    if x < out.shape[0]:
        out[x] = arr[x] ** fact


def calculate_cpu(arr, fact):
    return arr ** fact


in_array = np.array([1.01 * i for i in range(1, 11)])

with allocated_gpu() as gpu:
    threadsperblock = gpu.MAX_THREADS_PER_BLOCK
    blockspergrid = (in_array.size + (threadsperblock - 1)) // threadsperblock

    print("Input: {}; Operation: pow(array, factor)".format(in_array))
    for factor in range(1, 21):
        gpu_result = np.zeros(in_array.size)
        calculate_gpu[blockspergrid, threadsperblock](in_array, gpu_result, factor)
        cpu_result = calculate_cpu(in_array, factor)
        diff = gpu_result - cpu_result
        print("[Factor: {}] Mean: {}\t Max: {}\tMin: {}".format(factor, diff.mean(), diff.max(), diff.min()))

