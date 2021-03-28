#include <stdio.h>
#include <stdlib.h>

void eliminaCifra(int n, int c) {
    int i, nr = 0, v[10], x = 0;

    while (n != 0) {
        if (n % 10 != c) v[nr++] = n % 10;
        n = n / 10;
    }

    for (i = nr - 1; i >= 0; i--)
        x = x * 10 + v[i];

    printf("\n %d", x);
}

int main() {
    int n, c;
    printf("n= ");
    scanf("%d", &n);
    printf("c= ");
    scanf("%d", &c);

    eliminaCifra(n, c);

    return 0;
}
