#include <stdio.h>
#include <stdlib.h>

int main() {
    int x, m = 0, v[30], i, c;
    printf("Numarul este: ");
    scanf("%d", &x);
    c = x;

    while (x != 0) {
        v[m] = x % 2;
        x = x / 2;
        m++;
    }

    printf("Numarul %d scris binar este: \n", c);
    for (i = 0; i < m; i++) {
        printf("%d", v[i]);
    }

    return 0;
}
