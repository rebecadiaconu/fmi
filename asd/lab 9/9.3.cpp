#include <iostream>

using namespace std;

typedef struct {
    int key;
    int info;
} coada;

void heapifymax(coada v[], int n, int i) {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;

    if (l < n && v[l].key > v[largest].key)
        largest = l;

    if (r < n && v[r].key > v[largest].key)
        largest = r;

    if (largest != i) {
        swap(v[i], v[largest]);
        heapifymax(v, n, largest);
    }
}

void heapSortmax(coada v[], int n) {
    for (int i = n / 2 - 1; i >= 0; i--)
        heapifymax(v, n, i);

    for (int i = n - 1; i >= 0; i--) {
        swap(v[0], v[i]);
        heapifymax(v, i, 0);
    }
}

void afisare(coada v[], int n) {
    for (int i = 0; i < n; ++i)
        cout << v[i].info << " ";
    cout << "\n";
}

void maxim(coada v[], int n) {
    cout << v[0].info;
}

void extract_max(coada v[], int &n) {
    cout << v[0].info;

    for (int i = 0; i < n - 1; i++) {}
        v[i] = v[i + 1];
    n--;
}

int main() {
    int x, i, n;
    coada v[100];

    cout << "Introduceti numarul de elemente: ";
    cin >> n;

    cout << "Introduceti numarul si prioritatea acestuia ";
    for (i = 0; i < n; i++)
        cin >> v[i].info >> v[i].key;

    heapSortmax(v, n);
    afisare(v, n);

    cout << "Elementul cu prioritate maxima: ";
    maxim(v, n);
    cout << endl;

    extract_max(v, n);
    cout << endl;

    afisare(v, n);

    return 0;
}
