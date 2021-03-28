#include <iostream>

using namespace std;

struct nod {
    nod *st, *dr;
    int info, LeftSize;
};

nod *root;

void creare() {
    nod *p = root;
    nod *q = new nod;

    q->dr = NULL;
    q->st = NULL;
    q->LeftSize = 0;
    cin >> q->info;

    while (1) {
        if (p->info > q->info) {
            if (p->st == NULL) {

                p->st = q;
                p->LeftSize++;
                break;
            } else {
                p->LeftSize++;
                p = p->st;
            }
        } else if (p->info < q->info) {
            if (p->dr == NULL) {
                p->dr = q;
                break;
            } else p = p->dr;
        } else {
            cout << "Aceasta valoare exista deja in arbore.";
            break;
        }
    }
}


void cautare(nod *root, int k) {
    nod *x = root;

    if (k == x->LeftSize)
        cout << x->info;
    else if (k < x->LeftSize)
        cautare(x->st, k);
    else if (k > x->LeftSize)
        cautare(x->dr, k - x->LeftSize - 1);
}

void srd(nod *root) {
    if (root) {
        srd(root->st);
        cout << root->LeftSize << " ";
        srd(root->dr);
    }
}

int main() {

    root = new nod;
    root->dr = NULL;
    root->st = NULL;
    root->info = NULL;
    root->LeftSize = NULL;

    cout << "Introduceti o valoare pentru radacina : ";
    cin >> root->info;
    int k;

    cout << "0 : Inchidere program." << endl;
    cout << "1 : Adaugare nod in arbore." << endl;
    cout << "2 : Cautare valoare dupa o pozitie data." << endl;
    cout << "3 : Afisare in inordine a campului LeftSize." << endl;

    int ok = 0, x;
    while (ok == 0) {
        cin >> x;
        switch (x) {
            case 0 :
                ok = 1;
                break;
            case 1 :
                cout << "Introduceti o valoare : ";
                creare();
                break;
            case 2 :
                cout << "Introduceti pozitia cautata : ";
                cin >> k;
                cautare(root, k);
                break;
            case 3 :
                srd(root);
                break;
        }
    }

    return 0;
}
