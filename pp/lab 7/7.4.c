#include <stdio.h>
#include <stdlib.h>

#define lungMax 16

void pozPareImpare(int n) {
    int nr = 0, i, v[lungMax];

    while (n != 0) {
        v[nr++] = n % 10;
        n = n / 10;
    }

    for (i = nr - 1; i >= 0; i = i - 2)
        printf("%d", v[i]);

    printf("  ");
    for (i = nr - 2; i >= 0; i = i - 2)
        printf("%d", v[i]);
}

int main() {
    int n;
    printf("n= ");
    scanf("%d", &n);
    pozPareImpare(n);

    return 0;
}
