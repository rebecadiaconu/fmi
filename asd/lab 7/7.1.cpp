#include <iostream>

using namespace std;

struct nod {
    int info;
    nod *st, *dr;
};

nod *rad = NULL;

void adaug() {
    nod *p;
    p = new nod;
    p->dr = p->st = NULL;

    cout << "Dati un element: ";
    cin >> p->info;
    cout << endl;

    if (rad == NULL) rad = p;

    else {
        char c, v;
        nod *curr;
        curr = rad;

        while (curr) {
            cout << "Alegeti o varianta (d->dreapta/s->stanga): ";
            cin >> v;

            if (v == 's' && curr->st == NULL) {
                curr->st = p;
                break;
            } else if (v == 'd' && curr->dr == NULL) {
                curr->dr = p;
                break;
            } else {
                cout << "Alegeti o varianta (d->dreapta/s->stanga): ";
                cin >> c;
                if (c == 's') curr = curr->st;
                else if (c == 'd') curr = curr->dr;
            }
        }
    }
}

void rsd(nod *rad) {
    if (rad != NULL) {
        cout << rad->info << " ";
        rsd(rad->st);
        rsd(rad->dr);
    }
}

void srd(nod *rad) {
    if (rad != NULL) {
        srd(rad->st);
        cout << rad->info << " ";
        srd(rad->dr);
    }
}

void sdr(nod *rad) {
    if (rad != NULL) {
        sdr(rad->st);
        sdr(rad->dr);
        cout << rad->info << " ";
    }
}

int main() {
    int t;

    cout << "Meniu functii: " << endl;
    cout << "1. Adaugarea unui nod frunza." << endl;
    cout << "2. Parcurgerea RSD a arborelui." << endl;
    cout << "3. Parcurgerea SRD a arborelui." << endl;
    cout << "4. Parcurgerea SDR a arborelui." << endl;
    cout << "Alege un numar: ";
    cin >> t;

    while (t >= 1 && t <= 4) {
        switch (t) {
            case 1: {
                adaug();
            }
                break;
            case 2: {
                if (rad != NULL) {
                    cout << "Parcurgerea RSD este: " << endl;
                    rsd(rad);
                    cout << endl;
                } else cout << "Nu exista elemente in arbore" << endl;
            }
                break;
            case 3: {
                if (rad != NULL) {
                    cout << "Parcurgerea SRD este: " << endl;
                    srd(rad);
                    cout << endl;
                } else cout << "Nu exista elemente in arbore" << endl;
            }
                break;
            case 4: {
                if (rad != NULL) {
                    cout << "Parcurgerea SDR este: " << endl;
                    sdr(rad);
                    cout << endl;
                } else cout << "Nu exista elemente in arbore" << endl;
            }
                break;
        }
        cout << "Alege un numar: ";
        cin >> t;
        cout << endl;
    }

    return 0;
}

