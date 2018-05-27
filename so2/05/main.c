#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <dirent.h>
#include <string.h>

void read_recur(char* dir_str) {
    DIR *curr_dir = opendir(dir_str);
    struct dirent *curr_dir_ent;
    while((curr_dir_ent = readdir(curr_dir)) != NULL) {
        // check if dir
        if(curr_dir_ent->d_type != 4) {
            continue;
        }
        // check if not '.' or '..'
        if(strcmp(curr_dir_ent->d_name, ".") == 0 || strcmp(curr_dir_ent->d_name, "..") == 0) {
            continue;
        }
        printf("%s\n", curr_dir_ent->d_name);

    }
}

int main(int argc, char **argv) {
    read_recur("/home/vandavv/dev");
    return 0;
}