# Machine specs

### CPU
```
$ lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
Address sizes:       39 bits physical, 48 bits virtual
CPU(s):              8
On-line CPU(s) list: 0-7
Thread(s) per core:  2
Core(s) per socket:  4
Socket(s):           1
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               158
Model name:          Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz
Stepping:            9
CPU MHz:             800.078
CPU max MHz:         3800,0000
CPU min MHz:         800,0000
BogoMIPS:            5618.00
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            6144K
NUMA node0 CPU(s):   0-7
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp flush_l1d
```
###GPU
```
$ nvidia-smi    
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 418.43       Driver Version: 418.43       CUDA Version: 10.1     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 1050    Off  | 00000000:01:00.0 Off |                  N/A |
| N/A   45C    P0    N/A /  N/A |      0MiB /  4042MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```
```
Available GPUs:
GeForce GTX 1050 [CC: 6.1]

Current GPU:
name = GeForce GTX 1050
maxThreadsPerBlock = 1024
maxBlockDimX = 1024
maxBlockDimY = 1024
maxBlockDimZ = 64
maxGridDimX = 2147483647
maxGridDimY = 65535
maxGridDimZ = 65535
maxSharedMemoryPerBlock = 49152
asyncEngineCount = 2
canMapHostMemory = 1
multiProcessorCount = 5
warpSize = 32
unifiedAddressing = 1
pciBusID = 1
pciDeviceID = 0
```

# Results

## Lab 01

### 1.1
```
N = 1000000
Available GPUs:
GeForce GTX 1050 [CC: 6.1]
No active GPU device.
Selecting first available

Current GPU:
name = GeForce GTX 1050
maxThreadsPerBlock = 1024
maxBlockDimX = 1024
maxBlockDimY = 1024
maxBlockDimZ = 64
maxGridDimX = 2147483647
maxGridDimY = 65535
maxGridDimZ = 65535
maxSharedMemoryPerBlock = 49152
asyncEngineCount = 2
canMapHostMemory = 1
multiProcessorCount = 5
warpSize = 32
unifiedAddressing = 1
pciBusID = 1
pciDeviceID = 0

[ 1.  2.  3.  4.  5.  6.  7.  8.  9. 10.]
Time to calculate on GPU: 325ms
[   3.   14.   39.   84.  155.  258.  399.  584.  819. 1110.]
Time to calculate on CPU: 2570ms
[   3.   14.   39.   84.  155.  258.  399.  584.  819. 1110.]
```


### 1.1 profiling

```
N = 10
==10== NVPROF is profiling process 10, command: python lab01_1.py 10
Time to calculate on GPU: 226ms
Time to calculate on CPU: 0ms
==10== Profiling application: python lab01_1.py 10
==10== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   57.21%  3.8080us         2  1.9040us  1.3760us  2.4320us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   22.12%  1.4720us         2     736ns     736ns     736ns  [CUDA memcpy DtoH]
                   20.67%  1.3760us         2     688ns     576ns     800ns  [CUDA memcpy HtoD]
N = 100
==24== NVPROF is profiling process 24, command: python lab01_1.py 100
Time to calculate on GPU: 143ms
Time to calculate on CPU: 0ms
==24== Profiling application: python lab01_1.py 100
==24== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   85.99%  18.272us         2  9.1360us  1.4080us  16.864us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                    7.23%  1.5360us         2     768ns     768ns     768ns  [CUDA memcpy DtoH]
                    6.78%  1.4400us         2     720ns     640ns     800ns  [CUDA memcpy HtoD]
N = 500
==38== NVPROF is profiling process 38, command: python lab01_1.py 500
Time to calculate on GPU: 139ms
Time to calculate on CPU: 1ms
==38== Profiling application: python lab01_1.py 500
==38== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   54.02%  3.8720us         2  1.9360us  1.4080us  2.4640us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   23.21%  1.6640us         2     832ns     832ns     832ns  [CUDA memcpy DtoH]
                   22.77%  1.6320us         2     816ns     768ns     864ns  [CUDA memcpy HtoD]
N = 1000
==52== NVPROF is profiling process 52, command: python lab01_1.py 1000
Time to calculate on GPU: 141ms
Time to calculate on CPU: 2ms
==52== Profiling application: python lab01_1.py 1000
==52== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   48.32%  3.6800us         2  1.8400us  1.3440us  2.3360us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   26.05%  1.9840us         2     992ns     992ns     992ns  [CUDA memcpy HtoD]
                   25.63%  1.9520us         2     976ns     896ns  1.0560us  [CUDA memcpy DtoH]
N = 5000
==66== NVPROF is profiling process 66, command: python lab01_1.py 5000
Time to calculate on GPU: 143ms
Time to calculate on CPU: 11ms
==66== Profiling application: python lab01_1.py 5000
==66== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   56.77%  12.480us         2  6.2400us  1.3120us  11.168us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   24.31%  5.3440us         2  2.6720us  2.6560us  2.6880us  [CUDA memcpy HtoD]
                   18.92%  4.1600us         2  2.0800us  2.0800us  2.0800us  [CUDA memcpy DtoH]
N = 10000
==80== NVPROF is profiling process 80, command: python lab01_1.py 10000
Time to calculate on GPU: 148ms
Time to calculate on CPU: 22ms
==80== Profiling application: python lab01_1.py 10000
==80== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   46.35%  9.5360us         2  4.7680us  4.7680us  4.7680us  [CUDA memcpy HtoD]
                   34.84%  7.1680us         2  3.5840us  3.5840us  3.5840us  [CUDA memcpy DtoH]
                   18.82%  3.8720us         2  1.9360us  1.4400us  2.4320us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
N = 50000
==94== NVPROF is profiling process 94, command: python lab01_1.py 50000
Time to calculate on GPU: 140ms
Time to calculate on CPU: 104ms
==94== Profiling application: python lab01_1.py 50000
==94== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   43.93%  33.248us         2  16.624us  16.352us  16.896us  [CUDA memcpy HtoD]
                   42.37%  32.064us         2  16.032us  16.032us  16.032us  [CUDA memcpy DtoH]
                   13.70%  10.368us         2  5.1840us  4.7040us  5.6640us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
N = 100000
==108== NVPROF is profiling process 108, command: python lab01_1.py 100000
Time to calculate on GPU: 141ms
Time to calculate on CPU: 217ms
==108== Profiling application: python lab01_1.py 100000
==108== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   43.99%  64.416us         2  32.208us  31.776us  32.640us  [CUDA memcpy HtoD]
                   43.29%  63.393us         2  31.696us  31.680us  31.713us  [CUDA memcpy DtoH]
                   12.72%  18.624us         2  9.3120us  9.1840us  9.4400us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
N = 500000
==122== NVPROF is profiling process 122, command: python lab01_1.py 500000
Time to calculate on GPU: 164ms
Time to calculate on CPU: 1108ms
==122== Profiling application: python lab01_1.py 500000
==122== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   46.44%  408.26us         2  204.13us  184.38us  223.87us  [CUDA memcpy HtoD]
                   41.89%  368.29us         2  184.15us  170.66us  197.63us  [CUDA memcpy DtoH]
                   11.67%  102.62us         2  51.312us  50.912us  51.712us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
N = 1000000
==139== NVPROF is profiling process 139, command: python lab01_1.py 1000000
Time to calculate on GPU: 154ms
Time to calculate on CPU: 2165ms
==139== Profiling application: python lab01_1.py 1000000
==139== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   46.34%  815.36us         2  407.68us  400.19us  415.17us  [CUDA memcpy DtoH]
                   42.11%  740.99us         2  370.50us  356.13us  384.87us  [CUDA memcpy HtoD]
                   11.55%  203.23us         2  101.62us  101.47us  101.76us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
N = 5000000
==156== NVPROF is profiling process 156, command: python lab01_1.py 5000000
Time to calculate on GPU: 168ms
Time to calculate on CPU: 10873ms
==156== Profiling application: python lab01_1.py 5000000
==156== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   47.98%  5.0094ms         2  2.5047ms  2.1548ms  2.8546ms  [CUDA memcpy DtoH]
                   42.40%  4.4262ms         2  2.2131ms  2.1090ms  2.3172ms  [CUDA memcpy HtoD]
                    9.62%  1.0041ms         2  502.07us  501.44us  502.69us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
N = 10000000
==173== NVPROF is profiling process 173, command: python lab01_1.py 10000000
Time to calculate on GPU: 160ms
Time to calculate on CPU: 21386ms
==173== Profiling application: python lab01_1.py 10000000
==173== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   45.49%  8.5929ms         2  4.2965ms  4.2913ms  4.3016ms  [CUDA memcpy DtoH]
                   43.89%  8.2904ms         2  4.1452ms  4.1074ms  4.1830ms  [CUDA memcpy HtoD]
                   10.62%  2.0066ms         2  1.0033ms  1.0031ms  1.0034ms  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
N = 50000000
==190== NVPROF is profiling process 190, command: python lab01_1.py 50000000
Time to calculate on GPU: 198ms
Time to calculate on CPU: 129428ms
==190== Profiling application: python lab01_1.py 50000000
==190== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   45.35%  42.959ms         2  21.479ms  21.431ms  21.528ms  [CUDA memcpy DtoH]
                   44.08%  41.752ms         2  20.876ms  20.601ms  21.151ms  [CUDA memcpy HtoD]
                   10.57%  10.015ms         2  5.0074ms  5.0006ms  5.0142ms  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
N = 100000000
==207== NVPROF is profiling process 207, command: python lab01_1.py 100000000
Time to calculate on GPU: 276ms
Time to calculate on CPU: 258626ms
==207== Profiling application: python lab01_1.py 100000000
==207== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   45.46%  87.958ms         2  43.979ms  43.686ms  44.272ms  [CUDA memcpy DtoH]
                   44.19%  85.501ms         2  42.751ms  42.463ms  43.038ms  [CUDA memcpy HtoD]
                   10.35%  20.022ms         2  10.011ms  10.006ms  10.016ms  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
```

### 1.2

```
N = 1000000
Available GPUs:
GeForce GTX 1050 [CC: 6.1]
No active GPU device.
Selecting first available

Current GPU:
name = GeForce GTX 1050
maxThreadsPerBlock = 1024
maxBlockDimX = 1024
maxBlockDimY = 1024
maxBlockDimZ = 64
maxGridDimX = 2147483647
maxGridDimY = 65535
maxGridDimZ = 65535
maxSharedMemoryPerBlock = 49152
asyncEngineCount = 2
canMapHostMemory = 1
multiProcessorCount = 5
warpSize = 32
unifiedAddressing = 1
pciBusID = 1
pciDeviceID = 0

Time to calculate on GPU: 284ms
1.5706748
Time to calculate on CPU: 5194ms
1.5706748
Time to calculate to multiply: 1ms
```

### 1.2 profiling

```
N = 10
==10== NVPROF is profiling process 10, command: python lab01_2.py 10
Time to calculate on GPU: 266ms
Time to calculate on CPU: 0ms
Time to calculate to multiply: 0ms
==10== Profiling application: python lab01_2.py 10
==10== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   65.96%  2.9760us         1  2.9760us  2.9760us  2.9760us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   17.73%     800ns         1     800ns     800ns     800ns  [CUDA memcpy HtoD]
                   16.31%     736ns         1     736ns     736ns     736ns  [CUDA memcpy DtoH]
N = 100
==24== NVPROF is profiling process 24, command: python lab01_2.py 100
Time to calculate on GPU: 212ms
Time to calculate on CPU: 2ms
Time to calculate to multiply: 0ms
==24== Profiling application: python lab01_2.py 100
==24== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   64.75%  2.8800us         1  2.8800us  2.8800us  2.8800us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   17.99%     800ns         1     800ns     800ns     800ns  [CUDA memcpy HtoD]
                   17.27%     768ns         1     768ns     768ns     768ns  [CUDA memcpy DtoH]
N = 500
==38== NVPROF is profiling process 38, command: python lab01_2.py 500
Time to calculate on GPU: 207ms
Time to calculate on CPU: 11ms
Time to calculate to multiply: 0ms
==38== Profiling application: python lab01_2.py 500
==38== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   67.50%  3.4560us         1  3.4560us  3.4560us  3.4560us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   16.88%     864ns         1     864ns     864ns     864ns  [CUDA memcpy HtoD]
                   15.62%     800ns         1     800ns     800ns     800ns  [CUDA memcpy DtoH]
N = 1000
==52== NVPROF is profiling process 52, command: python lab01_2.py 1000
Time to calculate on GPU: 200ms
Time to calculate on CPU: 23ms
Time to calculate to multiply: 0ms
==52== Profiling application: python lab01_2.py 1000
==52== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   69.59%  4.3200us         1  4.3200us  4.3200us  4.3200us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   15.98%     992ns         1     992ns     992ns     992ns  [CUDA memcpy HtoD]
                   14.43%     896ns         1     896ns     896ns     896ns  [CUDA memcpy DtoH]
N = 5000
==66== NVPROF is profiling process 66, command: python lab01_2.py 5000
Time to calculate on GPU: 202ms
Time to calculate on CPU: 106ms
Time to calculate to multiply: 0ms
==66== Profiling application: python lab01_2.py 5000
==66== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   47.70%  4.3200us         1  4.3200us  4.3200us  4.3200us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   29.33%  2.6560us         1  2.6560us  2.6560us  2.6560us  [CUDA memcpy HtoD]
                   22.97%  2.0800us         1  2.0800us  2.0800us  2.0800us  [CUDA memcpy DtoH]
N = 10000
==80== NVPROF is profiling process 80, command: python lab01_2.py 10000
Time to calculate on GPU: 200ms
Time to calculate on CPU: 170ms
Time to calculate to multiply: 0ms
==80== Profiling application: python lab01_2.py 10000
==80== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   45.64%  7.0400us         1  7.0400us  7.0400us  7.0400us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   30.91%  4.7680us         1  4.7680us  4.7680us  4.7680us  [CUDA memcpy HtoD]
                   23.44%  3.6160us         1  3.6160us  3.6160us  3.6160us  [CUDA memcpy DtoH]
N = 50000
==94== NVPROF is profiling process 94, command: python lab01_2.py 50000
Time to calculate on GPU: 198ms
Time to calculate on CPU: 393ms
Time to calculate to multiply: 0ms
==94== Profiling application: python lab01_2.py 50000
==94== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   46.53%  28.928us         1  28.928us  28.928us  28.928us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   27.59%  17.152us         1  17.152us  17.152us  17.152us  [CUDA memcpy HtoD]
                   25.89%  16.096us         1  16.096us  16.096us  16.096us  [CUDA memcpy DtoH]
N = 100000
==108== NVPROF is profiling process 108, command: python lab01_2.py 100000
Time to calculate on GPU: 219ms
Time to calculate on CPU: 635ms
Time to calculate to multiply: 0ms
==108== Profiling application: python lab01_2.py 100000
==108== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   46.82%  56.227us         1  56.227us  56.227us  56.227us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   26.62%  31.969us         1  31.969us  31.969us  31.969us  [CUDA memcpy DtoH]
                   26.57%  31.905us         1  31.905us  31.905us  31.905us  [CUDA memcpy HtoD]
N = 500000
==122== NVPROF is profiling process 122, command: python lab01_2.py 500000
Time to calculate on GPU: 231ms
Time to calculate on CPU: 2856ms
Time to calculate to multiply: 0ms
==122== Profiling application: python lab01_2.py 500000
==122== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   44.32%  282.31us         1  282.31us  282.31us  282.31us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   28.16%  179.36us         1  179.36us  179.36us  179.36us  [CUDA memcpy DtoH]
                   27.51%  175.23us         1  175.23us  175.23us  175.23us  [CUDA memcpy HtoD]
N = 1000000
==139== NVPROF is profiling process 139, command: python lab01_2.py 1000000
Time to calculate on GPU: 215ms
Time to calculate on CPU: 5180ms
Time to calculate to multiply: 1ms
==139== Profiling application: python lab01_2.py 1000000
==139== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   41.58%  560.39us         1  560.39us  560.39us  560.39us  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   29.68%  400.07us         1  400.07us  400.07us  400.07us  [CUDA memcpy DtoH]
                   28.74%  387.33us         1  387.33us  387.33us  387.33us  [CUDA memcpy HtoD]
N = 5000000
==156== NVPROF is profiling process 156, command: python lab01_2.py 5000000
Time to calculate on GPU: 233ms
Time to calculate on CPU: 26749ms
Time to calculate to multiply: 6ms
==156== Profiling application: python lab01_2.py 5000000
==156== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   38.08%  2.7935ms         1  2.7935ms  2.7935ms  2.7935ms  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   33.49%  2.4567ms         1  2.4567ms  2.4567ms  2.4567ms  [CUDA memcpy DtoH]
                   28.44%  2.0863ms         1  2.0863ms  2.0863ms  2.0863ms  [CUDA memcpy HtoD]
N = 10000000
==173== NVPROF is profiling process 173, command: python lab01_2.py 10000000
Time to calculate on GPU: 235ms
Time to calculate on CPU: 55741ms
Time to calculate to multiply: 12ms
==173== Profiling application: python lab01_2.py 10000000
==173== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   35.34%  5.5828ms         1  5.5828ms  5.5828ms  5.5828ms  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   34.53%  5.4555ms         1  5.4555ms  5.4555ms  5.4555ms  [CUDA memcpy DtoH]
                   30.13%  4.7606ms         1  4.7606ms  4.7606ms  4.7606ms  [CUDA memcpy HtoD]
N = 50000000
==190== NVPROF is profiling process 190, command: python lab01_2.py 50000000
Time to calculate on GPU: 283ms
Time to calculate on CPU: 271391ms
Time to calculate to multiply: 58ms
==190== Profiling application: python lab01_2.py 50000000
==190== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   39.13%  27.905ms         1  27.905ms  27.905ms  27.905ms  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   31.13%  22.202ms         1  22.202ms  22.202ms  22.202ms  [CUDA memcpy DtoH]
                   29.74%  21.210ms         1  21.210ms  21.210ms  21.210ms  [CUDA memcpy HtoD]
N = 100000000
==207== NVPROF is profiling process 207, command: python lab01_2.py 100000000
Time to calculate on GPU: 359ms
Time to calculate on CPU: 547788ms
Time to calculate to multiply: 124ms
==207== Profiling application: python lab01_2.py 100000000
==207== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   37.37%  53.659ms         1  53.659ms  53.659ms  53.659ms  cudapy::__main__::calculate_gpu$241(Array<float, int=1, C, mutable, aligned>)
                   31.34%  44.996ms         1  44.996ms  44.996ms  44.996ms  [CUDA memcpy HtoD]
                   31.30%  44.938ms         1  44.938ms  44.938ms  44.938ms  [CUDA memcpy DtoH]
```