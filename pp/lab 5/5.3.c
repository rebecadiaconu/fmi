#include <stdio.h>
#include <stdlib.h>

#define max_lung 1240

typedef struct {
    short sign;
    short cifre[max_lung];
    int nr_cifre;
} LongNumber;

LongNumber citire() {

    char numar[max_lung];
    scanf("%1240s", &numar);

    int nr = strlen(numar);

    LongNumber li;
    li.nr_cifre = 0;
    memset(&li, 0, sizeof(li));

    if (numar[0] == '-') li.sign = -1;
    else li.sign = 1;

    int i;
    for (i = (li.sing == 1 ? 0 : 1); i < nr; i++) {
        if (numar[i] >= '0' && numar[i] <= '9')
            li.cifre[li.nr_cifre++] = numar[i] - '0';
    }

    return li;
}

void afisare(LongNumber li) {
    if (li.nr_cifre == 0) printf("0");
    else {
        int i;
        if (li.sign == -1) printf("(-");
        for (i = 0; i < li.nr_cifre; i++)
            printf("%d", li.cifre[i]);
        if (li.sign == -1) printf(")");
    }
}

int main() {

    // apeleaza citire + afisare

    return 0;
}
