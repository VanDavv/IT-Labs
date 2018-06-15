#include <sys/types.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>  // for strtol
#include <string.h> // for strlen

int recv_sig = 0;

void inthandle(int s) {
    recv_sig = 1;
}

void tstphandle(int s) {
    printf("SIGTSTP has been received during program runtime and it was ignored\n");
}

int main(int argc, char **argv) {
    int status = 0;
    pid_t pid1, pid2, wpid;

    // declare signal listeners
    sigset_t iset;
    sigemptyset(&iset);
    struct sigaction act_int;
    act_int.sa_handler = &inthandle;
    act_int.sa_mask = iset;
    act_int.sa_flags = 0;
    sigaction(SIGINT, &act_int, NULL);

    struct sigaction act_tstp;
    act_tstp.sa_handler = &tstphandle;
    act_tstp.sa_mask = iset;
    act_tstp.sa_flags = 0;
    sigaction(SIGTSTP, &act_tstp, NULL);


    sigset_t jset;
    sigemptyset(&jset);
    sigaddset(&jset, SIGTSTP);
    sigprocmask(SIG_BLOCK, &jset, NULL);

    // get last argument and it's length
    char *last_arg = argv[argc - 1];
    int last_arg_length = strlen(last_arg);

    // if last arg length is 1 or less, then we don't go further but finish
    if (last_arg_length < 2) {
        while(recv_sig == 0);
        printf("%d", getpid());
        for( int i = 1; i < argc; ++i ) {
            printf(" %s ", argv[ i ] );
        }
        printf("\n");
        return 0;
    }

    // last arg length is 2 or greater, we need to split it
    int len1 = last_arg_length / 2;
    int len2 = last_arg_length - len1;

    char *s1 = malloc(len1+1); // one for the null terminator
    char *s2 = malloc(len2+1); // one for the null terminator

    memcpy(s1, last_arg, len1);
    memcpy(s2, last_arg+len1, len2);

    s1[len1] = '\0';
    s2[len2] = '\0';

    // create new param array for child forks to contain splitted string (since it's length, we need to add 2, not 1)
    char *arg1[argc + 2];
    char *arg2[argc + 2];
    for(int i = 0; i < (argc + 1); i++) {
        if (i < argc) {
            arg1[i] = malloc(strlen(argv[i]) + 1);
            strcpy(arg1[i], argv[i]);

            arg2[i] = malloc(strlen(argv[i]) + 1);
            strcpy(arg2[i], argv[i]);
        } else {
            arg1[i] = malloc(len1 + 1);
            strcpy(arg1[i], s1);

            arg2[i] = malloc(len2 + 1);
            strcpy(arg2[i], s2);
        }
    }
    arg1[argc + 1] = NULL;
    arg2[argc + 1] = NULL;

    // fork first child
    pid1 = fork();
    if (pid1) {
        // in parent
        // fork second child
        pid2 = fork();
        if (pid2) {
            // in parent
            // wait for signal
            while(recv_sig == 0);
            kill(pid1, SIGINT);
            kill(pid2, SIGINT);

            // wait for all children to finish
            while ((wpid = wait(&status)) > 0);
        } else if (pid2 == 0) {
            // in second child
            // move to other pgid
            setpgid(0, 0);
            // execute this script once again with new params
            execv("/home/vandavv/dev/zut/IT-Labs/so2/04/main.out", arg1);
            printf("ERROR: execl not launched!\n");
            return 1;
        } else {
            printf("fork error\n");
            return 1;
        }
    } else if (pid1 == 0) {
        // in first child
        // move to other pgid
        setpgid(0, 0);
        // execute this script once again with new params
        execv("/home/vandavv/dev/zut/IT-Labs/so2/04/main.out", arg2);
        printf("ERROR: execl not launched!\n");
        return 1;
    } else {
        printf("fork error\n");
        return 1;
    }

    // finish process
    printf("%d", getpid());
    for( int i = 1; i < argc; ++i ) {
        printf(" %s ", argv[ i ] );
    }
    printf("\n");
    free(s1);
    free(s2);
    for(int i = 0; i < (argc + 1); i++) {
        free(arg1[i]);
        free(arg2[i]);
    }
    sigprocmask(SIG_UNBLOCK, &jset, NULL);
    return 0;
}
