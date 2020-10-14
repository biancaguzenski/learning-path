#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/* This is an exercise is proposed in chapter 5 of the book "Operating Systems: Three Easy Pieces" */

/* The fork() system call is used to create a new process */

int main() {
    printf("Hello, world (pid:%d)\n", (int) getpid());
    int rc = fork(); /* store pid */
    
    if(rc < 0) {
        /* fork failed */
        fprintf(stderr, "Fork failed\n");   
        exit(1);
    } else if (rc == 0) {
        /* new process - child */
        printf("Hello, I'm a new process! (pid:%d)\n", (int) getpid());
    } else {
        /* parent goes down this path - the process already created to run this */
        printf("Hello, I'm a process-parent of %d (pid:%d)\n", rc, (int) getpid());
    }
    return 0;
    /* see that when we run Fork, the system create a process. Fork ask to create a process, so the system
    creates a process almost like a exact copy of the first proces. The one created when running Fork is the
    parent, while the one created inside is the child */
}