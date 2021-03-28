#include <stdio.h>
#include <stdlib.h>

int binary_search(int high, int low, int v[], int key) {
    int m;
    while (low <= high) {
        m = low + ((high - low) / 2);
        if (v[m] == key) return m;
        else if (v[m] > key) high = m - 1;
        else low = m + 1;
    }
}

int main() {
    int n, x, y, i;

    printf("n= ");
    scanf("%d", &n);

    printf("x= ");
    scanf("%d", &x);

    printf("y= ");
    scanf("%d", &y);

    int crescator[n];

    for (i = 0; i < n; i++) {
        printf("crescator[%d]=", i);
        scanf("%d", &crescator[i]);
    }

    int poz_x;
    poz_x = binary_search(n, 0, crescator, x);
    printf("Elementele cuprinse intre %d si %d sunt: ", x, y);

    for (i = poz_x; i < n; i++) {
        printf("%d ", crescator[i]);
        if (crescator[i] == y) break;
    }

    return 0;
}
