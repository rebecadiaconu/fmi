#include <fstream>
#include <iostream>

using namespace std;

int bitone(int v[], int i, int j) {

    int k, l;

    if (i == j) return 1;

    if (v[i] > v[i + 1])
        return 0;
    else {
        for (k = i; k < j - 1; k++)
            if (v[k] > v[k + 1]) {
                for (l = k + 1; l < j; l++)
                    if (v[l] < v[l + 1]) return 0;
            }
        if (k == j - 2) return 0;
    }

    return 1;
}

int main() {

    int n, v[100001], q, i, j, ok;
    ifstream f("bitone.in");
    ofstream g("bitone.out");
    f >> n;

    for (int k = 1; k <= n; k++)
        f >> v[k];

    f >> q;
    for (int k = 1; k <= q; k++) {
        f >> i >> j;
        ok = bitone(v, i, j);
        g << ok;
    }

    f.close();
    g.close();

    return 0;
}
