#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void cuv(char *nume, char *fisier, char *cuvant) {
    char *sir = NULL, a, *p;
    int nr = 0;

    FILE *f = fopen(nume, "r");
    FILE *g = fopen(fisier, "w");

    if (f == NULL) printf("Nu am putut deschide fisierul %s \n", nume);
    if (g == NULL) printf("Nu am putut deschide fisierul %s \n", fisier);

    while (feof(f) == 0) {
        fscanf(f, "%c", &a);
        if (feof(f)) break;
        sir = realloc(sir, (nr + 1));
        sir[nr] = a;
        nr++;
    }

    p = strtok(sir, " ,.?");
    while (p) {
        if (strstr(p, cuvant) != 0)
            fprintf(g, "%s ", p);
        p = strtok(NULL, " ,.?");
    }

    fclose(f);
    fclose(g);
}

int main() {
    char cuvant[101], nume_fis[101], text[101];

    printf("cuvantul este: ");
    scanf("%s", cuvant);
    printf("Numele fisierului din care citim este: ");
    scanf("%s", nume_fis);
    printf("Numele fisierului in care scriem este: ");
    scanf("%s", text);

    cuv(nume_fis, text, cuvant);

    return 0;
}