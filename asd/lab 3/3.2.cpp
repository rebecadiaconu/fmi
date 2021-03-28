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
    int n, m, y, x, a, i, j;
    pol *p1 = NULL, *pf = NULL, *q1 = NULL, *qf = NULL;

    cout << "Gradul polinomului P= ";
    cin >> n;

    cout << "Gradul polinomului Q= ";
    cin >> m;

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

    j = 0;
    while (j < m) {
        cout << "y=";
        cin >> y;
        cout << "x=";
        cin >> x;
        add_final(q1, qf, y, x);
        j = y;
    }
    cout << endl;
    afisare_lista(q1);
    cout << endl;

    cout << "a=";
    cin >> a;

    pol *r, *k;
    r = p1;
    while (r != NULL) {
        r->coef = r->coef * a;
        r = r->urm;
    }

    k = q1;
    while (k != NULL) {
        k->coef = k->coef * a;
        k = k->urm;
    }

    afisare_lista(p1);
    cout << endl;

    afisare_lista(q1);
    cout << endl;

    return 0;
}
