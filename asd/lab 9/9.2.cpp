#include <iostream>

using namespace std;

void heapifymax(int v[], int n, int i) {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;

    if (l < n && v[l] > v[largest])
        largest = l;

    if (r < n && v[r] > v[largest])
        largest = r;

    if (largest != i) {
        swap(v[i], v[largest]);
        heapifymax(v, n, largest);
    }
}

void heapSortmax(int v[], int n) {
    for (int i = n / 2 - 1; i >= 0; i--)
        heapifymax(v, n, i);

    for (int i = n - 1; i >= 0; i--) {
        swap(v[0], v[i]);
        heapifymax(v, i, 0);
    }
}

void afisare(int v[], int n) {
    for (int i = 0; i < n; ++i)
        cout << v[i] << " ";
    cout << "\n";
}

int main() {
    int n, v[100];
    cin >> n;

    for (int i = 0; i < n; i++)
        cin >> v[i];

    heapSortmax(v, n);
    afisare(v, n);

    return 0;
}

