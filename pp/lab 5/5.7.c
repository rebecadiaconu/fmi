#include <stdio.h>
#include <stdlib.h>

void citire(int n, int a[n][n]) {
    int i, j;
    for (i = 0; i < n; i++)
        for (j = 0; j < n; j++) {
            printf("a[%d][%d]= ", i, j);
            scanf("%d", &a[i][j]);
        }
}

void rotire(int n, int a[n][n], int b[n][n]) {
    int i, j, q;
    for (i = 0; i < n; i++)
        for (j = 0; j < n; j++)
            b[i][j] = a[n - j - 1][i];
}

void afisare(int n, int b[n][n]) {
    int i, j;
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++)
            printf("%d ", b[i][j]);
        printf("\n");
    }
}

int main() {
    int n;
    printf("n= ");
    scanf("%d", &n);
    int a[n][n], b[n][n];

    citire(n, a);
    rotire(n, a, b);
    afisare(n, b);

    return 0;
}
