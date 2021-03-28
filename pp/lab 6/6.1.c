#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int main() {
    int n, m, i, j, nr = 0, vmax, x, y;
    /* printf("n= "); scanf("%d", &n);
     printf("Vom genera m numere aleatorii, unde m= "); scanf("%d", &m); */
    n = 10;
    m = 8;
    vmax = -n;

    FILE *f = fopen("random.bin", "wb+");
    FILE *text = fopen("in.txt", "w");
    srand(time(NULL));

    for (i = 0; i < m; i++) {
        x = -n + rand() % (2 * n + 1);

        fwrite(&x, sizeof(int), 1, f);
        fprintf(text, "%d ", x);
        printf("%d ", x);

        if (x > vmax) {
            vmax = x;
            nr = 1;
        } else if (x == vmax) nr++;
    }

    for (i = 0; i < m - 1; i++) {
        for (j = i + 1; j < m; j++) {
            fseek(f, i * sizeof(int), 0);
            fread(&x, sizeof(int), 1, f);
            fseek(f, j * sizeof(int), 0);
            fread(&y, sizeof(int), 1, f);

            if (x > y) {
                fseek(f, j * sizeof(int), 0);
                fwrite(&x, sizeof(int), 1, f);
                fseek(f, i * sizeof(int), 0);
                fwrite(&y, sizeof(int), 1, f);
            }
        }
    }
    printf("\n");
    fseek(f, 0, 0);

    for (i = 0; i < m; i++) {
        fread(&x, sizeof(int), 1, f);
        printf("%d ", x);
    }

    printf("vmax= %d ", vmax);
    printf(" Acesta apare de %d ori.", nr);

    return 0;
}
