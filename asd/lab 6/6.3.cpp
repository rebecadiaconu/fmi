#include <iostream>

using namespace std;

struct nod {
    int val;
    nod *next, *prev;
};

void addBeg(int x, nod *&pr) {
    nod *p = new nod;
    p->val = x;
    p->next = pr;
    p->prev = NULL;

    if (pr != NULL)
        pr->prev = p;
    pr = p;

    return;
}

void addEnd(int x, nod *&ul) {
    nod *p = new nod;
    p->val = x;
    p->next = NULL;
    p->prev = ul;

    if (ul != NULL)
        ul->next = p;
    ul = p;

    return;
}

void delBeg(nod *&pr) {
    if (pr == NULL) {
        cout << "Lista este deja vida.";
        return;
    }

    nod *p = pr;
    pr = pr->next;

    if (pr != NULL)
        pr->prev = NULL;
    delete p;

    return;
}

void delEnd(nod *&ul) {
    if (ul == NULL) {
        cout << "Lista este deja vida.";
        return;
    }

    nod *p = ul;
    ul = ul->prev;
    if (ul != NULL)
        ul->next = NULL;
    delete p;

    return;
}

void afisare(nod *pr) {
    if (pr == NULL)
        return;

    nod *p = pr;
    while (p != NULL) {
        cout << p->val << " ";
        p = p->next;
    }

    return;
}

int main() {
    nod *prim, *ult, *p, *q;
    int t, x, pz;

    cout << "Introduceti lista: ";
    prim = new nod;
    cin >> x;
    prim->val = x;
    prim->prev = NULL;
    p = prim;

    while (true) {
        cin >> x;
        if (!x)
            break;
        q = new nod;
        p->next = q;
        q->prev = p;
        q->val = x;
        p = q;
    }

    p->next = NULL;
    ult = p;

    cout << "Meniu functii: " << endl;
    cout << "\n1. Adaugarea unui element la inceputul listei" << endl;
    cout << "2. Adaugarea unui element la sfarsitul listei" << endl;
    cout << "3. Stergerea unui element de la inceputul listei" << endl;
    cout << "4. Stergerea unui element de la sfarsitul listei" << endl;
    cout << "5. Afisarea listei" << endl;
    cout << "0. Iesire" << endl;
    cout << "Alegeti un numar: ";
    cin >> t;

    while (t >= 1 && t <= 5) {
        switch (t) {
            case 1: {
                cout << " elementul este = ";
                cin >> x;
                addBeg(x, prim);
            }
                break;
            case 2: {
                cout << " elementul este = ";
                cin >> x;
                addEnd(x, ult);
            }
                break;
            case 3:
                delBeg(prim);
                break;
            case 4:
                delEnd(ult);
                break;
            case 5: {
                afisare(prim);
            }
                break;
                cout << endl;
        }
        cout << endl;
        cout << "Alegeti un numar: ";
        cin >> t;
        cout << endl;
    }

    return 0;
}
