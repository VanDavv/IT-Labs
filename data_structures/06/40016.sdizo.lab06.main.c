// SDIZO N1 20A LAB06
// Łukasz Piłatowski
// pilatowski-lukasz@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

#define FILENAME "inlab06.txt"

typedef struct FileData {
    int X;
    int k1;
    int k2;
    int k3;
    int k4;
} FileData;

FileData load(char* filename) {
  FILE* file = fopen(filename, "r");
  FileData result;
  if (file) {
      fscanf(file, "%d %d %d %d %d", &result.X, &result.k1, &result.k2, &result.k3, &result.k4);
      fclose(file);
  }
  return result;
}

typedef enum { false, true } bool;

int* init_array() {
    int *arr = malloc(sizeof(int)*997);
    memset(arr, 0, 997 * sizeof *arr);
    return arr;
}

int hash(int key) {
    return ((key % 1000) + ((int) pow((double) 2 , (double) (key % 10))) + 1) % 997;
}

int line_addressing(int key, int conflicts) {
    return hash(key) + conflicts;
}

int double_mixing(int key, int conflicts) {
    return hash(key) + (3 * key % 19 + 1) * conflicts;
}

typedef int (*resolv_conflict_func)(int, int);

bool insert(int* arr, int key, resolv_conflict_func f) {
    int hash_key = hash(key);
    int conflicts = 0;
    while(arr[hash_key] != 0) {
        conflicts++;
        hash_key = f(key, conflicts) % 997;
        if(arr[hash_key] == key) {
            printf("Could not insert key %d, element already exists\n", key);
            return false;
        }
    }
    arr[hash_key] = key;
    return true;
}

void insert_n(int* arr, int n, resolv_conflict_func f) {
    FileData data = load(FILENAME);
    for(int i = 0; i < n; i++) {
        int id;
        bool succ = false;
        do {
            id = (rand() % 20001) + 20000;
            if (id != data.k1 && id != data.k2 && id != data.k3 && id != data.k4) {
                succ = insert(arr, id, f);
            }
        } while(succ == false);
    }
}

int find(int* arr, int key, resolv_conflict_func f) {
    int hash_key = hash(key);
    int conflicts = 0;
    while(arr[hash_key] != 0) {
        if(arr[hash_key] == key) {
            return hash_key;
        }
        conflicts++;
        hash_key = f(key, conflicts) % 997;
    }
    printf("Element with key %d was not found\n", key);
    return 0;
}

void show(int* arr, int begin, int end) {
    for(int i = begin; i < end; i++) {
        printf("[%d] %d\n", i, arr[i]);
    }
}

void delete(int* arr, int key, resolv_conflict_func f) {
    int hash_key = hash(key);
    int conflicts = 0;
    while(arr[hash_key] != 0) {
        if(arr[hash_key] == key) {
            arr[hash_key] = -1;
            return;
        }
        conflicts++;
        hash_key = f(key, conflicts) % 997;
    }
    printf("Element with key %d was not found\n", key);
    return;
}


int main() {
    srand(time(NULL));
    clock_t start = clock(), diff;
    FileData data = load(FILENAME);
    resolv_conflict_func f = &line_addressing;
    int* a = init_array();
    delete(a, data.k1, f);
    insert(a, data.k1, f);
    show(a, 0, 100);
    insert_n(a, data.X, f);
    show(a, 0, 100);
    insert(a, data.k2, f);
    insert(a, data.k3, f);
    insert(a, data.k4, f);
    show(a, 0, 100);
    show(a, 500, 600);
    delete(a, data.k3, f);
    delete(a, data.k4, f);
    show(a, 0, 100);
    show(a, 500, 600);
    diff = clock() - start;
    int msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);

    start = clock();
    f = &double_mixing;
    a = init_array();
    delete(a, data.k1, f);
    insert(a, data.k1, f);
    show(a, 0, 100);
    insert_n(a, data.X, f);
    show(a, 0, 100);
    insert(a, data.k2, f);
    insert(a, data.k3, f);
    insert(a, data.k4, f);
    show(a, 0, 100);
    show(a, 500, 600);
    delete(a, data.k3, f);
    delete(a, data.k4, f);
    show(a, 0, 100);
    show(a, 500, 600);
    diff = clock() - start;
    msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
}
