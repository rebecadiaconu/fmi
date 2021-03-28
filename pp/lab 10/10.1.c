#include <stdio.h>
#include <stdlib.h>

int main() {
    int **a, **b, n, i, j;
    printf("Dimensiunea matricei A este: ");
    scanf("%d", &n);

    a = (int **) malloc(n * sizeof(int *));
    if (a == NULL) printf("Nu am putut aloca memorie. \n");
    else
        for (i = 0; i < n; i++) {
            a[i] = (int *) malloc(n * sizeof(int));
            for (j = 0; j < n; j++) {
                printf("a[%d][%d]= ", i, j);
                scanf("%d", &a[i][j]);
            }
        }

    b = (int **) malloc(n * sizeof(int *));
    if (b == NULL) printf("Nu am putut aloca memorie. \n");
    else
        for (i = 0; i < n; i++) {
            b[i] = (int *) malloc((n - 1) * sizeof(int));
        }

    int k;
    for (i = 0; i < n; i++) {
        k = 0;
        for (j = 0; j < n; j++)
            if (i != j) {
                b[i][k] = a[i][j];
                k++;
            }
    }

    for (i = 0; i < n; i++) {
        for (j = 0; j < n - 1; j++)
            printf("%d ", b[i][j]);
        printf("\n");
    }

    for (i = 0; i < n; i++)
        free(a[i]);
    free(a);

    for (i = 0; i < n; i++)
        free(b[i]);
    free(b);

    return 0;
}

