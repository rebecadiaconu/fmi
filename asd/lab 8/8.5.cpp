#include <iostream>

using namespace std;

int ver(int v[], int n, int &p) {
    int i;

    if (v[0] < v[1]) {
        for (i = 0; i < n - 1; i++)
            if (v[i] > v[i + 1]) break;
        p = i;

        return 1;
    } else {
        for (i = 0; i < n - 1; i++)
            if (v[i] < v[i + 1]) break;
        p = i;

        return -1;
    }
}

int main() {
    int v[100001], n, i, ok, p = -1;
    cin >> n;

    for (i = 0; i < n; i++)
        cin >> v[i];

    ok = ver(v, n, p);

    if (ok == 1) {
        cout << "Numarul are forma de munte\n";
        int i = 0, j = n - 1, a[100001], k = 0;

        while (i <= p && j > p) {
            if (v[i] < v[j]) {
                a[k] = v[i];
                k++;
                i++;
            } else {
                a[k] = v[j];
                k++;
                j--;
            }
        }

        while (i <= p) {
            a[k] = v[i];
            k++;
            i++;
        }

        while (j > p) {
            a[k] = v[j];
            k++;
            j--;
        }

        for (i = 0; i < n; i++)
            v[i] = a[i];

    } else {
        cout << "Numarul are forma de vale\n";

        int i = p, j = p + 1, a[100001], k = 0;

        while (i >= 0 && j < n) {
            if (v[i] < v[j]) {
                a[k] = v[i];
                k++;
                i--;
            } else {
                a[k] = v[j];
                k++;
                j++;
            }
        }

        while (i >= 0) {
            a[k] = v[i];
            k++;
            i--;
        }

        while (j < n) {
            a[k] = v[j];
            k++;
            j++;
        }

        for (i = 0; i < n; i++)
            v[i] = a[i];

    }
    for (int i = 0; i < n; i++)
        cout << v[i] << " ";

    return 0;
}
