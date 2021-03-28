#include <stdio.h>
#include <stdlib.h>

int latura(int a, int b, int c, int p) {
    if ((a + b > c) && (a + c > b) && (b + c > a) && (a + b + c == p))
        return 1;

    return 0;
}

void triunghi(int p) {
    int i, j, k;

    for (i = 1; i <= p; i++)
        for (j = 1; j <= p - i; j++)
            for (k = 1; k <= p - i - j; k++)
                if (latura(i, j, k, p))
                    printf("( %d,%d,%d )", i, j, k);
}

int main() {
    int p;
    printf("Perimetrul triughiului este: ");
    scanf("%d", &p);

    triunghi(p);

    return 0;
}
