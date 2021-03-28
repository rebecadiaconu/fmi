#include <iostream>

using namespace std;

struct nod {
    int poz, val;
    nod *urm;
};

void add_final(nod *&prim, nod *&ultim, int y, int x) {
    if (prim == NULL) {
        prim = new nod;
        prim->val = x;
        prim->poz = y;
        prim->urm = NULL;
        ultim = prim;
    } else {
        nod *r;
        r = new nod;
        r->val = x;
        r->poz = y;
        r->urm = NULL;
        ultim->urm = r;
        ultim = r;
    }
}

void afisare_lista(nod *prim) {
    if (prim == NULL) cout << "lista este vida";
    else {
        nod *r;
        r = prim;
        while (r != NULL) {
            cout << r->poz << " " << r->val << endl;
            r = r->urm;
        }
    }
}

int main() {
    int v[100], y[100], m, n, i, ok;
    nod *p1 = NULL, *pf = NULL, *q1 = NULL, *qf = NULL, *sum1 = NULL, *sumf = NULL;

    cout << "Nr. componente x= ";
    cin >> n;

    cout << "Nr. componente y= ";
    cin >> m;

    for (i = 1; i <= n; i++) {
        cout << "v[" << i << "]=";
        cin >> v[i];
        if (v[i] != 0) add_final(p1, pf, i, v[i]);
    }
    cout << endl;
    afisare_lista(p1);
    cout << endl;

    for (i = 1; i <= m; i++) {
        cout << "y[" << i << "]=";
        cin >> y[i];
        if (y[i] != 0) add_final(q1, qf, i, y[i]);
    }
    cout << endl;
    afisare_lista(q1);
    cout << endl;

    nod *r, *k;
    for (r = p1; r != NULL; r = r->urm)
        add_final(sum1, sumf, r->poz, r->val);

    for (k = q1; k != NULL; k = k->urm) {
        ok = 0;
        for (r = sum1; r != NULL; r = r->urm)
            if (k->poz == r->poz) {
                r->val = r->val + k->val;
                ok = 1;
            }

        if (ok == 0) add_final(sum1, sumf, k->poz, k->val);
    }

    cout << "Suma vectorilor: " << endl;
    afisare_lista(sum1);
    cout << endl;

    int prod = 0;
    for (r = p1; r != NULL; r = r->urm)
        for (k = q1; k != NULL; k = k->urm)
            if (r->poz == k->poz)
                prod = prod + r->val * k->val;

    cout << "Produsul scalar al vectorilor: " << prod;

    return 0;
}
