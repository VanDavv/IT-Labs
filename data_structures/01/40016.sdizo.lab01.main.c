// SDIZO N1 20A LAB01
// Łukasz Piłatowski
// pilatowski-lukasz@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef enum { false, true } bool;

// Corresponds to "Struktura" struct from help01.pdf
struct RandomEntity {
  int a;
  char b;
  float c;
};

// First func described in task
struct RandomEntity** random_func(int N) {
  struct RandomEntity** arr=(struct RandomEntity**) malloc(N*sizeof(struct RandomEntity*));
  for(int i = 0; i < N; i++) {
    arr[i] = (struct RandomEntity*) malloc(sizeof(struct RandomEntity));
    arr[i]->a = (rand() % 10001) - 1000;
    arr[i]->b = (char)((int) 'B' + rand() % 23);
    arr[i]->c = (float) (1000 + i + 1);
  }
  return arr;
}

// Second func described in func
void remove_func(struct RandomEntity** arr, int N) {
  for(int i = 0; i < N; i++) {
    free(arr[i]);
  }
  free(arr);
}

void sort_func(struct RandomEntity** arr, int N) {
    for(int i = N; i > 1; i--) {
        bool hasChanged = false;
        for(int j = 1; j < i; j++) {
            if(arr[j - 1]->a > arr[j]->a) {
                struct RandomEntity* buff = arr[j];
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

int search_count_func(struct RandomEntity** arr, int N, char query) {
  int count = 0;
  for(int i = 0; i < N; i++) {
    if(arr[i]->b == query) {
      count += 1;
    }
  }
  return count;
}

struct FileData {
    int num;
    char search;
};

struct FileData load(char* filename) {
  FILE* file = fopen(filename, "r");
  struct FileData result = {0, '0'};
  char c;
  bool spaceRead = false;
  if (file) {
      while ((c = getc(file)) != EOF)
          if (c != ' ') {
            if (spaceRead) {
              result.search = c;
            } else {
              result.num = result.num * 10 + (c - '0');
            }
          } else {
            spaceRead = true;
          }
      fclose(file);
  }
  return result;
}

int main() {
    srand(time(NULL));
    clock_t start = clock(), diff;
    struct FileData data = load("inlab01.txt");
    struct RandomEntity** arr = random_func(data.num);
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
    printf("Time taken %d seconds %d milliseconds", msec/1000, msec%1000);
    return 0;
}
