import os
import sys
from contextlib import contextmanager
from numba import cuda
import time


def init():
    # Suppress printing debug info
    if os.getenv('NO_DEBUG') is not None:
        sys.stdout = open(os.devnull, 'w')


@contextmanager
def allocated_gpu():
    print("Available GPUs:")
    for gpu_device in cuda.gpus.lst:
        print("{} [CC: {}.{}]".format(gpu_device.name.decode(), *gpu_device.compute_capability))

        if cuda.gpus.current is None:
            print("No active GPU device.")
            if len(cuda.gpus.lst) == 0:
                raise RuntimeError("No available GPUs.")
            print("Selecting first available")
            cuda.select_device(cuda.gpus.lst[0].id)

    gpu = cuda.gpus.current  # https://github.com/numba/numba/blob/master/numba/cuda/cudadrv/enums.py#L303
    print()
    print("Current GPU:")
    print("name = %s" % gpu.name.decode())
    print("maxThreadsPerBlock = %s" % str(gpu.MAX_THREADS_PER_BLOCK))
    print("maxBlockDimX = %s" % str(gpu.MAX_BLOCK_DIM_X))
    print("maxBlockDimY = %s" % str(gpu.MAX_BLOCK_DIM_Y))
    print("maxBlockDimZ = %s" % str(gpu.MAX_BLOCK_DIM_Z))
    print("maxGridDimX = %s" % str(gpu.MAX_GRID_DIM_X))
    print("maxGridDimY = %s" % str(gpu.MAX_GRID_DIM_Y))
    print("maxGridDimZ = %s" % str(gpu.MAX_GRID_DIM_Z))
    print("maxSharedMemoryPerBlock = %s" % str(gpu.MAX_SHARED_MEMORY_PER_BLOCK))
    print("asyncEngineCount = %s" % str(gpu.ASYNC_ENGINE_COUNT))
    print("canMapHostMemory = %s" % str(gpu.CAN_MAP_HOST_MEMORY))
    print("multiProcessorCount = %s" % str(gpu.MULTIPROCESSOR_COUNT))
    print("warpSize = %s" % str(gpu.WARP_SIZE))
    print("unifiedAddressing = %s" % str(gpu.UNIFIED_ADDRESSING))
    print("pciBusID = %s" % str(gpu.PCI_BUS_ID))
    print("pciDeviceID = %s" % str(gpu.PCI_DEVICE_ID))
    print()

    yield gpu
    cuda.close()


@contextmanager
def timed(suffix=None):
    start = time.time()
    yield
    end = time.time() - start
    print(
        "Time to calculate{}: {}ms".format(' ' + suffix if suffix is not None else '', int(end * 1000)),
        file=sys.__stdout__
    )


