#include <iostream>
#include <math.h>

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
    }
    else {
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


void add_inceput(nod *&prim, nod *&ultim, int x) {
    if (prim == NULL) {
        prim = new nod;
        prim->info = x;
        prim->urm = NULL;
        ultim = prim;
    }
    else {
        nod *r;
        r = new nod;
        r->info = x;
        r->urm = prim;
        prim = r;
    }
}

int main() {
    int x, m, n, i, aux, d;
    nod *prim = NULL, *ultim = NULL, *first = NULL, *last = NULL, *pr = NULL, *ul = NULL;

    cout << "n=";
    cin >> n;
    cout << "m=";
    cin >> m;

    for (i = 1; i <= n; i++) {
        cout << "x=";
        cin >> x;
        add_inceput(prim, ultim, x);
    }
    afisare_lista(prim);
    cout << endl;

    for (i = 1; i <= m; i++) {
        cout << "x=";
        cin >> x;
        add_inceput(first, last, x);
    }
    afisare_lista(first);
    cout << endl;

    nod *r, *q;
    r = prim;
    q = first;
    aux = 0;

    while (r != NULL && q != NULL) {
        d = r->info + q->info + aux;
        aux = d / 10;
        if (aux != 0) add_inceput(pr, ul, d % 10);
        else add_inceput(pr, ul, d);
        r = r->urm;
        q = q->urm;
    }

    if (r != NULL)
        while (r != NULL) {
            d = r->info + aux;
            aux = d / 10;
            if (aux != 0) add_inceput(pr, ul, d % 10);
            else add_inceput(pr, ul, d);
            r = r->urm;
        }

    if (q != NULL)
        while (q != NULL) {
            d = q->info + aux;
            aux = d / 10;
            if (aux != 0) add_final(pr, ul, d % 10);
            else add_final(pr, ul, d);
            q = q->urm;
        }

    if (r == NULL && q == NULL && aux != 0) add_inceput(pr, ul, aux);

    afisare_lista(pr);

    return 0;
}
