#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main(){
    printf("Hello world (pid:%d)\n", (int) getpid());
    int rc = fork();
    if (rc < 0){
        fprintf(stderr, "fork failed\n");
        exit(1);
    } else if (rc == 0) {
       printf("Hello, I'm a new process! (pid:%d)\n", (int) getpid());
       char *myargs[3];
       myargs[0] = strdup("wc"); /* program wc (word count) */
       myargs[1] = strdup("Fork_wait_exec.c"); /* arg: file to count */
       myargs[2] = NULL; /* end of array */
       execvp(myargs[0], myargs); /* runs word count */
       printf("This souldn't print out");
    } else {
       int rc_wait = wait(NULL);
       printf("Hello, I'm a process-parent of %d (rc_wait:%d) (pid:%d)\n", rc, rc_wait, (int) getpid());
    }
    return 0;
}

/* T he child process calls execvp() in order to run the program wc, 
which is the word counting program. In fact, it runs wc on the source file,
thus telling us how many lines, words, and bytes are found in the file. */
