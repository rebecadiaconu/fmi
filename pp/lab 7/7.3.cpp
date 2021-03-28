#include <iostream>

using namespace std;

#define nrMax_cifre 100

int munte(int x) {
    int i, j, nr = 0, v[nrMax_cifre], poz;

    while (x != 0) {
        v[nr++] = x % 10;
        x = x / 10;
    }

    i = 0;
    while (v[i] <= v[i + 1]) i++;

    poz = i;
    int ok = 1;
    for (j = poz; j < nr; j++)
        if (v[j] < v[j + 1]) ok = 0;
    if (ok == 1 && i != 0) return 1;

    return 0;
}

void numereMunte(int a, int b) {
    int i;

    printf("Numerele de tip munte din intervalul dat sunt: ");
    for (i = a; i <= b; i++)
        if (munte(i) == 1) printf("%d ", i);
}

int main() {
    int a, b;
    printf("Intervalul de forma [a,b] este: ");
    scanf("%d %d", &a, &b);
    numereMunte(a, b);

    return 0;
}

