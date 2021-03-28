#include <iostream>

using namespace std;

struct nod {
    int info;
    nod *urm;
};

int verifica_val(nod *prim, int val) {
    nod *p = prim;

    while (p != NULL)
        if (p->info == val) return 1;
        else p = p->urm;

    return 0;
}

int verifica_poz(nod *prim, int poz) {
    nod *p = prim;
    int nr = 0;

    while (p != NULL) {
        nr++;
        p = p->urm;
    }

    if (poz > nr) return 0;
    else return 1;
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

void add_interior(nod *&prim, nod *ultim, int val, int x) {
    if (verificaval(prim, val) == 1) {
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
    }
    else cout << "Valoarea nu este in lista." << endl;

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

int cautare_valoare(nod *prim, int val) {
    if (verificaval(prim, val) == 1) {
        int i = 1;
        nod *c;
        c = prim;

        while (c != NULL && c->info != val) {
            c = c->urm;
            i++;
        }

        if (c->info == val) return i;
    } else return -1;

}

int cautare_pozitie(nod *prim, int poz) {
    if (verificapoz(prim, poz) == 1) {
        int val, i = 0;
        nod *r;
        r = prim;

        while (r != NULL && i < poz) {
            i++;
            val = r->info;
            r = r->urm;
        }

        if (i == poz) return val;
    } else return -1;
}

void sterge_pozitie(nod *prim, int poz) {
    if (verifica_poz(prim, poz) == 1) {
        if (poz == 1) {
            nod *aux;
            aux = prim;
            prim = prim->urm;
            delete aux;
        } else {
            int i = 1;
            nod *r, *q, *k;
            q = prim;
            r = prim->urm;

            while (r != NULL && i < poz) {
                i++;
                k = q;
                q = r;
                r = r->urm;
            }

            if (i == poz) {
                k->urm = r;
            }
        }
    } else cout << "Nu avem element pe acea pozitie." << endl;
}

void sterge_valoare(nod *prim, int val) {
    if (verificaval(prim, val) == 1) {
        if (prim->info == val) {
            nod *aux;
            aux = prim;
            prim = prim->urm;
            delete aux;
        } else {
            nod *r, *q, *k;
            q = prim;
            r = prim->urm;

            while (q != NULL && q->info != val) {
                k = q;
                q = r;
                r = r->urm;
            }

            if (q->info == val) k->urm = r;
        }
    } else cout << "nu exista valoarea." << endl;
}

void sterge_lista(nod *&prim) {
    prim = NULL;
}


int main() {
    int n, i, x, val;
    char t = '1';
    nod *prim = NULL, *ultim = NULL;

    cout << "n=";
    cin >> n;

    for (i = 1; i <= n; i++) {
        cout << "x=";
        cin >> x;
        add_final(prim, ultim, x);
    }

    cout << "Meniu functii" << endl;
    cout << "1.Adaugarea la final." << endl;
    cout << "2.Adaugarea la inceput." << endl;
    cout << "3.Adaugarea dupa o valoare data." << endl;
    cout << "4.Afisarea listei." << endl;
    cout << "5.Cautarea dupa o valoare." << endl;
    cout << "6.Cautarea dupa o pozitie." << endl;
    cout << "7.Stergerea dupa o valoare." << endl;
    cout << "8.Stergerea dupa o pozitie." << endl;
    cout << "9.Stergerea listei." << endl;

    while (t > '0' && t <= '9') {
        cout << "t=";
        cin >> t;
        switch (t) {
            case '1': {
                cout << "x=";
                cin >> x;
                add_inceput(prim, ultim, x);
                break;
            }
            case '2': {
                cout << "x=";
                cin >> x;
                add_final(prim, ultim, x);
                break;
            }
            case '3': {
                cout << "val=";
                cin >> val;
                cout << "x=";
                cin >> x;
                add_interior(prim, ultim, val, x);
                break;
            }
            case '4': {
                afisare_lista(prim);
                cout << endl;
                break;
            }
            case '5': {
                cout << "val=";
                cin >> val;
                cout << endl;
                cout << cautare_valoare(prim, val);
                cout << endl;
                break;
            }
            case '6': {
                cout << "x=";
                cin >> x;
                cout << endl;
                cout << cautare_pozitie(prim, x);
                cout << endl;
                break;
            }
            case '7': {
                cout << "x=";
                cin >> x;
                cout << endl;
                sterge_valoare(prim, x);
                break;
            }
            case '8': {
                cout << "x=";
                cin >> x;
                cout << endl;
                sterge_pozitie(prim, x);
                break;
            }
            case '9': {
                sterge_lista(prim);
                break;
            }


        }
    }

}
