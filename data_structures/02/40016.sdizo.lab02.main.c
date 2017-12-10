// SDIZO N1 20A LAB02
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

ListElement* first = NULL;
ListElement* last = NULL;

void _remove_next_recursive(ListElement* elem) {
    if(elem != NULL && elem->next != first) {
        _remove_next_recursive(elem->next);
        elem->next = NULL;
        elem->previous = NULL;
        free(elem);
        elem = NULL;
    }
}

void _insert_recur(ListElement* current, ListElement* element) {
    if(current->id < element->id) {
        if(current->next != first) {
            _insert_recur(current->next, element);
        }
        else {
            // element added at the end of the list
            element->previous = current;
            element->next = first;
            first->previous = element;
            current->next = element;
            last = element;
        }
    } else if (current->id == element->id) {
        printf("Could not insert element with id:%d to list. Element with specified id already exists\n", element->id);
    } else {
        if(element->id < first->id) {
            // element added at the beggining of the list
            first->previous = element;
            last->next = element;
            element->next = first;
            element->previous = last;
            first = element;
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

ListElement* _find_recur(ListElement* element, int id) {
    if(element->id == id) {
        return element;
    } else if(element->next == first || element->id > id) {
        return NULL;
    } else {
        return _find_recur(element->next, id);
    }
}

void remove_all() {
    if(first != NULL) {
        _remove_next_recursive(first);
        first = NULL;
        free(last);
        last = NULL;
    }
}

void _remove_recursive(ListElement* element, int id) {
    if(element == NULL) {
        return;
    }
    if(element->id != id) {
        _remove_recursive(element->next, id);
    } else {
        ListElement* previous = element->previous;
        ListElement* next = element->next;
        if(previous != NULL) {
            previous->next = next;
        }
        if(next != NULL) {
            next->previous = previous;
        }
        if(element == first) {
            first = next;
        }
        if(element == last) {
            last = previous;
        }
        free(element);
        element = NULL;
        return;
    }
}

void remove_element(int id) {
    if(first != NULL) {
        _remove_recursive(first, id);
    }
}

void insert_new_element(int id) {
    if(first == NULL) {
        ListElement* element = _create_new_element(id);
        element->next = element;
        element->previous = element;
        first = element;
        last = element;
    } else {
        _insert_recur(first, _create_new_element(id));
    }
}

int calculate_id() {
    int id;
    ListElement* current_element;
    mark:
    id = (rand() % 99901) + 99;
    if(first == NULL) {
        return id;
    }
    current_element = first;
    do {
        if(current_element->id == id) {
            goto mark;
        }
        if(current_element->next == NULL) {
            break;
        } else {
            current_element = current_element->next;
        }
    } while(current_element != first);
    return id;
}

void insert_n_new_elements(int X) {
    for(int i = 0; i < X; i++) {
        insert_new_element(calculate_id());
    }
}

ListElement* find_element(int id) {
    if(first == NULL) {
        printf("List is empty, cound not find element with id %d\n", id);
        return NULL;
    }
    struct ListElement* element = _find_recur(first, id);
    if(element == NULL) {
        printf("Element with id %d was not found in list\n", id);
        return NULL;
    }
    return element;
}

void present_n_first_values(int Y) {
    int node_count = 0;
    ListElement* current_element = first;
    do {
        if(current_element == NULL || (node_count > 0 && current_element == first)) {
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

void present_n_last_values(int Z) {
    int node_count = 0;
    ListElement* current_element = last;
    do {
        if(current_element == NULL || (node_count > 0 && current_element == last)) {
            break;
        } else {
            printf("[%d] Element %d\n", node_count + 1, current_element->id);
            current_element = current_element->previous;
            node_count += 1;
        }
    } while(node_count < Z);
    if(node_count == 0) {
        printf("List is empty, nothing to show...\n");
    }
}

int count_values() {
    int node_count = 0;
    ListElement* current_element = first;
    do {
        if(current_element == NULL) {
            break;
        }
        node_count += 1;
        current_element = current_element->next;
    } while(current_element != first);
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

int main() {
    srand(time(NULL));
    clock_t start = clock(), diff;
    FileData data = load("inlab02.txt");
    ListElement* elem_k1 = find_element(data.k1);
    insert_n_new_elements(data.X);
    printf("Count: %d\n", count_values());
    present_n_first_values(20);
    insert_new_element(data.k2);
    present_n_first_values(20);
    insert_new_element(data.k3);
    present_n_first_values(20);
    insert_new_element(data.k4);
    present_n_first_values(20);
    insert_new_element(data.k5);
    present_n_first_values(20);
    remove_element(data.k3);
    present_n_first_values(20);
    remove_element(data.k2);
    present_n_first_values(20);
    remove_element(data.k5);
    printf("Count: %d\n", count_values());
    ListElement* elem_k5 = find_element(data.k5);
    present_n_last_values(11);
    remove_all();
    present_n_last_values(11);
    printf("Count: %d\n", count_values());
    diff = clock() - start;
    int msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    return 0;
}
