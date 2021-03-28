#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

void Swap(char *nume) {
    FILE *f = fopen(nume, "r+b");

    if (f == NULL) printf("Nu am putut deschide fisierul. \n");

    char *cuv = NULL, ch;
    int i, nr = 0;

    while (feof(f) == 0) {
        fscanf(f, "%c", &ch);
        if (feof(f)) break;

        if (ch >= 'a' && ch <= 'z') {
            cuv = realloc(cuv, (nr + 1) * sizeof(char));
            cuv[nr] = ch - 32;
            nr++;
        } else {
            cuv = realloc(cuv, (nr + 1) * sizeof(char));
            cuv[nr] = ch + 32;
            nr++;
        }
    }

    fclose(f);

    f = fopen(nume, "w");
    for (i = 0; i < nr; i++)
        fprintf(f, "%c", cuv[i]);

    fclose(f);

}

int main() {
    char nume[101];

    printf("Numele fisierului este: ");
    scanf("%s", nume);
    Swap(nume);

    return 0;
}