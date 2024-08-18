# Cuda Error handling

1. syncErr = cudaGetLastError();
2. asyncErr = cudaDeviceSynchronize();

> 에러를 받을 변수를 선언해주면서 error를 프린트

```cuda
  if (syncErr != cudaSuccess) printf("Error: %s\n", cudaGetErrorString(syncErr));
  if (asyncErr != cudaSuccess) printf("Error: %s\n", cudaGetErrorString(asyncErr));
```

# error handling method

```cuda
#include <assert.h>

inline cudaError_t checkCuda(cudaError_t result)
{
  if (result != cudaSuccess) {
    fprintf(stderr, "CUDA Runtime Error: %s\n", cudaGetErrorString(result));
    assert(result == cudaSuccess);
  }
  return result;
}

```

> index, stride 활용 값 넣기

```cuda
__global__
void addVectorsInto(float *result, float *a, float *b, int N)
{
  int index = threadIdx.x + blockIdx.x * blockDim.x;
  int stride = blockDim.x * gridDim.x;

  for(int i = index; i < N; i += stride)
  {
    result[i] = a[i] + b[i];
  }
}
```

> cuda free도 존재

```cuda
  checkCuda( cudaFree(a) );
```