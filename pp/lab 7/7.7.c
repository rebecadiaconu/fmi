#include <stdio.h>
#include <stdlib.h>

int maxim(int n, int *v) {
    int i;
    int max = v[0];
    for (i = 1; i < n; i++)
        if (v[i] > max) max = v[i];

    return max;
}

int minim(int n, int *v) {
    int i, min;
    min = v[0];
    for (i = 1; i < n; i++)
        if (v[i] < min) min = v[i];

    return min;
}

int main() {
    int n, m, i, j;
    printf("Dimensiunile matricei (linii si coloane) : ");
    scanf("%d %d", &n, &m);
    int a[n][m];

    for (i = 0; i < n; i++)
        for (j = 0; j < m; j++) {
            printf("a[%d][%d]= ", i, j);
            scanf("%d", &a[i][j]);
        }

    for (i = 0; i < n; i++)
        for (j = 0; j < m; j++)
            if ((maxim(n, a[i]) == a[i][j] && minim(m, a[j]) == a[i][j]) ||
                (maxim(m, a[j]) == a[i][j] && minim(n, a[i]) == a[i][j]))
                printf("%d ", a[i][j]);

    return 0;
}
