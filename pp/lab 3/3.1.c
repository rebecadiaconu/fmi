#include <stdio.h>
#include <stdlib.h>

void caracter(char *c) {
    if (*c >= 'A' && *c <= 'Z') {
        *c = *c + 32;
        printf("%c", *c);
    } else printf("%c", *c);
}

int main() {
    char c;
    printf("Caracterul este: ");
    scanf("%c", &c);

    caracter(&c);

    return 0;
}

