#include <stdio.h>
#include <stdlib.h>
#include <utmpx.h>
#include <unistd.h>
#include <dlfcn.h>
#define LIB_NAME "./libuser.so.1.0"

char* ( *get_groups)(char*);

int main(int argc, char **argv) {
    int aflag = 0, bflag = 0, flag;
    while ((flag = getopt (argc, argv, "ab")) != -1) {
        switch (flag) {
            case 'a': aflag = 1; break;
            case 'b': bflag = 1; break;
            case '?':
            fprintf (stderr, "Unknown option `-%c'.\n", optopt);
            return 1;
            default: abort ();
        }
    }

    void *handle = dlopen(LIB_NAME, RTLD_LAZY);
    if(!handle) {
        dlerror();
    } else {
        get_groups = dlsym(handle, "get_groups");
    }

    if(!handle || get_groups == NULL) {
        bflag = 0;
        printf("[WARNING] Could not load dynamic library %s\n", LIB_NAME);
    }

    struct utmpx *entry;

    while((entry = getutxent()) != NULL) {
        if(entry->ut_type == 7) {
            printf("%s", entry->ut_user);

            if(aflag == 1) {
                printf("\t(%s)", entry->ut_host);
            }

            if(bflag == 1) {
                char *groups = get_groups(entry->ut_user);
                printf("\t%s", groups);
                free(groups);
            }

            printf("\n");
        }
    }

    if(handle) {
	    dlclose(handle);
    }
}
