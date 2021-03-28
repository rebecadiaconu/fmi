#include <iostream>

using namespace std;
struct nod {
    int cheie, priori;
    nod *urm;
};

void push(nod *&prim, nod *&ultim, int val, int prio) {
    nod *aux = new nod, *p, *c;
    aux->cheie = val;
    aux->priori = prio;
    aux->urm = NULL;

    if (prim == NULL) {
        prim = aux;
        ultim = prim;
    } else {
        if (prim->priori > prio) {
            aux->urm = prim;
            prim = aux;
        } else if (ultim->priori <= prio) {
            ultim->urm = aux;
            ultim = aux;
        } else {
            p = prim;

            while (p != NULL && p->priori <= prio) {
                c = p;
                p = p->urm;
            }

            if (c->priori <= prio && p->priori > prio) {
                c->urm = aux;
                aux->urm = p;
            }
        }
    }
}

void pop(nod *&prim) {
    nod *r = prim;
    if (prim == NULL) cout << "Coada este deja vida." << endl;
    else {
        prim = prim->urm;
        delete r;
    }

}

void afisare(nod *prim) {
    while (prim != NULL) {
        cout << prim->cheie << " de prioritatea " << prim->priori << "\n";
        prim = prim->urm;
    }
    cout << "\n";
}

int main() {
    int val, prio, t;
    nod *prim = NULL, *ultim = NULL;

    cout << "Meniu functii: " << endl;
    cout << "1. Adaugati un element in coada." << endl;
    cout << "2. Stergeti un element din coada." << endl;
    cout << "3. Afisare." << endl;
    cout << "Alegeti un numar: ";
    cin >> t;

    while (t >= 1 && t <= 3) {
        switch (t) {
            case 1: {
                cout << "Prioritatea si valoarea dorita(prioritatea diferita de 0):";
                cin >> prio;
                if (prio != 0) {
                    cin >> val;
                    push(prim, ultim, val, prio);
                } else cout << "Imposibil de adaugat." << endl;
            }
                break;
            case 2: {
                pop(prim);
            }
                break;
            case 3: {
                afisare(prim);
            }
                break;
        }
        cout << "Alegeti un numar: ";
        cin >> t;
    }

    return 0;
}
