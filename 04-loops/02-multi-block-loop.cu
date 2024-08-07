#include <stdio.h>

__global__ void loop(int N)
{
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  printf("This is iteration number %d\n", i);
}

int main()
{
  int N = 10;
  loop<<<5,2>>>(N);
  cudaDeviceSynchronize();
}
