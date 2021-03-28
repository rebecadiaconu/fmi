#include <iostream>

using namespace std;

struct nod {
    float info;
    nod *urm;
};

void add_final(nod *&prim, nod *&ultim, int x) {
    if (prim == NULL) {
        prim = new nod;
        prim->info = x;
        prim->urm = NULL;
        ultim = prim;
    } else {
        nod *r;
        r = new nod;
        r->info = x;
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
            cout << r->info << " ";
            r = r->urm;
        }
    }
}


int main() {
    int n, i, x;
    nod *prim = NULL, *ultim = NULL, *p, *q;
    float s, ma;

    cout << "n=";
    cin >> n;

    for (i = 1; i <= n; i++) {
        cout << "x=";
        cin >> x;
        add_final(prim, ultim, x);
    }
    afisare_lista(prim);
    cout << endl;

    p = prim;
    q = prim->urm;
    while (p != NULL && q != NULL) {
        s = 0;
        nod *r;
        r = new nod;
        s = p->info + q->info;
        ma = s / 2.0;
        r->info = ma;
        p->urm = r;
        r->urm = q;
        p = q;
        q = p->urm;
    }

    afisare_lista(prim);

    return 0;
}
