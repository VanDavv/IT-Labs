// g++ -std=c++11 -lgomp -fopenmp -O3 -lm lab01.cpp
#include <iostream>
#include <omp.h>
#include <cstdlib>
#include <ctime>

using namespace std;
static const int N = 2500;


// schedule na następne
int main(int argc, char **argv) {
  srand((unsigned)time(0));
  int threads = atoi(argv[1]);
  auto A = new int[N][N]();
  auto B = new int[N][N]();
  auto C = new int[N][N]();

  for(int x = 0; x < N; x++) {
    for(int y = 0; y < N; y++) {
      A[x][y] = (rand()%6)+1;
      B[x][y] = (rand()%6)+1;
    }
  }

  double start = omp_get_wtime();
  #pragma omp parallel for num_threads(threads)
  for(int x = 0; x < N; x++) {
    for(int y = 0; y < N; y++) {
      for(int i = 0; i < N; i++) {
        C[x][y] += A[x][i] * B[i][y];
      }
    }
  }
  double end = omp_get_wtime();
  printf("[%d] Time: %f\n", threads, end - start);
  return 0;
}