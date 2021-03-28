#include <iostream>

using namespace std;

struct pol {
    int gr, coef;
    pol *urm;
};

void add_final(pol *&prim, pol *&ultim, int poz, int x) {
    if (prim == NULL) {
        prim = new pol;
        prim->coef = x;
        prim->gr = poz;
        prim->urm = NULL;
        ultim = prim;
    } else {
        pol *r;
        r = new pol;
        r->coef = x;
        r->gr = poz;
        r->urm = NULL;
        ultim->urm = r;
        ultim = r;
    }
}

void afisare_lista(pol *prim) {
    if (prim == NULL) cout << "lista este vida";
    else {
        pol *r;
        r = prim;
        while (r != NULL) {
            if (r->coef != 0) cout << r->gr << " " << r->coef << endl;
            r = r->urm;
        }
    }
}

int main() {
    int n, i, j, x0, x, y, p, s = 0;
    pol *p1 = NULL, *pf = NULL;

    cout << "Gradul polinomului P= ";
    cin >> n;

    cout << "Valoarea x0 este ";
    cin >> x0;

    i = 0;
    while (i < n) {
        cout << "y=";
        cin >> y;
        cout << "x=";
        cin >> x;
        add_final(p1, pf, y, x);
        i = y;
    }
    cout << endl;
    afisare_lista(p1);
    cout << endl;

    pol *r;
    r = p1;
    for (i = 0; i <= n && r != NULL; i++) {
        p = 1;
        p = p * r->coef;

        for (j = 1; j <= r->gr; j++)
            p = p * x0;

        s = s + p;
        r = r->urm;
    }
    cout << "P(x0)= " << s;

    return 0;
}
