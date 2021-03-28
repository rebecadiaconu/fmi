#include <cstdlib>
#include <iostream>
#include <time.h>

using namespace std;

int partition(int v[], int low, int high) {
    int pivot = v[low];
    int i = low - 1, j = high + 1;

    while (true) {
        do {
            i++;
        } while (v[i] < pivot);

        do {
            j--;
        } while (v[j] > pivot);

        if (i >= j)
            return j;

        swap(v[i], v[j]);
    }
}

int partition_r(int v[], int low, int high) {
    srand(time(NULL));
    int random = low + rand() % (high - low);
    swap(v[random], v[low]);

    return partition(v, low, high);
}

void quickSort(int v[], int low, int high) {
    if (low < high) {
        int p = partition_r(v, low, high);
        quickSort(v, low, p);
        quickSort(v, p + 1, high);
    }
}

void afisare(int v[], int n) {
    for (int i = 0; i < n; i++)
        cout << v[i] << " ";
    cout << "\n";
}

int main() {
    int n;
    cout << "Numarul de elemente: ";
    cin >> n;

    int v[n];
    cout << "Elementele sunt: ";
    for (int i = 0; i < n; i++)
        cin >> v[i];

    quickSort(v, 0, n - 1);
    afisare(v, n);

    return 0;
}
