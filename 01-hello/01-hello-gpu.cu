#include <stdio.h>

void helloCPU()
{
  printf("Hello from the CPU.\n");
}

__global__ void helloGPU()
{
  printf("Hello also from the CPU.\n");
}

int main()
{

  helloCPU();
  helloGPU<<<1,1>>>();

  cudaDeviceSynchronize();
}
