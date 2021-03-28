#include <stdio.h>
#include <stdlib.h>

int main() {
    int n, x, bitn, c;

    printf("Numarul este: ");
    scanf("%d", &x);
    c = x;

    printf("n= ");
    scanf("%d", &n);

    if (x & (1 << n) == 0) bitn = 0;
    else bitn = 1;
    printf("Bitul de pe pozitia n este: %d\n", bitn);

    if (bitn == 0) x = x + (1 << n);
    else x = x - (1 << n);
    printf("Numarul %d dupa setarea bitului %d este: %d\n", c, n, x);

    return 0;
}
