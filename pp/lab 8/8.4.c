#include<stdio.h>
#include<stdlib.h>
#include<math.h>

typedef struct {
    int real, imag;
} complex;

double modul(int a, int b) {
    double c = sqrt(a * a + b * b);
    return c;
}

void modulNr(int n, complex *v) {
    int i, poz;
    float vmax = 0;

    for (i = 0; i < n; i++)
        if (modul(v[i].real, v[i].imag) > vmax) {
            vmax = modul(v[i].real, v[i].imag);
            poz = i;
        }
    printf("Numarul cu modulul cel mai mare este: %d + %d i.\n", v[poz].real, v[poz].imag);
}

int main() {
    int n, i;
    printf("n= ");
    scanf("%d", &n);
    complex *v = (complex *) malloc(n * sizeof(complex));

    for (i = 0; i < n; i++) {
        printf("Partea reala si cea imaginara pentru numarul %d :", i + 1);
        scanf("%d %d", &v[i].real, &v[i].imag);
    }

    for (i = 0; i < n; i++) {
        printf(" numarul %d este: %d + %d i.\n", i + 1, v[i].real, v[i].imag);
    }

    modulNr(n, v);
    free(v);

    return 0;
}

