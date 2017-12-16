// SDIZO N1 20A LAB03
// Łukasz Piłatowski
// pilatowski-lukasz@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct TreeNode {
    int id;
    struct TreeNode* left;
    struct TreeNode* right;
    char c[10];
} TreeNode;

int calculate_id(TreeNode* root) {
    int id;
    mark:
    id = (rand() % 20001) - 10000;
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
    printf("Node with id %d was not found\n", id);
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
    sprintf(element->c,"%d", id);
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
            printf("Could not insert node with id %d, node already exists\n", id);
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

void remove_node(int id, TreeNode** root) {
    if (*root == NULL) {
        return;
    }
    TreeNode* found_node = find_node(id, *root);
    TreeNode* parent_node = _find_parent_node(id, *root);
    if(found_node == NULL) {
        return;
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
    // found node has only left children
    } else if(found_node->left != NULL) {
        if(id < parent_node->id) {
            parent_node->left = found_node->left;
        } else {
            parent_node->right = found_node->left;
        }
    // found node has only right children
    }  else if(found_node->right != NULL) {
        if(id < parent_node->id) {
            parent_node->left = found_node->right;
        } else {
            parent_node->right = found_node->right;
        }
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
    FileData data = load("inlab03.txt");
    TreeNode* root = init_tree();
    insert_new_node(data.k2, &root);
    insert_new_node(data.k1, &root);
    TreeNode* test = _find_parent_node(data.k1, root);
    remove_node(data.k1, &root);
    insert_new_node(data.k1, &root);
    insert_n_new_nodes(data.X, &root);
    view_in_order(root);
    view_pre_order(root);
    insert_new_node(data.k2, &root);
    view_in_order(root);
    insert_new_node(data.k3, &root);
    insert_new_node(data.k4, &root);
    remove_node(data.k1, &root);
    view_pre_order(root);
    find_node(data.k1, root);
    remove_node(data.k2, &root);
    view_in_order(root);
    remove_node(data.k3, &root);
    remove_node(data.k4, &root);
    diff = clock() - start;
    int msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    return 0;
}
