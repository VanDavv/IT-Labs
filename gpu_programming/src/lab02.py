import math

import numpy as np
from PIL import Image
from numba import cuda, types

from common import allocated_gpu, timed, init

init()


@cuda.jit(debug=True)
def calculate_gpu(arr, out):
    x, y, z = cuda.grid(3)
    if x < out.shape[0] and y < out.shape[1] and z < out.shape[2]:
        row_from = max(x - 1, 0)
        row_to = x + 2
        col_from = max(y - 1, 0)
        col_to = y + 2
        slice = arr[row_from:row_to, col_from:col_to, z]
        flat_slice = cuda.local.array(shape=9, dtype=types.uint8)

        for i in range(slice.shape[0]):
            for j in range(slice.shape[1]):
                flat_slice[(j-1) * slice.shape[0] + i] = slice[i, j]

        for i in range(slice.size):
            for j in range(0, slice.size - i - 1):
                if flat_slice[j] < flat_slice[j + 1]:
                    flat_slice[j], flat_slice[j + 1] = flat_slice[j + 1], flat_slice[j]

        if slice.size % 2 == 0:
            upper = int(slice.size / 2)
            lower = upper - 1
            out[x, y, z] = (flat_slice[upper] + flat_slice[lower]) / 2
        else:
            out[x, y, z] = flat_slice[slice.size // 2]


im_array = np.array(Image.open("lab02img.bmp")).astype(np.uint8)

with allocated_gpu() as gpu:
    threadsperblock = (
        math.floor(math.sqrt(gpu.MAX_THREADS_PER_BLOCK / (2 * im_array.shape[2]))),
        math.floor(math.sqrt(gpu.MAX_THREADS_PER_BLOCK / (2 * im_array.shape[2]))),
        im_array.shape[2]
    )

    blockspergrid = (
        math.ceil(im_array.shape[0] / threadsperblock[0]),
        math.ceil(im_array.shape[1] / threadsperblock[1])
    )

    result = np.zeros(shape=(im_array.shape[0], im_array.shape[1], im_array.shape[2]))
    with cuda.profiling(), timed("on GPU"):
        calculate_gpu[blockspergrid, threadsperblock](im_array, result)

    Image.fromarray(result.astype(np.uint8), 'RGB').save('lab02result.bmp')
