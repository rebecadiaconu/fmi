#include <stdio.h>
#include <stdlib.h>

int prim(int x) {
    int i;
    for (i = 2; i <= x / 2; i++)
        if (x % i == 0) return 0;

    return 1;
}

int numar(int n) {
    int i, j, d1 = 0, d2 = 0;
    i = n - 1;
    j = n + 1;

    while (prim(i) == 0 && i > 0) i--;;
    while (prim(j) == 0) j++;

    d1 = n - i;
    d2 = j - n;
    if (d1 <= d2) return i;

    else return j;
}

int main() {
    int n;
    printf("Numarul este: ");
    scanf("%d", &n);
    printf("Numarul prim cel mai apropiat de %d este: %d .", n, numar(n));

    return 0;
}
