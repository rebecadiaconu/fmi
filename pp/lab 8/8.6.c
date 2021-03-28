#include <stdio.h>
#include <stdlib.h>

int main() {
    int n, i, vmax, *maxim, nr = 0, k = 0;
    printf("n= ");
    scanf("%d", &n);
    int *v;
    v = (int *) malloc(n * sizeof(int));

    for (i = 0; i < n; i++) {
        printf("v[%d]= ", i);
        scanf("%d", &v[i]);
    }

    vmax = v[0];
    for (i = 1; i < n; i++)
        if (v[i] > vmax) {
            vmax = v[i];
            nr = 1;
        } else if (v[i] == vmax) nr++;

    maxim = (int *) malloc(nr * sizeof(int));
    for (i = 0; i < n; i++)
        if (vmax == v[i]) {
            maxim[k++] = i;
        }

    for (i = 0; i < nr; i++)
        printf("%d ", maxim[i]);

    free(maxim);
    free(v);

    return 0;
}

