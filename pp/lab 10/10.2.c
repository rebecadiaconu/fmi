#include <stdio.h>
#include <stdlib.h>

int main() {
    int **matrice, n, i, j;
    printf("Dimensiunea matricei este: ");
    scanf("%d", &n);

    matrice = (int **) malloc(n * sizeof(int *));
    if (matrice == NULL) printf("Nu am putut aloca memorie. \n");
    else
        for (i = 0; i < n; i++) {
            matrice[i] = (int *) malloc((i + 1) * sizeof(int));
        }

    int k = n;
    for (i = 0; i < n; i++) {
        matrice[i][0] = k;
        k--;
    }

    for (j = 0; j < n; j++)
        matrice[n - 1][j] = j + 1;

    for (i = n - 2; i >= 1; i--)
        for (j = 1; j < i + 1; j++)
            matrice[i][j] = matrice[i][j - 1] + matrice[i + 1][j];
    printf(" ");

    for (i = 0; i < n; i++) {
        for (j = 0; j < i + 1; j++)
            printf("%d ", matrice[i][j]);
        printf("\n ");
    }

    for (i = 0; i < n; i++)
        free(matrice[i]);
    free(matrice);

    return 0;
}
