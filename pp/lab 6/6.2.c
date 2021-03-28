#include <stdio.h>

int main() {
    FILE *f, *out_poz, *out_neg;
    f = fopen("numere.txt", "r");

    out_poz = fopen("poz.bin", "a+");
    out_neg = fopen("neg.bin", "a+");

    int n, i, x, nrn = 0, nrp = 0;
    fscanf(f, "%d", &n);

    for (i = 0; i < n; i++) {
        fscanf(f, "%d", &x);
        //printf("%d ", x);
        if (x < 0) {
            fwrite(&x, sizeof(int), 1, out_neg);
            nrn++;
        } else {
            fwrite(&x, sizeof(int), 1, out_poz);
            nrp++;
        }
    }
    printf(" %d %d ", nrn, nrp);

    fseek(out_neg, 0, 0);
    printf("Numerele negative sunt: ");
    for (i = 0; i < nrn; i++) {
        fread(&x, sizeof(int), 1, out_neg);
        printf("%d ", x);
    }

    fseek(out_poz, 0, 0);
    printf("\n");
    printf("Numerele pozitive sunt: ");
    for (i = 0; i < nrp; i++) {
        fread(&x, sizeof(int), 1, out_poz);
        printf("%d ", x);
    }

    return 0;
}
