#include <stdio.h>
#include <stdlib.h>

void permutaCircular(int n, int *v, int m) {
    int i, nr = 0, aux;

    while (nr < m) {
        aux = v[n - 1];
        for (i = n - 1; i > 0; i--)
            v[i] = v[i - 1];
        v[0] = aux;
        nr++;
    }
}

int main() {
    int n, m, k, i, j;
    printf("Dimensiunile matricei (linii si coloane) sunt: ");
    scanf("%d %d", &n, &k);
    int a[n][k];

    for (i = 0; i < n; i++)
        for (j = 0; j < k; j++) {
            printf("a[%d][%d]= ", i, j);
            scanf("%d", &a[i][j]);
        }
    printf("Nr. de permutari este: ");
    scanf("%d", &m);

    for (i = 0; i < n; i++)
        permutaCircular(k, a[i], m);

    for (i = 0; i < n; i++) {
        for (j = 0; j < k; j++)
            printf("%d ", a[i][j]);
        printf("\n");
    }

    return 0;
}
