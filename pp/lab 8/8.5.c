#include <stdio.h>
#include <stdlib.h>

void aloca(int n, int *nrn, int *nrp, int v[n], int **neg, int **poz) {
    int i;
    for (i = 0; i < n; i++)
        if (v[i] < 0) (*nrn)++;

    (*nrp) = n - (*nrn);
    (*neg) = (int *) malloc((*nrn) * sizeof(int));
    (*poz) = (int *) malloc((*nrp) * sizeof(int));
}

int main() {
    int n, i, *v, *neg, *poz, nrn = 0, nrp = 0, j = 0, k = 0;
    printf("n= ");
    scanf("%d", &n);
    v = (int *) malloc(n * sizeof(int));

    for (i = 0; i < n; i++) {
        printf("v[%d]= ", i);
        scanf("%d", &v[i]);
    }

    aloca(n, &nrn, &nrp, v, &neg, &poz);

    for (i = 0; i < n; i++)
        if (v[i] < 0) neg[j++] = v[i];
        else poz[k++] = v[i];

    for (i = 0; i < nrn; i++)
        printf("%d ", neg[i]);
    printf("\n");

    for (i = 0; i < nrp; i++)
        printf("%d ", poz[i]);

    free(neg);
    free(poz);
    free(v);

    return 0;
}
