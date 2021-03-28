#include <iostream>

using namespace std;

void merge(int v[], int l, int m, int r) {
    int i, j, k, n1, n2, L[500], R[500];
    n1 = m - l + 1;
    n2 = r - m;

    for (i = 0; i < n1; i++)
        L[i] = v[l + i];

    for (j = 0; j < n2; j++)
        R[j] = v[m + 1 + j];

    i = 0;
    j = 0;
    k = l;

    while (i < n1 && j < n2) {
        if (L[i] < R[j]) {
            v[k] = L[i];
            i++;
        } else {
            v[k] = R[j];
            j++;
        }
        k++;
    }
    while (i < n1) {
        v[k] = L[i];
        i++;
        k++;
    }
    while (j < n2) {
        v[k] = R[j];
        j++;
        k++;
    }
    return;
}

void insertionSort(int v[], int l, int r) {
    int i, nr, j;
    for (i = l + 1; i <= r; i++) {
        nr = v[i];
        j = i - 1;

        while (j >= l && v[j] > nr) {
            v[j + 1] = v[j];
            j--;
        }
        v[j + 1] = nr;
    }
    return;
}

void mergeSortOpt(int v[], int l, int r) {
    if (r - l + 1 < 10)
        insertionSort(v, l, r);

    else if (l < r) {
        int m = (l + r) / 2;

        mergeSortOpt(v, l, m);
        mergeSortOpt(v, m + 1, r);

        merge(v, l, m, r);
    }
    return;
}

int main() {
    int n, v[1000], i;

    cout << "n = ";
    cin >> n;
    cout << "v: ";
    for (i = 0; i < n; i++)
        cin >> v[i];

    mergeSortOpt(v, 0, n - 1);

    cout << "\nv sortat: ";
    for (i = 0; i < n; i++)
        cout << v[i] << " ";
    cout << "\n";

    return 0;
}
