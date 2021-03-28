#include <stdio.h>
#include <stdlib.h>

void transpusa(int n, int m, int matriceA[n][m], int matriceT[m][n]) {
    int i, j;

    for (i = 0; i < n; i++)
        for (j = 0; j < m; j++)
            matriceT[j][i] = matriceA[i][j];
}

int main() {
    int m, n;

    printf("Nr. linii: ");
    scanf("%d", &n);
    printf("Nr. coloane: ");
    scanf("%d", &m);

    int matriceA[n][m], matriceTranspusa[m][n];
    int i, j;

    for (i = 0; i < n; i++)
        for (j = 0; j < m; j++) {
            printf("matriceA[%d][%d]=", i, j);
            scanf("%d", &matriceA[i][j]);
        }

    transpusa(n, m, matriceA, matriceTranspusa);

    for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++)
            printf("%d ", matriceTranspusa[i][j]);
        printf("\n");
    }
    return 0;
}
