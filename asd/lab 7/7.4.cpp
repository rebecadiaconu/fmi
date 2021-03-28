#include <iostream>

using namespace std;

struct nod {
    int info;
    nod *st, *dr;
};

void inserare(nod *&rad, int x) {
    nod *p = new nod;
    p->info = x;
    p->st = p->dr = NULL;

    if (rad == NULL)
        rad = p;
    else {
        nod *curr = rad;

        while (curr) {
            if (p->info < curr->info)
                if (curr->st == NULL) {
                    curr->st = p;
                    break;
                } else curr = curr->st;
            else if (p->info > curr->info) {
                if (curr->dr == NULL) {
                    curr->dr = p;
                    break;
                } else curr = curr->dr;
            }
        }
    }
}

void creare(nod *&rad, int &vmax, int &vmin) {
    int x;
    cout << "Alegeti un numar: ";
    cin >> x;

    while (x != 0) {
        if (x > vmax)vmax = x;
        if (x < vmin)vmin = x;
        inserare(rad, x);
        cout << "Alegeti un numar: ";

        cin >> x;
    }
}


int verificare(int vmax, int vmin, int k1, int k2) {
    if (k1 > k2) swap(k1, k2);
    if (vmin <= k1 && vmax >= k2) return 1;
    if (vmin >= k1 && vmax >= k2 && vmin <= k2) return 1;
    if (vmin <= k1 && vmax >= k1 && vmax <= k2) return 1;
    if (k1 <= vmin && k2 >= vmax) return 1;
    return 0;
}

void sdr(nod *rad, int k1, int k2) {
    if (k1 > k2) swap(k1, k2);
    if (rad != NULL) {
        sdr(rad->st, k1, k2);
        sdr(rad->dr, k1, k2);

        if (rad->info >= k1 && rad->info <= k2)
            cout << rad->info << " ";
    }
}


int main() {
    int k1, k2, x, vmax = -32000, vmin = 32000;
    nod *rad = NULL;

    creare(rad, vmax, vmin);

    cout << "k1=";
    cin >> k1;
    cout << "k2=";
    cin >> k2;

    if (verificare(vmax, vmin, k1, k2) == 1)
        sdr(rad, k1, k2);
    else cout << "Nu exista elemente in arbore care sa indeplineasca conditia impusa." << endl;

    return 0;
}
