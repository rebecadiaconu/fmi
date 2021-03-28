#include <stdio.h>
#include <stdlib.h>

void scriere(char *fisier) {
    FILE *f = fopen(fisier, "r");
    if (f == NULL) printf("Nu am putut deschide fisierul text %s. \n", fisier);

    char *cuv = NULL, ch1, ch2, a;
    int nr = 0;

    fscanf(f, "%c %c\n", &ch1, &ch2);
    while (1) {
        fscanf(f, "%c", &a);
        if (feof(f)) break;
        if (a == ch1) {
            cuv = realloc(cuv, nr + 1);
            cuv[nr] = ch2;
            nr++;
        } else {
            cuv = realloc(cuv, nr + 1);
            cuv[nr] = a;
            nr++;
        }
    }

    f = fopen(fisier, "w");

    if (f == NULL) printf("Nu am putut deschide fisierul. \n");
    for (int i = 0; i < nr; i++)
        fprintf(f, "%c", cuv[i]);

    fclose(f);
}

int main() {
    char nume_fisier[101];

    printf("Numele fisierului este: ");
    scanf("%s", &nume_fisier);
    scriere(nume_fisier);

    return 0;
}