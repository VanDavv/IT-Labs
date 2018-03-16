#include <stdio.h>
#include <stdlib.h>
#include <utmpx.h>
#include <unistd.h>
#include <pwd.h>
#include <grp.h>

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
    
    struct utmpx *entry;
    struct passwd *group;
    gid_t *groups; 
    int ngroups = 0;
    
    while((entry = getutxent()) != NULL) {
	if(entry->ut_type == 7) {
	    printf("%s", entry->ut_user);
	    
	    if(aflag == 1) {
		printf("\t(%s)", entry->ut_host);
	    }

	    if(bflag == 1) {
		ngroups = 0;
		group = getpwnam(entry->ut_user);
		
		getgrouplist(entry->ut_user, group->pw_gid, NULL, &ngroups);
		groups = malloc(ngroups * sizeof(gid_t));
		getgrouplist(entry->ut_user, group->pw_gid, groups, &ngroups);
		
		printf("  \t[");
		for(int i = 0; i < ngroups; i++) {
		    printf("%s", getgrgid(groups[i])->gr_name);
		    if(i + 1 < ngroups) {
			printf(", ");
		    }
		}
		printf("]");
		free(groups);
	    }
	    
	    printf("\n");
	}
    }
}
