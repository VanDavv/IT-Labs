// SDIZO N1 20A LAB01
// Łukasz Piłatowski
// pilatowski-lukasz@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef enum { false, true } bool;

typedef struct RandomEntity {
  int a;
  char b;
  float c;
} RandomEntity;

RandomEntity** random_func(int N) {
  RandomEntity** arr=(RandomEntity**) malloc(N*sizeof(RandomEntity*));
  for(int i = 0; i < N; i++) {
    arr[i] = (RandomEntity*) malloc(sizeof(RandomEntity));
    int id;
    mark:
    id = (rand() % 10001) - 1000;
    for (int j = 0; j < i; ++j) {
        if (arr[j]->a == id) {
            goto mark;
        }
    }
    arr[i]->a = id;
    arr[i]->b = (char)((int) 'B' + rand() % 23);
    arr[i]->c = (float) (1000 + i + 1);
  }
  return arr;
}

void remove_func(RandomEntity** arr, int N) {
  for(int i = 0; i < N; i++) {
    free(arr[i]);
  }
  free(arr);
}

void sort_func(RandomEntity** arr, int N) {
    for(int i = N; i > 1; i--) {
        bool hasChanged = false;
        for(int j = 1; j < i; j++) {
            if(arr[j - 1]->a > arr[j]->a) {
                RandomEntity* buff = arr[j];
                arr[j] = arr[j - 1];
                arr[j - 1] = buff;
                hasChanged = true;
            }
        }
        if(!hasChanged) {
            break;
        }
    }
}

int search_count_func(RandomEntity** arr, int N, char query) {
  int count = 0;
  for(int i = 0; i < N; i++) {
    if(arr[i]->b == query) {
      count += 1;
    }
  }
  return count;
}

typedef struct FileData {
    int num;
    char search;
} FileData;

FileData load(char* filename) {
  FILE* file = fopen(filename, "r");
  FileData result;
  if (file) {
      fscanf(file, "%d %c", &result.num, &result.search);
      fclose(file);
  }
  return result;
}

int main() {
    srand(time(NULL));
    clock_t start = clock(), diff;
    FileData data = load("inlab01.txt");
    RandomEntity** arr = random_func(data.num);
    sort_func(arr, data.num);
    int count = search_count_func(arr, data.num, data.search);
    for(int i = 0; i < data.num && i < 20; i++) {
        printf("{\n");
        printf("\ta:%d\n", arr[i]->a);
        printf("\tb:%c\n", arr[i]->b);
        printf("\tc:%f\n", arr[i]->c);
        printf("}\n");
    }
    remove_func(arr, data.num);
    printf("Search count: %d\n", count);
    diff = clock() - start;
    int msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    return 0;
}
