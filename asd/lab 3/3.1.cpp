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

void add_inceput(nod *&prim, nod *&ultim, int x) {
    if (prim == NULL) {
        prim = new nod;
        prim->info = x;
        prim->urm = NULL;
        ultim = prim;
    } else {
        nod *r;
        r = new nod;
        r->info = x;
        r->urm = prim;
        prim = r;
    }
}

int verifica_val(nod *prim, int val) {
    nod *p = prim;
    while (p != NULL)
        if (p->info == val) return 1;
        else p = p->urm;

    return 0;
}

void add_interior(nod *&prim, nod *ultim, int val, int x) {
    if (verifica_val(prim, val) == 1) {
        nod *q = new nod;
        q->info = x;
        q->urm = NULL;

        if (prim == NULL) prim = q;

        if (prim->info == val) {
            q->urm = prim->urm;
            prim->urm = q;
        } else {
            nod *r, *k;
            k = prim->urm;
            r = k->urm;

            while (k != NULL && k->info != val) {
                k = r;
                r = r->urm;
            }

            if (k->info == val) {
                k->urm = q;
                q->urm = r;
            }
        }
    } else cout << "Valoarea nu este in lista." << endl;
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
    int x, i, n, aux;
    nod *prim = NULL, *ultim = NULL;

    cout << "n=";
    cin >> n;

    for (i = 1; i <= n; i++) {
        cout << "x=";
        cin >> x;

        if (prim == NULL || x < prim->info) {
            add_inceput(prim, ultim, x);
        } else {
            if (x > ultim->info) add_final(prim, ultim, x);
            else {
                nod *p;
                p = prim;

                while (p != NULL) {
                    if (x > p->info && x < p->urm->info) add_interior(prim, ultim, p->info, x);
                    p = p->urm;
                }
            }
        }
    }

    afisare_lista(prim);

    return 0;
}
