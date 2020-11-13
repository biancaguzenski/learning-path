/* Understanding and using C pointers */
#include <stdio.h>

int main(){
    int x = 0;
    int* p = &x; // pointer holds x adress
    printf("Value of x = %d\n", x); // prints value of x
    printf("Value of p = %d\n", p); // prints address of x
    printf("Address of x %d\n", &x); // prints address of x /*
    printf("Address of p %d\n", &p); // prints address of p */

    // These address values printed are probably not the real memory addresses, because the OS gives 
    // us arbitrary coverted values to represent the real address memory used.
    
    // Deferencing a pointer using indirection operator = *

    // If you print *p, you will get the value of x instead of its address memory
    printf("Deferencing p = %d", *p);

    int* z = NULL; // z points to null
    printf("z = %d", z);
    // NULL should not be used in other contexts other than pointers.
}