#define _GNU_SOURCE
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <dirent.h>
#include <string.h>
#include <stdlib.h>

void read_recur(char* dir_str, int depth, int dirs_only, int print_full_path, int max_depth) {
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

        if(dirs_only && curr_dir_ent->d_type != 4) {
            continue;
        }

        for(int i = 0; i < depth; i++) {
            printf("\t");
        }

        if(print_full_path) {
            printf(dir_str);
        }

        printf("%s\n", curr_dir_ent->d_name);

        // check if dir
        if(curr_dir_ent->d_type == 4 && (max_depth == -1 || depth < (max_depth - 1))) {
            char* new_path = "";
            asprintf(&new_path, "%s/%s", dir_str, curr_dir_ent->d_name);
            read_recur(new_path, depth + 1, dirs_only, print_full_path, max_depth);
            free(new_path);
        }
    }
    closedir(curr_dir);
}

int main(int argc, char **argv) {
    int dflag = 0, lflag = 0, fflag = 0, max_depth = -1, flag;
    while ((flag = getopt (argc, argv, "dlfL:")) != -1) {
        switch (flag) {
            case 'd': dflag = 1; break;
            case 'f': fflag = 1; break;
            case 'L': max_depth = atoi(optarg); break;
            case '?':
            fprintf (stderr, "Unknown option `-%c'.\n", optopt);
            return 1;
            default: abort ();
        }
    }
    read_recur("/home/vandavv/dev/", 0, dflag, fflag, max_depth);
    return 0;
}