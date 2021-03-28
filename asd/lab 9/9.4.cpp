#include <iostream>

using namespace std;

int shellSort(int v[], int n) {
    for (int gap = n / 2; gap > 0; gap /= 2) {
        for (int i = gap; i < n; i += 1) {
            int temp = v[i];
            int j;
            for (j = i; j >= gap && v[j - gap] > temp; j = j - gap)
                v[j] = v[j - gap];
            v[j] = temp;
        }
    }

    return 0;
}

void afisare(int v[], int n) {
    for (int i = 0; i < n; i++)
        cout << v[i] << " ";
    cout << "\n";
}

int main() {
    int n = 0, x, v[100];
    cout << "Se citesc numere pana la intalnirea lui 0:";
    cin >> x;

    while (x != 0) {
        v[n] = x;
        n++;
        cin >> x;
    }

    shellSort(v, n);

    afisare(v, n);

    return 0;
}


