#include <stdio.h>
#include <stdlib.h>

void afisare(int n, int a[n][n]) {
    int i, j;
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++)
            printf("%d ", *(*(a + i) + j));
        printf("\n");
    }
    printf("\n");
}

void impar(int n, int a[n][n]) {
    if (n % 2 == 0) printf("n este numar par.\n");
    else {
        int x;
        x = n / 2;
        printf("Elementul care se afla la intersectia diagonalelor este: %d", *(*(a + x) + x));
        printf("\n");
    }
}

void afisareDiagonale(int n, int a[n][n]) {
    int i, j;

    printf("Elementele de pe diagonala principala sunt: ");
    for (i = 0; i < n; i++)
        printf("%d ", *(*(a + i) + i));

    printf("\n");
    printf("Elementele de pe diagonala secundara sunt: ");
    for (i = 0; i < n; i++)
        printf("%d ", *(*(a + i) + (n - i - 1)));

    printf("\n");
}

void interschimbare(int n, int a[n][n], int i, int j) {
    int p;
    for (p = 0; p < n; p++) {
        int aux;
        aux = *(*(a + i) + p);
        *(*(a + i) + p) = *(*(a + j) + p);
        *(*(a + j) + p) = aux;
    }
}

int main() {
    int n, i, j;
    printf(" n= ");
    scanf("%d", &n);
    int a[n][n];

    for (i = 0; i < n; i++)
        for (j = 0; j < n; j++) {
            printf("a[%d][%d]= ", i, j);
            scanf("%d", &a[i][j]);
        }

    afisare(n, a);
    impar(n, a);
    afisareDiagonale(n, a);

    printf("Liniile pe care le interschimbam sunt: ");
    scanf("%d %d", &i, &j);
    interschimbare(n, a, i, j);

    afisare(n, a);

    return 0;
}
