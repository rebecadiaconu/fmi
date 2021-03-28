#include <iostream>
#include <fstream>

using namespace std;

int grad(int a[100][100], int x, int n) {
    int i, cnt = 0;

    for (i = 0; i < n; i++)
        if (a[x][i] == 1)
            cnt++;

    return cnt;
}

int nr_muchii(int a[100][100], int n) {
    int i, j, cnt = 0;

    for (i = 0; i < n; i++)
        for (j = i; j < n; j++)
            if (a[i][j] == 1)
                cnt++;

    return cnt;
}

void grad_max(int a[100][100], int n) {
    int i, v[100], maxi = 0;

    for (i = 1; i <= n; i++)
        v[i] = grad(a, i - 1, n);

    for (i = 1; i <= n; i++)
        if (v[i] > maxi)
            maxi = v[i];

    for (i = 1; i <= n; i++)
        if (v[i] == maxi)
            cout << i << " ";
}

int main() {
    int n, a[100][100], j, i, p;
    ifstream f("matrice.txt");
    f >> n;

    for (i = 0; i < n; i++)
        for (j = 0; j < n; j++)
            f >> a[i][j];

    cout << "1.Gradul unui nod\n2.Numarul de muchii\n3.Gradul maxim\n";
    cin >> p;

    do {
        switch (p) {
            case 1: {
                cout << "1.Gradul unui nod";
                int x;
                cin >> x;
                cout << "Gradul nodului " << x << " este " << grad(a, x, n);
            }
                break;
            case 2: {
                cout << "2.Numarul de muchii";
                cout << " " << nr_muchii(a, n);
            }
                break;
            case 3: {
                cout << "3.Nodurile cu grad maxim ";
                grad_max(a, n);
            }
                break;
        }

        cin >> p;

    } while (p >= 1 && p <= 3);

    return 0;
}
