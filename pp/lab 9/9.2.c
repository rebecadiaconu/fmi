#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define maxElem 1000

typedef struct {
    char nume[20];
    int frecv;
} cuvant;

int compara_Frecv(cuvant a, cuvant b) {
    if (a.frecv > b.frecv) return -1;
    if (a.frecv < b.frecv) return 1;
    if (a.frecv == b.frecv) {
        // incomplet
    }
}

void creare_vector(char *nume, int *nrCuv, cuvant v[]) {
    FILE *f = fopen(nume, "r");
    int i, ok, poz, nr = 0;

    while (feof(f) == 0) {
        char sir[500], *p;
        fgets(sir, 500, f);
        p = strtok(sir, " ");

        while (p) {
            if (nr == 0) {
                strcpy(v[nr].nume, p);
                v[nr].frecv = 1;
                nr++;
            } else {
                if (p[strlen(p) - 1] == '\n') p[strlen(p) - 1] = '\0';

                ok = 0;
                for (i = 0; i < nr; i++)
                    if (strcmp(tolower(v[i].nume), tolower(p)) == 0) {
                        poz = i;
                        ok = 1;
                        break;
                    }

                if (ok == 0) {
                    strcpy(v[nr].nume, p);
                    v[nr].frecv = 1;
                    nr++;
                } else v[poz].frecv++;
            }

            p = strtok(NULL, " ");
        }
        if (feof(f)) break;
    }
    *nrCuv = nr;

    fclose(f);
}

void afisare(int nrCuv, cuvant v[nrCuv]) {
    int i;
    qsort(v, nrCuv, sizeof(cuvant), compara_Frecv);

    for (i = 0; i < nrCuv; i++)
        printf("%s %d\n", v[i].nume, v[i].frecv);
}


int main() {
    int nrCuv = 0;
    cuvant v[maxElem];
    creare_vector("cuvinte.txt", &nrCuv, v);
    afisare(nrCuv, v);

    return 0;
}
