#include <iostream>
#include <fstream>

using namespace std;

int main() {
    ifstream f("roata.in");
    ofstream g("roata.out");

    int n, p, i, k, pozmax, pozmin, c[100001], b[361];
    f >> n >> p;

    for (i = 1; i <= n; i++)
        b[i] = i;

    for (i = 1; i <= p; i++)
        f >> c[i];

    long long incasare = 0;
    for (i = 1; i <= p; i++)
        incasare = incasare + c[i];

    g << incasare << "\n";

    if (n < p) {
        for (k = n + 1; k <= p; k++) {
            pozmin = 1;

            for (i = 2; i <= n; i++)
                if (c[i] < c[pozmin])
                    pozmin = i;

            g << b[pozmin] << " ";

            if (c[pozmin] > 100001)
                for (i = 1; i <= n; i++)
                    c[i] -= 100001;

            c[pozmin] += c[k];
            b[pozmin] = k;
        }
    }
    pozmax = 1;

    for (i = 2; i <= n; i++)
        if (c[i] >= c[pozmax])
            pozmax = i;

    for (k = 1; k <= n; k++) {
        pozmin = 1;

        for (i = 2; i <= n; i++)
            if (c[i] < c[pozmin])
                pozmin = i;

        g << b[pozmin] << " ";
        c[pozmin] += 100001;
    }

    g << "\n";
    g << pozmax;

    f.close();
    g.close();

    return 0;
}
