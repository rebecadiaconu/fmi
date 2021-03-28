#include <stdio.h>

void litere(char *nume) {
    int v[31] = {0}, i, max = 0;
    char a;

    FILE *f = fopen(nume, "r");
    if (f == NULL) printf("Nu am putut deschide fisierul. \n");

    while (feof(f) == 0) {
        fscanf(f, "%c", &a);
        if (a >= 'a' && a <= 'z')
            v[a - 'a']++;
        else v[a - 'A']++;
    }

    for (i = 0; i < 31; i++)
        if (v[i] > max) max = v[i];

    for (i = 0; i < 30; i++)
        if (v[i] == max) {
            char c = i + 'a';
            printf("%c ", c);
        }

    fclose(f);

}

int main() {
    char nume[101];

    printf("Numele fisierului este: ");
    scanf("%s", nume);
    litere(nume);

    return 0;
}