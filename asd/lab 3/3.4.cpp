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
    int n, m, i, j, x, y, sum;
    pol *p1 = NULL, *pf = NULL, *q1 = NULL, *qf = NULL, *s1 = NULL, *sf = NULL;

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

    pol *a, *b;
    a = p1;
    b = q1;
    while (a != NULL && b != NULL) {
        if (a->gr == b->gr) {
            sum = a->coef + b->coef;
            add_final(s1, sf, a->gr, sum);
            a = a->urm;
            b = b->urm;
        } else if (a->gr < b->gr) {
            add_final(s1, sf, a->gr, a->coef);
            a = a->urm;
        } else {
            add_final(s1, sf, b->gr, b->coef);
            b = b->urm;
        }
    }

    if (a != NULL) {
        add_final(s1, sf, a->gr, a->coef);
        a = a->urm;
    }

    if (b != NULL) {
        add_final(s1, sf, b->gr, b->coef);
        b = b->urm;
    }

    cout << endl;
    afisare_lista(s1);

    return 0;
}
