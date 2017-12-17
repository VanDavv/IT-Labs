// SDIZO N1 20A LAB05
// Łukasz Piłatowski
// pilatowski-lukasz@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef enum { false, true } bool;

typedef struct ListElement {
    int id;
    double d;
    char c;
    struct ListElement* previous;
    struct ListElement* next;
} ListElement;

void _remove_next_recursive(ListElement* elem, ListElement** first) {
    if(elem != NULL && elem->next != *first) {
        _remove_next_recursive(elem->next, first);
        elem->next = NULL;
        elem->previous = NULL;
        free(elem);
        elem = NULL;
    }
}

void _insert_recur(ListElement* current, ListElement* element, ListElement** first) {
    if(current->id < element->id) {
        if(current->next != *first) {
            _insert_recur(current->next, element, first);
        }
        else {
            // element added at the end of the list
            element->previous = current;
            element->next = *first;
            (*first)->previous = element;
            current->next = element;
        }
    } else if (current->id == element->id) {
        return;
    } else {
        if(element->id < (*first)->id) {
            // element added at the beggining of the list
            element->next = *first;
            (*first)->previous->next = element;
            element->previous = (*first)->previous;
            (*first)->previous = element;
            *first = element;
        } else {
            // element added in the middle of the list
            element->previous = current->previous;
            element->next = current;
            current->previous->next = element;
            current->previous = element;
        }
    }

}

ListElement* _create_new_element(int id) {
    ListElement* element = (ListElement*) malloc(sizeof(ListElement));
    element->id = id;
    element->d = (double)rand() / RAND_MAX;
    element->c = 'T';
    return element;
}

ListElement* _find_recur(ListElement* element, int id, ListElement** first) {
    if(element->id == id) {
        return element;
    } else if(element->next == *first || element->id > id) {
        return NULL;
    } else {
        return _find_recur(element->next, id, first);
    }
}

void remove_all(ListElement** first) {
    if(*first != NULL) {
        _remove_next_recursive(*first, first);
        *first = NULL;
    }
}

bool _remove_recursive(ListElement* element, int id, ListElement** first) {
    if(element == NULL) {
        return false;
    }
    if(element->id != id) {
        _remove_recursive(element->next, id, first);
    } else {
        ListElement* previous = element->previous;
        ListElement* next = element->next;
        if(previous != NULL) {
            previous->next = next;
        }
        if(next != NULL) {
            next->previous = previous;
        }
        if(element == *first) {
            *first = next;
        }
        if(element == (*first)->previous) {
            (*first)->previous = previous;
        }
        free(element);
        element = NULL;
        return true;
    }
}

bool remove_element(int id, ListElement** first) {
    if(*first != NULL) {
        return _remove_recursive(*first, id, first);
    }
    return false;
}

void insert_new_element(int id, ListElement** first) {
    if(*first == NULL) {
        ListElement* element = _create_new_element(id);
        element->next = element;
        element->previous = element;
        *first = element;
    } else {
        _insert_recur(*first, _create_new_element(id), first);
    }
}

int calculate_id(ListElement** first) {
    int id;
    ListElement* current_element;
    mark:
    id = (rand() % 99901) + 99;
    if(*first == NULL) {
        return id;
    }
    current_element = *first;
    do {
        if(current_element->id == id) {
            goto mark;
        }
        if(current_element->next == NULL) {
            break;
        } else {
            current_element = current_element->next;
        }
    } while(current_element != *first);
    return id;
}

void insert_n_new_elements(int X, ListElement** first) {
    for(int i = 0; i < X; i++) {
        insert_new_element(calculate_id(first), first);
    }
}

ListElement* find_element(int id, ListElement** first) {
    if(*first == NULL) {
        return NULL;
    }
    struct ListElement* element = _find_recur(*first, id, first);
    if(element == NULL) {
        return NULL;
    }
    return element;
}

void present_n_first_values(int Y, ListElement** first) {
    int node_count = 0;
    ListElement* current_element = *first;
    do {
        if(current_element == NULL || (node_count > 0 && current_element == *first)) {
            break;
        } else {
            printf("[%d] Element %d\n", node_count + 1, current_element->id);
        }
        current_element = current_element->next;
        node_count += 1;
    } while(node_count < Y);
    if(node_count == 0) {
        printf("List is empty, nothing to show...\n");
    }
}

void present_n_last_values(int Z, ListElement** first) {
    int node_count = 0;
    if(*first == NULL) {
        printf("List is empty, nothing to show...\n");
        return;
    }
    ListElement* current_element = (*first)->previous;
    do {
        if(current_element == NULL || (node_count > 0 && current_element == (*first)->previous)) {
            break;
        } else {
            printf("[%d] Element %d\n", node_count + 1, current_element->id);
            current_element = current_element->previous;
            node_count += 1;
        }
    } while(node_count < Z);
}

int count_values(ListElement** first) {
    int node_count = 0;
    ListElement* current_element = *first;
    do {
        if(current_element == NULL) {
            break;
        }
        node_count += 1;
        current_element = current_element->next;
    } while(current_element != *first);
    return node_count;
}

typedef struct FileData {
    int X;
    int k1;
    int k2;
    int k3;
    int k4;
    int k5;
} FileData;

FileData load(char* filename) {
  FILE* file = fopen(filename, "r");
  FileData result;
  if (file) {
      fscanf(file, "%d %d %d %d %d %d", &result.X, &result.k1, &result.k2, &result.k3, &result.k4, &result.k5);
      fclose(file);
  }
  return result;
}

int main(int argc, char *argv[]) {
    if(argc != 3) {
        printf("Incorrect numbers of arguments (%d), expected 2\n", argc - 1);
        return 1;
    }
    int N = atoi(argv[1]);
    bool randomize = (atoi(argv[2]) == 1);
    srand(1);

    printf("Inserting\n");
    clock_t start = clock(), diff;
    ListElement* first = NULL;
    if(randomize) {
        insert_n_new_elements(N, &first);
    } else {
        for(int i = 0; i < N; i++) {
            if(i % 2 == 0) {
                insert_new_element(calculate_id(&first), &first);
            } else {
                insert_new_element((i+1)/2, &first);
            }
        }
    }
    printf("Inserted: %d\n", count_values(&first));
    diff = clock() - start;
    int msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);

    printf("Search\n");
    start = clock();
    first = NULL;
    int count = 0;
    for(int i = 0; i < N; i++) {
        int id = calculate_id(&first);
        insert_new_element(id, &first);
        if(find_element(id, &first) != NULL) {
            count++;
        }
    }
    printf("Found: %d\n", count);
    diff = clock() - start;
    msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);

    printf("Remove\n");
    start = clock();
    first = NULL;
    count = 0;
    for(int i = 0; i < N; i++) {
        int id = calculate_id(&first);
        insert_new_element(id, &first);
        if(remove_element(id, &first)) {
            count++;
        }
    }
    printf("Removed: %d\n", count);
    diff = clock() - start;
    msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    return 0;
}
