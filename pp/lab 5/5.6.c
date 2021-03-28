#include <stdio.h>
#include <stdlib.h>

int prim(int x) {
    int i;
    for (i = 2; i <= x / 2; i++)
        if (x % i == 0) return 0;
    return 1;
}

int div_mic(int x) {
    int i;
    for (i = 2; i <= x / 2; i++)
        if (x % i == 0) return i;
}

void vector(int n, int v[n * n]) {
    int i = 0, elem = 1;
    while (i < n * n) {
        if (prim(elem) == 1) {
            v[i] = elem;
            i++;
            elem++;
        } else {
            v[i++] = elem;
            v[i++] = div_mic(elem);
            elem++;
        }
    }
}

void formareSpirala(int n, int a[n][n], int v[n * n]) {
    int k = 0, i = 0, j = 0, mini = 0, maxi = n - 1, minj = 0, maxj = n - 1;
    while (mini <= maxi && minj <= maxj) {
        for (j = minj; j <= maxj && minj <= maxj; j++) {
            a[i][j] = v[k];
            k++;
        }

        j = maxj;
        mini++;
        for (i = mini; i <= maxi && mini <= maxi; i++) {
            a[i][j] = v[k];
            k++;
        }

        i = maxi;
        maxi--;
        maxj--;
        for (j = maxj; j >= minj && minj <= maxj; j--) {
            a[i][j] = v[k];
            k++;
        }

        j = minj;
        for (i = maxi; i >= mini && mini <= maxi; i--) {
            a[i][j] = v[k];
            k++;
        }

        i = mini;
        minj++;
    }
}

int main() {
    int n, i, j;
    printf("Numarul de linii si coloane este: ");
    scanf("%d", &n);
    int a[n][n], v[n * n];

    vector(n, v);
    printf("\n");

    formareSpirala(n, a, v);

    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++)
            printf("%d ", a[i][j]);
        printf("\n");
    }

    return 0;
}

