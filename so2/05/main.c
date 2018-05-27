#define _GNU_SOURCE
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <dirent.h>
#include <string.h>
#include <stdlib.h>

void read_recur(char* dir_str, int indent) {
    DIR *curr_dir = opendir(dir_str);
    if(curr_dir == NULL) {
        printf("[ERROR] Unable to read from directory, skipping... %s\n", dir_str);
        return;
    }
    struct dirent *curr_dir_ent;
    while((curr_dir_ent = readdir(curr_dir)) != NULL) {
        // check if not '.' or '..'
        if(strcmp(curr_dir_ent->d_name, ".") == 0 || strcmp(curr_dir_ent->d_name, "..") == 0) {
            continue;
        }

        for(int i = 0; i < indent; i++) {
            printf("\t");
        }

        printf("%s\n", curr_dir_ent->d_name);

        // check if dir
        if(curr_dir_ent->d_type == 4) {
            char* new_path = "";
            asprintf(&new_path, "%s/%s", dir_str, curr_dir_ent->d_name);
            read_recur(new_path, indent + 1);
            free(new_path);
        }
    }
    closedir(curr_dir);
}

int main(int argc, char **argv) {
    read_recur("/home/vandavv/dev/", 0);
    return 0;
}