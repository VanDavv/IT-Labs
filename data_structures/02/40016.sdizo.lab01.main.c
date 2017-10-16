// SDIZO N1 20A LAB01
// Łukasz Piłatowski
// pilatowski-lukasz@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef enum { false, true } bool;

struct ListElement {
    int id;
    double d;
    char c;
    struct ListElement* previous;
    struct ListElement* next;
};

struct ListElement* first = NULL;
struct ListElement* last = NULL;
int count = 0;

void _remove_next_recursive(struct ListElement* elem) {
    if(elem != NULL) {
        _remove_next_recursive(elem->next);
        free(elem);
    }
}

void _insert_recur(struct ListElement* current, struct ListElement* element) {
    if(current->id < element->id) {
        if(current->next != NULL) {
            _insert_recur(current->next, element);
        }
        else {
            element->previous = current;
            current->next = element;
            last = element;
            count += 1;
        }
    } else if (current->id == element->id) {
        printf("Could not insert element with id:%d to list. Element with specified id already exists\n", element->id);
    } else {
        if(current->previous != NULL) {
            current->previous->next = element;
        }
        element->previous = current->previous;
        element->next = current;
        current->previous = element;
        if(current->id == first->id) {
            first = element;
        }
    }

}

struct ListElement* _create_new_element(int id) {
    struct ListElement* element = (struct ListElement*) malloc(sizeof(struct ListElement));
    element->id = id;
    element->d = (double)rand() / RAND_MAX;
    element->c = 'T';
    return element;
}

struct ListElement* _find_recur(struct ListElement* element, int id) {
    printf("elem:%d\n", element->id);
    if(element->id == id) {
        return element;
    } else if(element->next == NULL || element->id > id) {
        return NULL;
    } else {
        return _find_recur(element->next, id);
    }
}

void remove_all() {
    if(first != NULL) {
        _remove_next_recursive(first);
    }
}

void insert_new_element(int id) {
    if(first == NULL) {
        struct ListElement* element = _create_new_element(id);
        first = element;
        last = element;
    } else {
        _insert_recur(first, _create_new_element(id));
    }
}

void insert_n_new_elements(int X) {
    for(int i = 0; i < X; i++) {
        insert_new_element((rand() % 99901) + 99);
    }
}

struct ListElement* find_element(int id) {
    struct ListElement* element = _find_recur(first, id);
    if(element == NULL) {
        printf("Element with id %d was not found in list\n", id);
    }
    return element;
}

int main() {
    srand(time(NULL));
    insert_n_new_elements(2);
    insert_new_element(50000);
    printf("%d\n", first->id);
    printf("%d\n", last->id);
    struct ListElement* found = find_element(50000);
    if(found != NULL) {
        printf("%d\n", found->id);
    }
    remove_all();
    printf("%d\n", first->id);
    printf("%d\n", last->id);
    return 0;
}
