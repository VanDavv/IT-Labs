// SDIZO N1 20A LAB07
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
    int bf;
} TreeNode;

int new_id() {
    return rand() % 10000000;
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

int _calculate_height(TreeNode* node) {
    if(node == NULL) {
        return 0;
    }
    int left_height = _calculate_height(node->left);
    int right_height = _calculate_height(node->right);
    if(left_height > right_height) {
        return left_height + 1;
    } else {
        return right_height + 1;
    }
}

int _calculate_bf(TreeNode* node) {
    return _calculate_height(node->left) - _calculate_height(node->right);
}

void _left_rotation(TreeNode** node, TreeNode** root) {
    TreeNode* parent_node = _find_parent_node((*node)->id, *root);
    TreeNode* right = (*node)->right;
    (*node)->right = right->left;
    right->left = *node;

    if(parent_node == NULL) {
        *root = right;
    } else if((*node)->id > parent_node->id) {
        parent_node->right = right;
    } else {
        parent_node->left = right;
    }
}

void _right_rotation(TreeNode** node, TreeNode** root) {
    TreeNode* parent_node = _find_parent_node((*node)->id, *root);
    TreeNode* left = (*node)->left;
    (*node)->left = left->right;
    left->right = *node;

    if(parent_node == NULL) {
        *root = left;
    } else if(left->id > parent_node->id) {
        parent_node->right = left;
    } else {
        parent_node->left = left;
    }
}

void _rebalance_tree_recur(TreeNode** node, int id, TreeNode** root) {
    if(*node == NULL) {
        return;
    }
    int bf = _calculate_bf(*node);
    if (bf > 1) {
        if (_calculate_bf((*node)->left) < 0) {
            // LR rotation
            _left_rotation(&((*node)->left), root);
        }
        // LL rotation
        _right_rotation(node, root);
    } else if (bf < -1) {
        if (_calculate_bf((*node)->right) > 0) {
            // RL rotation
            _right_rotation(&((*node)->right), root);
        }
        // RR rotation
        _left_rotation(node, root);
    }

    (*node)->bf = _calculate_bf(*node);

    if (bf > 1 || bf < -1) {
        TreeNode* left = (*node)->left;
        if(left != NULL) {
            left->bf = _calculate_bf(left);
        }
        TreeNode* right = (*node)->right;
        if(right != NULL) {
            right->bf = _calculate_bf(right);
        }
    }
     else {
        TreeNode* parent_node = _find_parent_node((*node)->id, *root);
        _rebalance_tree_recur(&parent_node, id, root);
    }
}

void rebalance_tree(TreeNode** parent, int id, TreeNode** root) {
    _rebalance_tree_recur(parent, id, root);
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

TreeNode* _create_node(int id) {
    TreeNode* element = (TreeNode*) malloc(sizeof(TreeNode));
    element->id = id;
    element->left = NULL;
    element->right = NULL;
    element->bf = 0;
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
                rebalance_tree(&current_element, id, root);
                return;
            }
            current_element = current_element->left;
        } else {
            if(current_element->right == NULL) {
                current_element->right = _create_node(id);
                rebalance_tree(&current_element, id, root);
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
    if(*root == NULL) {
        return false;
    }
    // found node is root
    if((*root)->id == id) {
        TreeNode* new_root = _find_succ_node(*root);
        TreeNode* new_root_parent = _find_parent_node(new_root->id, *root);
        new_root_parent->left = new_root->right;
        new_root->left = (*root)->left;
        new_root->right = (*root)->right;
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
        rebalance_tree(&parent_node, id, root);
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
        rebalance_tree(&parent_node, id, root);
        return  true;
    // found node has only left children
    } else if(found_node->left != NULL) {
        if(id < parent_node->id) {
            parent_node->left = found_node->left;
        } else {
            parent_node->right = found_node->left;
        }
        free(found_node);
        rebalance_tree(&parent_node, id, root);
        return true;
    // found node has only right children
    }  else if(found_node->right != NULL) {
        if(id < parent_node->id) {
            parent_node->left = found_node->right;
        } else {
            parent_node->right = found_node->right;
        }
        free(found_node);
        rebalance_tree(&parent_node, id, root);
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

typedef struct FileData {
    int numbers[500000];
} FileData;

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
    TreeNode* root = init_tree();
    FileData data = load("rand.txt", N);
    for (int i = 0; i < N; i++) {
        insert_new_node(data.numbers[i], &root);
    }
    printf("Inserted: %d\n", _count_recur(root));
    diff = clock() - start;
    int msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    start = clock();
    int found = 0;
    for (int i = 0; i < N; i++) {
        TreeNode* node = find_node(data.numbers[i], root);
        if(node != NULL) {
            found++;
        }
    }
    printf("Found from file: %d\n", found);
    diff = clock() - start;
    msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    start = clock();
    found = 0;
    for (int i = 0; i < N; i++) {
        TreeNode* node = find_node(new_id(), root);
        if(node != NULL) {
            found++;
        }
    }
    printf("Found random: %d\n", found);
    diff = clock() - start;
    msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    start = clock();
    int removed_count = 0;
    for (int i = 0; i < N; i++) {
        bool removed = remove_node(new_id(), &root);
        if(removed == true) {
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
        bool removed = remove_node(data.numbers[i], &root);
        if(removed == true) {
            removed_count++;
        }
    }
    printf("Removed from file: %d\n", removed_count);
    diff = clock() - start;
    msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time taken %d seconds %d milliseconds\n", msec/1000, msec%1000);
    return 0;
}
