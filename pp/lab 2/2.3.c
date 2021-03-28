#include <stdio.h>
#include <stdlib.h>

int main() {
    int x, y, n, p, secv, i, copie;

    printf("Numarul x este:");
    scanf("%d", &x);

    printf("Numarul y este:");
    scanf("%d", &y);

    printf("Pozitia de la care se va incepe copierea este:");
    scanf("%d", &p);

    printf("Numarul de biti ce vor fi copiati este: ");
    scanf("%d", &n);

    secv = y & ((1 << (8 - n))) + (1 << (8 - n + 1)) + (1 << (8 - n + 2));
    secv = secv >> (8 - n - p);
    copie = secv;

    for (i = 0; i <= p; i++)
        if ((secv & (1 << i)) == 0) {
            copie = copie + (1 << i);
        }

    for (i = 8 - n; i <= 7; i++)
        if ((secv & (1 << i)) == 0) {
            copie = copie + (1 << i);
        }

    x = x & copie;
    printf("Noul x este: %d\n", x);

    return 0;
}
