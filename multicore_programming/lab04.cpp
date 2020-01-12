#include <iostream>
#include <math.h>
#include <fstream>
#include <omp.h>

#define N 7
using namespace std;

int task_id = 1;
char map[N][N] = {
-1, 0, -1, -1, -1, -1, -1,
-1, 0, -1, -1, -1, -1, -1,
-1, 0,  0,  0,  0,  0, -1,
-1, 0, -1, -1, -1,  0, -1,
-1, 0, -1, -1, -1,  0, -1,
-1, 0,  0,  0,  0,  0, -1,
-1, 0, -1, -1, -1, -1, -1,
};

omp_lock_t lock[N][N] = {};

void fun(int y, int x, int current_id);

int main()
{
    for (int x = 0; x < N; x++)
        for (int y = 0; y < N; y++) {
          omp_init_lock(&(lock[x][y]));
        }
#pragma omp parallel num_threads(8)
    fun(0, 1, 1);
    FILE *fp= fopen("new4.ppm","wb"); /* b -  binary mode */
    fprintf(fp, "P6\n#\n%d\n%d\n255\n", N, N);
    unsigned char color[3];
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++)
        {
          printf("%d ", map[i][j]);
          switch ( map[i][j] )
          {
             case -1:
                color[0] = 0;
                color[1] = 0;
                color[2] = 0;
                break;
             case 0:
                color[0] = 255;
                color[1] = 255;
                color[2] = 255;
                break;
             case 1:
                color[0] = 0;
                color[1] = 255;
                color[2] = 0;
                break;
             case 2:
                color[0] = 255;
                color[1] = 0;
                color[2] = 0;
                break;
             case 3:
                color[0] = 0;
                color[1] = 0;
                color[2] = 255;
                break;
             case 4:
                color[0] = 255;
                color[1] = 127;
                color[2] = 0;
                break;
             case 5:
                color[0] = 0;
                color[1] = 255;
                color[2] = 127;
                break;
             case 6:
                color[0] = 127;
                color[1] = 0;
                color[2] = 255;
             case 7:
                color[0] = 255;
                color[1] = 0;
                color[2] = 127;
                break;
             case 8:
                color[0] = 127;
                color[1] = 255;
                color[2] = 0;
                break;
             default:
                break;
          }
          fwrite(color, 1, 3, fp);
        }
        printf("\n");
    }
    fclose(fp);
    return 0;
}

void fun(int x, int y, int current_id)
{
    omp_set_lock(&(lock[x][y]));
    int current_value = map[x][y];
    if(current_value == 0) {
      map[x][y] = current_id;
      omp_unset_lock(&(lock[x][y]));
    } else {
      omp_unset_lock(&(lock[x][y]));
      return;
    }

    bool top, right, bottom, left = false;

    if(x > 0) {
      omp_set_lock(&(lock[x - 1][y]));
      left = map[x - 1][y] == 0;
      omp_unset_lock(&(lock[x - 1][y]));
    }
    if(x < N - 1) {
      omp_set_lock(&(lock[x + 1][y]));
      right = map[x + 1][y] == 0;
      omp_unset_lock(&(lock[x + 1][y]));
    }
    if(y > 0) {
      omp_set_lock(&(lock[x][y - 1]));
      top = map[x][y - 1] == 0;
      omp_unset_lock(&(lock[x][y - 1]));
    }
    if(y < N - 1) {
      omp_set_lock(&(lock[x][y + 1]));
      bottom = map[x][y + 1] == 0;
      omp_unset_lock(&(lock[x][y + 1]));
    }

    int sum = top + right + bottom + left;

    printf("TestTest %d %d %d %d %d\n", current_value, x, y, current_id, sum);
    if(sum == 1) {
      if(top) {
        fun(x, y - 1, current_id);
      } else if(right) {
        fun(x + 1, y, current_id);
      } else if(bottom) {
        fun(x, y + 1, current_id);
      } else if(left) {
        fun(x - 1, y, current_id);
      }
    } else if(sum > 1) {
      if(top) {
        task_id += 1;
        #pragma omp task
        fun(x, y - 1, task_id);
      }
      if(right) {
        task_id += 1;
        #pragma omp task
        fun(x + 1, y, task_id);
      }
      if(bottom) {
        task_id += 1;
        #pragma omp task
        fun(x, y + 1, task_id);
      }
      if(left) {
        task_id += 1;
        #pragma omp task
        fun(x - 1, y, task_id);
      }
      #pragma omptask wait
    }
}

