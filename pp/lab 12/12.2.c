#include <stdio.h>
#include <stdarg.h>

int differentORsame(int x, int n, ...) {
    va_list lp;
    va_start(lp, n);
    int i, nrAp = 0, y;

    for (i = 0; i < n; i++) {
        y = va_arg(lp,
        int);
        if (x == y) nrAp++;
    }
    va_end(lp);

    return nrAp;
}

int main() {
    int a, b, c, d;

    printf("a= ");
    scanf("%d", &a);
    printf("b= ");
    scanf("%d", &b);
    printf("c= ");
    scanf("%d", &c);
    printf("d= ");
    scanf("%d", &d);

    if ((differentORsame(a, 3, b, c, d) == 0) && (differentORsame(b, 2, c, d) == 0) &&
        (differentORsame(c, 1, d) == 0))
        printf("Sunt distincte. \n");
    else printf("Nu sunt distincte. \n");

    return 0;
}