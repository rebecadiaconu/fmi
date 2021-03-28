#include <iostream>

using namespace std;

struct nod {
    int info;
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

void impartire(nod *&p, nod *u, nod *&prim, nod *&ultim, nod *&first, nod *&last) {
    nod *k;
    prim = p;
    first = p->urm;
    k = prim->urm->urm;
    ultim = prim;
    last = first;
    int poz = 2;

    while (k != NULL) {
        poz++;

        if (poz % 2 == 1) {
            ultim->urm = k;
            ultim = ultim->urm;
        } else {
            last->urm = k;
            last = last->urm;
        }

        k = k->urm;
    }

    ultim->urm = NULL;
    last->urm = NULL;
    p = NULL;
}


int main() {
    int n, i, nr = 0, x;
    nod *prim = NULL, *ultim = NULL, *first = NULL, *last = NULL, *p = NULL, *u = NULL;

    cout << "Nr. elemente lista C= ";
    cin >> n;

    for (i = 1; i <= n; i++) {
        cout << "x= ";
        cin >> x;
        add_final(p, u, x);
    }
    cout << "Lista C: " << endl;
    afisare_lista(p);
    cout << endl;

    impartire(p, u, prim, ultim, first, last);
    cout << endl << "Lista cu pozitiile pare: " << endl;
    afisare_lista(prim);

    cout << endl << "Lista cu pozitiile impare: " << endl;
    afisare_lista(first);
    cout << endl;

    cout << "Lista C dupa distribuire: ";
    afisare_lista(p);

    return 0;
}
