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

void afisare(nod *rad) {
    sdr(rad->st);
    rad->st = NULL;
    srd(rad);
}


int main() {
    int n, i, x;
    nod *rad = NULL;
    cout << "Numarul de elemente este: ";
    cin >> n;

    for (i = 1; i <= n; i++) {
        cout << "Elementul este: ";
        cin >> x;
        inserare(rad, x);
    }

    afisare(rad);

    return 0;
}
