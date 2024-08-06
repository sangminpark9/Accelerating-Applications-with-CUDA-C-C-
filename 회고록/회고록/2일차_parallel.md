2일차_parallel

# cuda debug 모드

```shell
docker debug <컨테이너명>
```

1. 디버그 환경 생성: Docker는 대상 컨테이너와 동일한 네임스페이스를 공유하는 별도의 디버그 환경을 생성
2. 도구 설치: strace, gdb, tcpdump와 같은 일반적인 디버깅 도구를 이 환경에 설치
3. 인터랙티브 셸 제공: 디버그 환경에서 인터랙티브 셸을 제공하여 필요한 디버깅 작업을 수행

- 근데 중요한점은 pro나 teams or Business Subcription 등 유로 버전을 사용해야한다.

직접적으로 명령어나 치자

```shell
docker cp ./파일명 <컨테이너이름>:/경로
docker exec -it <컨테이너명> nvcc -o 결과물이름 /디버그할파일
docker exec -it <컨테이너명> /결과물
```

```cuda
#include <stdio.h>

__global__ void firstParallel()
{
  printf("This should be running in parallel.\n");
}

int main()
{
  firstParallel<<<1,2>>>();
  cudaDeviceSynchronize();
}
```

> 여기서 1박스 2그리드로 2번만 print가 될 것인데,
> <<<5,5>>> 하게되면 25번이 될 것이다.
> 1박스당 5번 출력, 5박스

![image](https://github.com/user-attachments/assets/b8ce0412-a463-4a47-86bb-e3c2a977bd30)

# index, box, thread

1. 1일차에 언급한 박스, 쓰레드 개념
2. <<<>>> 문법 안에 박승놔 쓰레드 갯수를 입력할 수 있는데, 각각의 인덱스를 지님


```cuda
#include <stdio.h>

__global__ void printSuccessForCorrectExecutionConfiguration()
{

  if(threadIdx.x == 1023 && blockIdx.x == 255)
  {
    printf("Success!\n");
  } else {
    printf("Failure. Update the execution configuration as necessary.\n");
  }
}

int main()
{
  /*
   * Update the execution configuration so that the kernel
   * will print `"Success!"`.
   */

  printSuccessForCorrectExecutionConfiguration<<<256,4>>>();
  // 꼭 잊지말자 cudaDeviceSynchronize
  cudaDeviceSynchronize();
}

```