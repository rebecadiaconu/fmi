#include <iostream>
#include <fstream>

using namespace std;

int n;
int m;
int v[100];

int main() {
    ifstream f("fisier.txt");
    f >> n >> m;
    int i, j, k, aux;

    for (k = 1; k <= m; k++) {
        f >> i >> j;
        if (i > j) {
            aux = i;
            i = j;
            j = aux;
        }

        if (v[i] == 0 && v[j] == 0) {
            v[i] = i;
            v[j] = i;
        }
        else if (v[i] != 0 && v[j] == 0)
            v[j] = v[i];
        else if (v[i] != 0 && v[j] != 0) {
            for (int t = 1; t <= n; t++) {
                if (v[t] == v[j])
                    v[t] = v[i];
            }
        }
    }

    for (i = 1; i <= n; i++) {
        if (v[i] == 0)
            v[i] = i;
    }

    int ok = 1;

    for (j = 1; j <= n; j++) {
        ok = 1;

        for (i = 1; i <= n; i++) {
            if (v[i] == j) {
                if (ok == 1) {
                    cout << "Componenta conexa : ";
                    ok = 0;
                }

                cout << i << " ";
            }
        }

        if (ok == 0)
            cout << endl;
    }

    return 0;
}


