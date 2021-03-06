// SDIZO N1 20A LAB05
// Łukasz Piłatowski
// pilatowski-lukasz@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef enum { false, true } bool;

typedef struct TreeNode {
    int id;
    struct TreeNode* left;
    struct TreeNode* right;
} TreeNode;

int new_id() {
    return rand() % 100001;
}

int calculate_id(TreeNode* root) {
    int id;
    mark:
    id = new_id();
    TreeNode* current_element = root;
    while(current_element != NULL) {
        if(id == current_element->id) {
            goto mark;
        } else if (id < current_element->id) {
            current_element = current_element->left;
        } else {
            current_element = current_element-> right;
        }
        continue;
    }
    return id;
}

TreeNode* find_node(int id, TreeNode* root) {
    TreeNode* current_node = root;
    while(current_node != NULL) {
        if(id == current_node->id) {
            return current_node;
        } else if (id < current_node->id) {
            current_node = current_node->left;
        } else {
            current_node = current_node-> right;
        }
        continue;
    }
    return NULL;
}

TreeNode* _find_parent_node(int id, TreeNode* root) {
    if(root == NULL || root->id == id) {
        return NULL;
    }
    TreeNode* parent_node = root;
    TreeNode* child_node;
    do {
        if(id > parent_node->id) {
            child_node = parent_node->right;
        } else if(id < parent_node->id) {
            child_node = parent_node->left;
        }
        if(child_node != NULL && child_node->id == id) {
            return parent_node;
        } else {
            parent_node = child_node;
        }
    } while(child_node != NULL);

    return NULL;
}

TreeNode* _create_node(int id) {
    TreeNode* element = (TreeNode*) malloc(sizeof(TreeNode));
    element->id = id;
    element->left = NULL;
    element->right = NULL;
    return element;
}

void insert_new_node(int id, TreeNode** root) {
    if(*root == NULL) {
        *root = _create_node(id);
        return;
    }
    TreeNode* current_element = *root;
    while(current_element != NULL) {
        if(id == current_element->id) {
            return;
        } else if (id < current_element->id) {
            if(current_element->left == NULL) {
                current_element->left = _create_node(id);
                return;
            }
            current_element = current_element->left;
        } else {
            if(current_element->right == NULL) {
                current_element->right = _create_node(id);
                return;
            }
            current_element = current_element->right;
        }
        continue;
    }
}

TreeNode* _find_succ_node(TreeNode* start_node) {
    TreeNode* succ_node = start_node->right;
    while(succ_node->left != NULL) {
        succ_node = succ_node->left;
    }
    return succ_node;
}

bool remove_node(int id, TreeNode** root) {
    if (*root == NULL) {
        return false;
    }
    // found node is root
    if((*root)->id == id) {
        TreeNode* new_root = (*root)->right;
        if(new_root != NULL) {
            new_root->left = (*root)->left;
        } else {
            new_root = (*root)->left;
        }
        free(*root);
        *root = new_root;
        return true;
    }
    TreeNode* found_node = find_node(id, *root);
    TreeNode* parent_node = _find_parent_node(id, *root);
    if(found_node == NULL) {
        return false;
    }
    // found node has no children
    if(found_node->left == NULL && found_node->right == NULL) {
        if(parent_node != NULL) {
            if(id < parent_node->id) {
                parent_node->left = NULL;
            } else {
                parent_node->right = NULL;
            }
        }
        free(found_node);
        return true;
    // found node has both children
    } else if (found_node->left != NULL && found_node->right != NULL) {
        TreeNode* succ_node = _find_succ_node(found_node);
        TreeNode* parent_succ_node = _find_parent_node(succ_node->id, *root);
        // detach successor node from parent
        if(succ_node->id < parent_succ_node->id) {
            parent_succ_node->left = succ_node->right;
        } else {
            parent_succ_node->right = succ_node->right;
        }
        // attach successor note to new parent
        if(parent_node != NULL) {
            if(id < parent_node->id) {
                parent_node->left = succ_node;
            } else {
                parent_node->right = succ_node;
            }
        }
        // rewrite node properties
        succ_node->left = found_node->left;
        succ_node->right = found_node->right;
        // free found node
        free(found_node);
        return true;
    // found node has only left children
    } else if(found_node->left != NULL) {
        if(id < parent_node->id) {
            parent_node->left = found_node->left;
        } else {
            parent_node->right = found_node->left;
        }
        free(found_node);
        return true;
    // found node has only right children
    }  else if(found_node->right != NULL) {
        if(id < parent_node->id) {
            parent_node->left = found_node->right;
        } else {
            parent_node->right = found_node->right;
        }
        free(found_node);
        return true;
    }
}

void insert_n_new_nodes(int X, TreeNode** root) {
    for(int i = 0; i < X; i++) {
        insert_new_node(calculate_id(*root), root);
    }
}

TreeNode* init_tree() {
    return NULL;
}

void _pre_order_recur(TreeNode* node) {
    if(node == NULL) {
        return;
    }
    printf("%d ", node->id);
    _pre_order_recur(node->left);
    _pre_order_recur(node->right);
}

void _in_order_recur(TreeNode* node) {
    if(node == NULL) {
        return;
    }
    _in_order_recur(node->left);
    printf("%d ", node->id);
    _in_order_recur(node->right);
}

void _post_order_recur(TreeNode* node) {
    if(node == NULL) {
        return;
    }
    _post_order_recur(node->left);
    _post_order_recur(node->right);
    printf("%d ", node->id);
}

void view_pre_order(TreeNode* root) {
    _pre_order_recur(root);
    printf("\n");
}

void view_in_order(TreeNode* root) {
    _in_order_recur(root);
    printf("\n");
}

void view_post_order(TreeNode* root) {
    _post_order_recur(root);
    printf("\n");
}

int _count_recur(TreeNode* node) {
    if(node == NULL) {
        return 0;
    }
    return _count_recur(node->left) +_count_recur(node->right) + 1;
}

int main(int argc, char *argv[]) {
    if(argc != 3) {
        printf("Incorrect numbers of arguments (%d), expected 2\n", argc - 1);
        return 1;
    }
    int N = atoi(argv[1]);
    bool randomize = (atoi(argv[2]) == 1);
    srand(1);
    printf("\n[BST] %d\n", N);
    printf("Inserting\n");
    clock_t start = clock(), diff;
    TreeNode* root = init_tree();
    if(randomize) {
        insert_n_new_nodes(N, &root);
    } else {
        for(int i = 0; i < N; i++) {
            if(i % 2 == 0) {
                insert_new_node(calculate_id(root), &root);
            } else {
                insert_new_node((i+1)/2, &root);
            }
        }
    }
    printf("Inserted: %d\n", _count_recur(root));
    diff = clock() - start;
    int msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);

    printf("Search\n");
    start = clock();
    int count = 0;
    for(int i = 0; i < N; i++) {
        if(find_node(new_id(), root) != NULL) {
            count++;
        }
    }
    printf("Found: %d\n", count);
    diff = clock() - start;
    msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);

    printf("Remove\n");
    start = clock();
    count = 0;
    for(int i = 0; i < N; i++) {
        if(remove_node(new_id(), &root)) {
            count++;
        }
    }
    printf("Removed: %d\n", count);
    diff = clock() - start;
    msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    return 0;
}
