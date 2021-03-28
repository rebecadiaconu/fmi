#include <stdio.h>
#include <stdlib.h>

int main() {
    int x = 1;
    char *p = (char *) &x;
    int i;
    for (i = 0; i <= 2; i++)
        printf("Octetul %d este %d \n", i, *(p + i));

    return 0;
}
