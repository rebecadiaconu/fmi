#include <stdio.h>
#include <stdlib.h>

int suma(int x) {
    int c, s = 0;
    while (x != 0) {
        c = x % 10;
        s = s + c;
        x = x / 10;
    }

    return s;
}

void perechi(int v[100], int m) {
    int i;
    for (i = 0; i < m - 1; i++) {
        if (v[i] % suma(v[i]) == v[i + 1])
            printf("( %d,%d ) ", v[i], v[i + 1]);
    }
}o

int main() {
    int x, v[100], i, m = 0;
    printf("x= ");
    scanf("%d", &x);

    while (x != 0) {
        v[m] = x;
        m++;
        printf("x= ");
        scanf("%d", &x);
    }
    perechi(v, m);

    return 0;
}
