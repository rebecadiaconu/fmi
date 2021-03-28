#include <stdio.h>
#include <stdlib.h>

int sumaDiv(int x) {
    int i, s = 0;
    for (i = 1; i <= x / 2; i++)
        if (x % i == 0) s = s + i;

    return s;
}

int main() {
    int n, a, b;
    printf("n= ");
    scanf("%d", &n);

    for (a = 1; a <= n; a++)
        for (b = a + 1; b <= n; b++)
            if (sumaDiv(a) == sumaDiv(b)) printf("(%d,%d), ", a, b);

    return 0;
}
