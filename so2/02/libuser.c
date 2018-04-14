#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <utmpx.h>
#include <pwd.h>
#include <grp.h>
#include <string.h>

char* get_groups(char* username) {
    char *result = malloc(2);
    strcpy(result, "[\0");
    char *tmp = "_";
    struct passwd *user = getpwnam(username);

    int ngroups = 0;
    getgrouplist(username, user->pw_gid, NULL, &ngroups);

    gid_t *groups = malloc(ngroups * sizeof(gid_t));
    getgrouplist(username, user->pw_gid, groups, &ngroups);

    for(int i = 0; i < ngroups; i++) {
        asprintf(&tmp, "%s%s", result, getgrgid(groups[0])->gr_name);
        free(result);
        result = tmp;
        if(i + 1 < ngroups) {
            asprintf(&tmp, "%s,", result);
            free(result);
            result = tmp;
        }
    }
    asprintf(&tmp, "%s]", result);
    free(result);
    result = tmp;
    free(groups);
    return result;
}
