#include <iostream>

using namespace std;

struct nod {
    int info;
    nod *prev;
    nod *urm;
};

void add_inceput(nod *&prim, nod *&ultim, int x) {
    nod *p = new nod;
    p->info = x;
    p->prev = NULL;
    p->urm = prim;

    if (prim != NULL)
        prim->prev = p;
    else ultim = p;

    prim = p;
}

void add_final(nod *&ultim, nod *&prim, int x) {
    if (prim == NULL) {
        prim = new nod;
        prim->info = x;
        prim->urm = NULL;
        prim->prev = NULL;
        ultim = prim;
    } else {
        nod *r;
        r = new nod;
        r->info = x;
        r->urm = NULL;
        r->prev = ultim;
        ultim->urm = r;
        ultim = r;
    }

}

int verifica_val(nod *prim, int val) {
    nod *r = prim;
    while (r != NULL) {
        if (r->info == val) return 1;
        r = r->urm;
    }
    return 0;

}

void add_interior(nod *prim, nod *ultim, int val, int x) {
    if (verifica_val(prim, val) == 1) {
        nod *p = new nod;
        p->info = x;
        p->urm = NULL;
        p->prev = NULL;
        nod *r = prim;

        while (r != NULL && r->info != val) r = r->urm;

        p->urm = r->urm;
        r->urm->prev = p;
        r->urm = p;
        p->prev = r;
    } else cout << "Valoarea data nu se gaseste in lista." << endl;
}

void afisare(nod *prim) {
    nod *p = prim;
    while (p != NULL) {
        cout << p->info << " ";
        p = p->urm;
    }

    cout << endl;
}

void afisare_inversa(nod *ultim) {
    nod *p = ultim;
    while (p != NULL) {
        cout << p->info << " ";
        p = p->prev;
    }
}

int verifica_poz(nod *prim, int poz) {
    int pz = 0;
    nod *p = prim;
    while (p != NULL) {
        pz++;
        if (pz == poz) return 1;
        p = p->urm;
    }

    return 0;
}

void sterge_pozitie(nod *&prim, nod *&ultim, int poz) {
    if (verifica_poz(prim, poz) == 1) {
        int p = 0;
        nod *r = prim;
        p++;

        while (r != NULL && p < poz) {
            p++;
            r = r->urm;
        }

        r->prev->urm = r->urm;
        r->urm->prev = r->prev;
        delete r;

    } else cout << "Nu exista niciun element pe pozitia data." << endl;
}


void sterge_val(nod *&prim, nod *&ultim, int val) {
    if (verifica_val(prim, val) == 1) {
        if (prim->info == val) {
            nod *c = prim;
            prim = prim->urm;
            prim->prev = NULL;
            delete c;
        } else {
            nod *r = prim;

            while (r != NULL && r->info != val) r = r->urm;

            nod *c, *q;
            c = r->prev;
            q = r->urm;
            c->urm = q;
            q->prev = c;
            delete r;
        }
    } else cout << "Nu exista valoarea data in lista." << endl;
}

void meniu() {
    cout << "Meniu functii: " << endl;
    cout << "1. Adaugarea unui element la inceput." << endl;
    cout << "2. Adaugarea unui element la final." << endl;
    cout << "3. Adaugarea unui element in interiorul listei (dupa o valorea data )." << endl;
    cout << "4. Afisarea listei." << endl;
    cout << "5. Afisarea inversa listei." << endl;
    cout << "6. Stergerea unui nod dupa valoare." << endl;
    cout << "7. Stergerea unui nod dupa un indice dat." << endl;
    cout << "Pentru orice alta valoare se va iesi din program." << endl;
}


int main() {
    int val, poz, x;
    nod *prim = NULL, *ultim = NULL;
    char t;

    meniu();
    cout << "Alege un numar ";
    cin >> t;

    while (t > '0' && t <= '7') {
        switch (t) {
            case '1': {
                cout << "x=";
                cin >> x;
                add_inceput(prim, ultim, x);

            }
                break;
            case '2': {
                cout << "x=";
                cin >> x;
                add_final(ultim, prim, x);
            }
                break;

            case '3': {
                cout << "x=";
                cin >> x;
                cout << "Valoarea este ";
                cin >> val;
                add_interior(prim, ultim, val, x);
            }
                break;
            case '4': {
                afisare(prim);
            }
                break;
            case '5': {
                afisare_inversa(ultim);
                cout << endl;
            }
                break;
            case '6': {
                cout << "valoarea este ";
                cin >> val;
                sterge_val(prim, ultim, val);
            }
                break;
            case '7': {
                cout << "Indicele este ";
                cin >> poz;
                sterge_pozitie(prim, ultim, poz);
            }
                break;
        }
        cout << "Alege un numar ";
        cin >> t;
    }

    return 0;
}
