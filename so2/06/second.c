// http://www.yolinux.com/TUTORIALS/LinuxTutorialPosixThreads.html
#define _GNU_SOURCE
#include <crypt.h>
#include <stdio.h>
#include <pthread.h>
#include <stdbool.h>
#include <limits.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <syscall.h>

#define SEARCH_VALUE ("$6$5MfvmFOaDU$CVt7jU9wJRYz3K98EklAJqp8RMG5NvReUSVK7ctVvc2VOnYVrvyTfXaIgHn2xQS78foEJZBq2oCIqwfdNp.2V1")
#define SEARCH_MAX (254002730)
#define MAX_LINES (20577921)
#define FILENAME "/home/vandavv/dev/zut/IT-Labs/so2/06/medium.txt"

int count = 0;

typedef struct {
    int start;
    int end;
    char *search;

    bool* shouldStop;
    char** answer;
    pthread_mutex_t* answerMutex;
    pthread_cond_t* answerFound;

    pthread_t thisThread;
} find_worker_init;

void* find_value(void* vpInitInfo) {
    find_worker_init* pUnitOfWork = (find_worker_init*)vpInitInfo;
    int offset = pUnitOfWork->start;

    if(offset > 0) {
        offset -= 35; //longest password has 35 chars so we move offset 35 chars back to be sure that we use every pass
    }
    struct crypt_data data[1] = {0};

    FILE *fp;
    char *line = NULL;
    size_t len = 0;

    if ((fp = fopen(FILENAME, "r")) == NULL)
        return NULL;

    if (offset > 0 && fseek(fp, offset, SEEK_SET) != 0) {
        fclose(fp);
        return NULL;
    }

    int cValue = pUnitOfWork->start;

    while (!(*(pUnitOfWork->shouldStop)) && (getline(&line, &len, fp) != -1)) {
        if (line[strlen(line) - 1] == '\n') {
            line[strlen(line) - 1] = '\0';
        }

        char* result = crypt_r(line, "$6$5MfvmFOaDU", data);
        if (strcmp(result,  pUnitOfWork->search) == 0) {
            printf("found value\n");

            // found the search value
            pthread_mutex_lock(pUnitOfWork->answerMutex);
            if (!(*(pUnitOfWork->shouldStop))) {
                *(pUnitOfWork->shouldStop) = true;
                *(pUnitOfWork->answer) = result;

                pthread_cond_broadcast(pUnitOfWork->answerFound);
            }
            pthread_mutex_unlock(pUnitOfWork->answerMutex);

            if ((offset = ftell(fp)) < 0) {
                free(line);
                fclose(fp);

                printf("[0] EXIT PROCESS ID %d\n", syscall(SYS_gettid));
                return NULL;
            }

            free(line);
            fclose(fp);


            printf("[1] EXIT PROCESS ID %d\n", syscall(SYS_gettid));
            return NULL;
        }

        cValue++;
        count++;
        if(count % 3000 == 0) {
            printf("Progress: %.2f%%\n", (count / (float) MAX_LINES) * 100);
        }
        if (cValue == pUnitOfWork->end) {
            // we exhausted our search space, end.
            printf("exhausted\n");

            if ((offset = ftell(fp)) < 0) {
                free(line);
                fclose(fp);
                printf("[2] EXIT PROCESS ID %d\n", syscall(SYS_gettid));
                return NULL;
            }

            free(line);
            fclose(fp);
            printf("[3] EXIT PROCESS ID %d\n", syscall(SYS_gettid));
            return NULL;
        }
    }

    if ((offset = ftell(fp)) < 0) {
        free(line);
        fclose(fp);
        printf("[4] EXIT PROCESS ID %d\n", syscall(SYS_gettid));
        return NULL;
    }

    free(line);
    fclose(fp);

    // we were usurped by another thread
    printf("usurped\n");
    printf("[5] EXIT PROCESS ID %d\n", syscall(SYS_gettid));
    return NULL;
}

int main( int argc, const char* argv[] ) {
    pthread_mutex_t answerMutex = PTHREAD_MUTEX_INITIALIZER;
    pthread_cond_t answerFound = PTHREAD_COND_INITIALIZER;
    bool shouldStop = false;
    char* answer = "";

    int SEARCH_THREAD_COUNT = sysconf(_SC_NPROCESSORS_ONLN);
    // initialize thread jobs
    find_worker_init startInfo[SEARCH_THREAD_COUNT];
    int current_search_start = 0;
    int search_unit = SEARCH_MAX / SEARCH_THREAD_COUNT;
    for (int i = 0; i < SEARCH_THREAD_COUNT; i++) {
        startInfo[i].start = current_search_start;

        // set the search space for this thread to be either the standard
        // search space, or for the last thread, whatever is remaining
        // (this is to prevent integer-division from skipping a portion
        // at the end)
        int current_size = (i == SEARCH_THREAD_COUNT - 1) 
            ? (SEARCH_MAX - current_search_start) 
            : search_unit;

        startInfo[i].end = current_search_start + current_size;
        startInfo[i].search = SEARCH_VALUE;

        startInfo[i].shouldStop = &shouldStop;
        startInfo[i].answer = &answer;
        startInfo[i].answerMutex = &answerMutex;
        startInfo[i].answerFound = &answerFound;

        current_search_start = current_search_start + current_size;
    }

    // start threads
    for (int i = 0; i < SEARCH_THREAD_COUNT; i++) {
        if (pthread_create(&(startInfo[i].thisThread), NULL, find_value, 
            &(startInfo[i]))) 
        {
            fprintf(stderr, "Error creating thread\n");
            return 1;
        }
    }

    // wait for answer to be found
    pthread_mutex_lock(&answerMutex);
    while (!shouldStop) {
        pthread_cond_wait(&answerFound, &answerMutex);
    }
    printf("signaled\n");

    // join
    for (int i = 0; i < SEARCH_THREAD_COUNT; i++) {
        if (pthread_join(startInfo[i].thisThread, NULL)) {
            fprintf(stderr, "Error joining thread\n");
            return 1;
        }
    }

    // answer
    printf("answer: %s\n", answer);

    pthread_mutex_unlock(&answerMutex);

    return 0;
}
