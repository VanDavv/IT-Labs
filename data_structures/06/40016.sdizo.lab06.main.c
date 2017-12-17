// SDIZO N1 20A LAB06
// Łukasz Piłatowski
// pilatowski-lukasz@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int* init_array() {
    return malloc(sizeof(int)*997);
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

void insert(int* arr, int key, resolv_conflict_func f) {
    int hash_key = hash(key);
    while(arr[hash_key] != 0) {
        hash_key = f(hash_key) % 997;
        if(arr[hash_key - 1] == key || arr[hash_key] == key) {
            printf("Could not insert key %d, element already exists\n", key);
            return;
        }
    }
    printf("%d\n", hash_key);
    arr[hash_key] = key;
}

int find(int* arr, int key) {
    int hash_key = hash(key);
    while(arr[hash_key] != 0) {
        if(arr[hash_key] == key) {
            return hash_key;
        }
        hash_key = ++hash_key % 997;
    }
    printf("Element with key %d was not found\n", key);
    return 0;
}

void show(int* arr, int begin, int end) {
    for(int i = begin; i < end; i++) {
        if(arr[i] != 0) {
            printf("[%d] %d\n", i, arr[i]);
        }
    }
}

int main() {
    int* a = init_array();
    resolv_conflict_func f = &line_addressing;
    insert(a, 10, f);
    insert(a, 11, f);
    insert(a, 12, f);
    printf("%d\n", find(a, 11));
    printf("%d\n", find(a, 15));
    show(a, 0, 30);
}
