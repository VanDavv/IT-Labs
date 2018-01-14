// SDIZO N1 20A LAB06
// Łukasz Piłatowski
// pilatowski-lukasz@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef enum { false, true } bool;

int* init_array() {
    int *arr = malloc(sizeof(int)*997);
    memset(arr, 0, sizeof *arr);
    return arr;
}

int hash(int key) {
    return ((key % 1000) + 2 ^ (key % 10) + 1) % 997;
}

int line_addressing(int hash) {
    return hash + 1;
}

int double_mixing(int hash) {
    return hash + 2;
}

typedef int (*resolv_conflict_func)(int);

bool insert(int* arr, int key, resolv_conflict_func f) {
    int hash_key = hash(key);
    while(arr[hash_key] != 0) {
        hash_key = f(hash_key) % 997;
        if(arr[hash_key - 1] == key || arr[hash_key] == key) {
            printf("Could not insert key %d, element already exists\n", key);
            return false;
        }
    }
    arr[hash_key] = key;
    return true;
}

void insert_n(int* arr, int n, resolv_conflict_func f) {
    for(int i = 0; i < n; i++) {
        int id;
        do {
            id = (rand() % 20001) + 20000;
        } while(insert(arr, id, f) == false);
    }
}

int find(int* arr, int key, resolv_conflict_func f) {
    int hash_key = hash(key);
    while(arr[hash_key] != 0) {
        if(arr[hash_key] == key) {
            return hash_key;
        }
        hash_key = f(hash_key) % 997;
    }
    printf("Element with key %d was not found\n", key);
    return 0;
}

void show(int* arr, int begin, int end) {
    for(int i = begin; i < end; i++) {
        if(arr[i] > 0) {
            printf("[%d] %d\n", i, arr[i]);
        }
    }
}

void delete(int* arr, int key, resolv_conflict_func f) {
    int hash_key = hash(key);
    while(arr[hash_key] != 0) {
        if(arr[hash_key] == key) {
            arr[hash_key] = 0;
            return;
        }
        hash_key = f(hash_key) % 997;
    }
    printf("Element with key %d was not found\n", key);
    return;
}

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


int main() {
    srand(time(NULL));
    clock_t start = clock(), diff;
    FileData data = load("inlab06.txt");
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
