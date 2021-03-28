#include <stdio.h>
#include <stdlib.h>

void scriere1(char *text, char *nou) {
    FILE *f = fopen(text, "r");
    FILE *ftext = fopen(nou, "w");

    if (f == NULL) printf("Nu am putut deschide fisierul %s. \n", text);
    if (ftext == NULL) printf("Nu am putut deschide fisierul %s. \n", nou);

    char a, ch;

    fscanf(f, "%c", &ch);

    while (feof(f) == 0) {
        fscanf(f, "%c", &a);
        if (a != ch) fprintf(ftext, "%c", a);
        if (feof(f)) break;
    }

    fclose(f);
    fclose(ftext);
}

void scriere2(char *text) {
    FILE *f = fopen(text, "a+");
    if (f == NULL) printf("Nu am putut deschide fisierul %s. \n", text);

    char a, *cuv = NULL, ch;
    int nr = 0;

    fscanf(f, "%c", &ch);

    while (feof(f) == 0) {
        fscanf(f, "%c", &a);
        if (a != ch) {
            cuv = realloc(cuv, nr + 1);
            cuv[nr] = a;
            nr++;
        }
        if (feof(f)) break;
    }
    fprintf(f, "%s", "\n");
    fprintf(f, "%s", cuv);

    fclose(f);
}

int main() {
    char nume_fisier[101], nume_nou[101];

    printf("Numele fisierului din care citesc este: ");
    scanf("%s", nume_fisier);
    printf("Numele nou al fisierului este: ");
    scanf("%s", nume_nou);

    scriere1(nume_fisier, nume_nou);
    scriere2(nume_fisier);

    return 0;
}
