#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int rest(int n) {
    if (n % 4 == 0) return 0;
    else return n % 4;
}

void validare(int x) {
    if (x < 10) printf("%d", x);
    else {
        char c;
        c = 'A' + (x - 10);
        printf("%c", c);

    }
}

void afisare16(int n, int k, char s[100]) {
    int i, j, x, p;
    for (i = k; i < n; i = i + 4) {
        x = 0;
        p = 3;
        for (j = i; j < i + 4; j++) {
            if (s[j] == '1') x = x + (1 << p);
            p--;
        }
        validare(x);
    }
}

void afisrest(int k, char s[100]) {
    int p, x, i;
    p = k - 1;
    x = 0;
    while (p >= 0) {
        for (i = 0; i < k; i++)
            if (s[i] == '1') x = x + (1 << p);
        p--;
    }
    validare(x);
}

int main() {
    char s[100];
    int n;

    printf("Numarul x este:");
    scanf("%s", &s);
    n = strlen(s);

    int rest1 = rest(n);

    if (rest1 == 0)
        afisare16(n, rest1, s);
    else {
        afisrest(rest1, s);
        afisare16(n, rest1, s);
    }

    return 0;
}
