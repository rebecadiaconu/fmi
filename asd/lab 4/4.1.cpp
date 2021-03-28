#include <iostream>

using namespace std;

struct nod {
    int info;
    nod *urm;
};

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

void varianta2(nod *&prim, nod *&ultim) {
    nod *curent, *prev, *next;
    curent = prim;
    prev = NULL;
    next = NULL;

    while (curent != NULL) {
        next = curent->urm;
        curent->urm = prev;
        prev = curent;
        curent = next;
    }

    prim = prev;
    afisare_lista(prim);
    cout << endl;
}

void varianta1(nod *prim, nod *&p, nod *&u) {
    int x;
    nod *r;
    r = prim;

    while (r != NULL) {
        x = r->info;
        add_inceput(p, u, x);
        r = r->urm;
    }

    afisare_lista(p);
    cout << endl;
}

int main() {
    int n, i, x;
    char t = '1';
    nod *prim = NULL, *ultim = NULL, *p = NULL, *u = NULL;

    cout << "Nr. elemente lista= ";
    cin >> n;

    for (i = 1; i <= n; i++) {
        cout << "x=";
        cin >> x;
        add_final(prim, ultim, x);
    }

    cout << endl;
    cout << "Meniu functii: " << endl;
    cout << "1. Se aloca memorie suplimentara. " << endl;
    cout << "2. Se face inversarea nodurilor direcr. " << endl;

    while (t > '0' && t <= '2') {
        cout << "caz= ";
        cin >> t;
        switch (t) {
            case '1': {
                varianta1(prim, p, u);
                break;
            }
            case '2': {
                varianta2(prim, ultim);
                break;
            }
        }
    }

    return 0;
}
