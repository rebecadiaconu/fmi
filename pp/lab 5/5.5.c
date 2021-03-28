#include <stdio.h>
#include <stdlib.h>

void citire(int n, int m, int a[n][m]) {
    int i, j;
    for (i = 0; i < n; i++)
        for (j = 0; j < m; j++) {
            printf("a[%d][%d]= ", i, j);
            scanf("%d", &a[i][j]);
        }
}

void afisareSpirala(int n, int m, int a[n][m]) {
    int i = 0, j = 0, mini = 0, minj = 0, maxi = n - 1, maxj = m - 1;

    printf("Parcurgerea in spirala a matricei este: ");
    while (mini <= maxi && minj <= maxj) {
        for (j = minj; j <= maxj && minj <= maxj; j++)
            printf("%d ", a[i][j]);

        j = maxj;
        mini++;

        for (i = mini; i <= maxi && mini <= maxi; i++)
            printf("%d ", a[i][j]);

        i = maxi;
        maxi--;
        maxj--;

        for (j = maxj; j >= minj && minj <= maxj; j--)
            printf("%d ", a[i][j]);

        j = minj;

        for (i = maxi; i >= mini && mini <= maxi; i--)
            printf("%d ", a[i][j]);

        i = mini;
        minj++;
    }
}

int main() {
    int n, m;
    printf("Dimensiunile matricei sunt( nr. de linii si coloane): ");
    scanf("%d %d", &n, &m);

    int a[n][m];
    citire(n, m, a);
    afisareSpirala(n, m, a);

    return 0;
}
