#include <iostream>

using namespace std;

struct nod {
    int info;
    nod *urm;
};

void lista(nod *&prim, nod *&ultim, int x) {
    nod *p = new nod;
    p->info = x;
    p->urm = NULL;

    if (prim == NULL) {
        prim = p;
        ultim = prim;
    } else {
        ultim->urm = p;
        ultim = p;
    }
}

void add_inceput(nod *&prim, int x) {
    nod *p = new nod;
    p->info = x;
    p->urm = prim;
    prim = p;
}

void add_final(nod *&ultim, nod *prim, int x) {
    nod *p = new nod;
    p->info = x;
    p->urm = NULL;

    if (prim == NULL)
        prim = ultim = p;
    else {
        ultim->urm = p;
        ultim = p;
    }
}

void add_interior(int x, int y, nod *&prim) {
    int ok = 0;
    nod *n, *aux;
    aux = prim;

    n = new nod;
    n->info = x;
    n->urm = NULL;

    if (prim == NULL)
        prim = n;
    else
        while (aux != NULL && ok == 0) {
            if (aux->info == y) {
                n->urm = aux->urm;
                aux->urm = n;
                ok = 1;
            }
            aux = aux->urm;
        }
}

void afisare(nod *prim) {
    nod *r;
    r = prim;

    while (r != NULL) {
        cout << r->info << " ";
        r = r->urm;
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

int main() {
    int n, m, i, x, y;
    nod *prim = NULL, *ultim = NULL;

    cout << "Formati lista A: ";
    cin >> x;
    while (x != 0) {
        lista(prim, ultim, x);
        cin >> x;
    }
    cout << endl;

    cout << "Formati lista B: ";
    cin >> x;
    while (x != 0) {
        if (prim == NULL || x < prim->info) {
            add_inceput(prim, x);
        } else {
            if (x > ultim->info) add_final(ultim, prim, x);
            else {
                nod *p;
                p = prim;

                while (p != NULL) {
                    if (x > p->info && x < p->urm->info) add_interior(prim, ultim, p->info, x);
                    p = p->urm;
                }

            }
        }
        cin >> x;
    }

    afisare(prim);

    return 0;
}
