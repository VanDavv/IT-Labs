#include	<stdio.h>
#include	<assert.h> 
#include	<cuda.h>
#include	<math.h>

#define N 13
#define BLK_SZ 128
#define CALL(x)	{int r=x;\
		if(r!=0){fprintf(stderr,"%s returned %d in line %d -- exiting.\n",#x,r,__LINE__);\
		exit(0);}} 

#define ALIGN_UP(offset, alignment)  (offset) = ((offset) + (alignment) - 1) & ~((alignment) - 1)

float    HostVectX[N];
float    HostVectA[N];

float fun(float x) {
	return pow(x, x);
}

int main(int argc, char *argv[]) {

	int i;
	float x;
	int blocks = N / BLK_SZ;
        if(N % BLK_SZ) blocks++;

        for(i = 0; i < N; i++) {
            HostVectX[i] = (float)i;
            HostVectA[i] = 2;
        }

	CUdevice	hDevice;
	CUcontext	hContext;
	CUmodule	hModule;
	CUfunction	hFunction;

	CALL( cuInit(0) );
	CALL( cuDeviceGet(&hDevice, 0) ); 	
	CALL( cuCtxCreate(&hContext, 0, hDevice) );
	CALL( cuModuleLoad(&hModule, "kernel2.cubin") );
	CALL( cuModuleGetFunction(&hFunction, hModule, "KERN") );

	CUdeviceptr DevVectX;
	CUdeviceptr DevVectA;

	CALL( cuMemAlloc(&DevVectX, sizeof(HostVectX)) );
	CALL( cuMemcpyHtoD(DevVectX, HostVectX, sizeof(HostVectX)) );

	CALL( cuMemAlloc(&DevVectA, sizeof(HostVectA)) );
	CALL( cuMemcpyHtoD(DevVectA, HostVectA, sizeof(HostVectA)) );

	CALL( cuFuncSetBlockShape(hFunction, BLK_SZ, 1, 1) );

	int 	offset = 0;
	void   *ptr;

	ptr = (void*)(size_t)N;
	ALIGN_UP(offset, __alignof(ptr));
	CALL( cuParamSetv(hFunction, offset, &ptr, sizeof(ptr)) );
	offset += sizeof(ptr);

	ptr = (void*)(size_t)DevVectX;
	ALIGN_UP(offset, __alignof(ptr));
	CALL( cuParamSetv(hFunction, offset, &ptr, sizeof(ptr)) );
	offset += sizeof(ptr);

	ptr = (void*)(size_t)DevVectA;
	ALIGN_UP(offset, __alignof(ptr));
	CALL( cuParamSetv(hFunction, offset, &ptr, sizeof(ptr)) );
	offset += sizeof(ptr);

	CALL( cuParamSetSize(hFunction, offset) );

	CALL( cuLaunchGrid(hFunction, blocks, 1) );

	CALL( cuMemcpyDtoH((void *) HostVectX, DevVectX, sizeof(HostVectX)) );
	CALL( cuMemcpyDtoH((void *) HostVectA, DevVectA, sizeof(HostVectA)) );

	CALL( cuMemFree(DevVectX) );
	CALL( cuMemFree(DevVectA) );

	float result = 0.0;

	for(i = 0; i < N; i++) {
	    result += HostVectX[i];
        printf("X: %f  VectX: %f  VectA: %f\n", (float)i, HostVectX[i], HostVectA[i]);
	}

	printf("Result: %f\n", result);
	puts("done");
	return 0;
}

