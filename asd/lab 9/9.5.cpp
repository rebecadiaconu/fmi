#include <cstdlib>
#include <iostream>
#include <time.h>

using namespace std;

void afisare(int v[], int n) {
    for (int i = 0; i < n; i++)
        cout << v[i] << " ";
    cout << "\n";
}

void insertionSort(int v[], int low, int high) {
    int i, nr, j;

    for (i = low + 1; i <= high; i++) {
        nr = v[i];
        j = i - 1;

        while (j >= low && v[j] > nr) {
            v[j + 1] = v[j];
            j--;
        }
        v[j + 1] = nr;
    }

    return;
}

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
    if (high - low + 1 <= 11)
        insertionSort(v, low, high);

    if (low < high) {
        int pi = partition_r(v, low, high);
        quickSort(v, low, pi);
        quickSort(v, pi + 1, high);
    }
}

int main() {
    int n;
    cin >> n;

    int v[n];
    for (int i = 0; i < n; i++)
        cin >> v[i];

    quickSort(v, 0, n - 1);
    afisare(v, n);

    return 0;
}

