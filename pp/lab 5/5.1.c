#include <stdio.h>
#include <stdlib.h>

#define Nr_Max 4000

int v[Nr_Max];

int comun(int v[Nr_Max]) {
    int i, nr = 0;
    for (i = 0; i < Nr_Max; i++)
        if (v[i] == 2) nr++;
    return nr;
}

int main() {
    int n, m, i, x;
    printf("Nr. de elemente ale multimii A: ");
    scanf("%d", &n);

    printf("Nr. de elemente ale multimii B: ");
    scanf("%d", &m);

    for (i = 0; i < n; i++) {
        printf("x= ");
        scanf("%d", &x);
        if (x < 0) v[x + 2000]++;
        else v[x]++;
    }

    for (i = 0; i < m; i++) {
        printf("x= ");
        scanf("%d", &x);
        if (x < 0) v[x + 2000]++;
        else v[x]++;
    }
    printf("Numarul de elemente comune este: %d\n", comun(v));

    return 0;


}
