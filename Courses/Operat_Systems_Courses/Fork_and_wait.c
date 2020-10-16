#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

/* This is an exercise is proposed in chapter 5 of the book "Operating Systems: Three Easy Pieces" */

/* The fork() system call and the use of wait() */

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
        /* parent goes down this path */
        int rc_wait = wait(NULL);
        printf("Hello, I'm a process-parent of %d (rc_wait:%d) (pid:%d)\n", rc, rc_wait, (int) getpid());
    }
    return 0;
    /* Here we use wait function wait() */
    /* In this example (p2.c), the parent process calls wait() to delay its execution until 
    the child finishes executing. When the child is done, wait() returns to the parent. */
}