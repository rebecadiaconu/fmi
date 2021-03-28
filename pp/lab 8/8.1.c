#include <stdio.h>
#include <stdlib.h>

int main() {
    int x = 1;
    *((char *) (&x)) == 1 ? printf("Little endian\n") : printf("Big endian\n");

    return 0;
}
