# cuda loop

```c
#include <stdio.h>

__global__ void loop(int N)
{ 
  printf("This is iteration number %d\n", threadIdx.x);
}

int main()
{

  int N = 10;
  loop<<<1,10>>>(N);
  cudaDeviceSynchronize();
}
```

> 중요한 점은 global 함수는 항상 return 값이 void여야 한다는 점.
> box 인덱스와 thread 인덱스로 i값 계산
> boxIndex뒤에 x를 붙여야함.

![image](https://github.com/user-attachments/assets/9248efcb-c513-4722-9e2c-5d82228b3b8e)

```c
// blockDim.x 활용
#include <stdio.h>

__global__ void loop(int N)
{
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  printf("This is iteration number %d\n", i);
}

int main()
{
  int N = 10;
  loop<<5,2>>(N);
}

```
