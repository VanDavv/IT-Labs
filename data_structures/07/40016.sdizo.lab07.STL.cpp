// SDIZO N1 20A LAB07
// Łukasz Piłatowski
// pilatowski-lukasz@zut.edu.pl
#include<iostream>
#include<set>
#include<string>
#include<stdlib.h>

using namespace std;

int new_id() {
    return rand() % 10000000;
}

typedef struct FileData {
    int numbers[500000];
} FileData;

set<int>* init_tree() {
    return new set<int>;
}

bool insert(int key, set<int> *root) {
    return root->insert(key).second != false;
}

bool find(int key, set<int> *root) {
    return root->find(key) != root->end();
}

bool remove(int key, set<int> *root) {
	return root->erase(key) == 1;
}

FileData load(char* filename, int N) {
  FILE* file = fopen(filename, "r");
  FileData result;
  if (file) {
      for (int i = 0; i < N && i < 500000; i++) {
        fscanf(file, "%d", &result.numbers[i]);
      }
      fclose(file);
  }
  return result;
}

int main(int argc, char *argv[]) {
    srand(time(NULL));
    clock_t start = clock(), diff;
    if(argc != 2) {
        printf("Incorrect numbers of arguments (%d), expected 1\n", argc - 1);
        return 1;
    }
    int N = atoi(argv[1]);
    set<int> *root = init_tree();
    FileData data = load((char *)"rand.txt", N);
    int inserted_count = 0;
    for (int i = 0; i < N; i++) {
        bool inserted = insert(data.numbers[i], root);
        if(inserted) {
            inserted_count++;
        }
    }
    printf("Inserted: %d\n", inserted_count);
    diff = clock() - start;
    int msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    start = clock();
    int found_count = 0;
    for (int i = 0; i < N; i++) {
        bool found = find(data.numbers[i], root);
        if(found) {
            found_count++;
        }
    }
    printf("Found from file: %d\n", found_count);
    diff = clock() - start;
    msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    start = clock();
    found_count = 0;
    for (int i = 0; i < N; i++) {
        bool found = find(new_id(), root);
        if(found) {
            found_count++;
        }
    }
    printf("Found random: %d\n", found_count);
    diff = clock() - start;
    msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    start = clock();
    int removed_count = 0;
    for (int i = 0; i < N; i++) {
        bool removed = remove(new_id(), root);
        if(removed) {
            removed_count++;
        }
    }
    printf("Removed random: %d\n", removed_count);
    diff = clock() - start;
    msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    start = clock();
    removed_count = 0;
    for (int i = 0; i < (N / 2); i++) {
        bool removed = remove(data.numbers[i], root);
        if(removed) {
            removed_count++;
        }
    }
    printf("Removed from file: %d\n", removed_count);
    diff = clock() - start;
    msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    return 0;
}
