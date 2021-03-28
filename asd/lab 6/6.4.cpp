#include <iostream>

using namespace std;

struct nod {
    int val;
    nod *next, *prev;
};

void insPoz(int x, int ch, nod *&start) {
    int n;
    nod *p, *q, *r;
    p = start->prev;
    q = p->next;
    n = 1;

    while (n < ch) {
        p = q;
        q = q->next;
        n++;
    }

    r = new nod;
    r->val = x;
    r->prev = p;
    r->next = q;
    p->next = r;
    q->prev = r;

    if (r->prev == start->prev)
        start->next = r;
    else if (r->next == start->next)
        start->prev = r;

    return;
}

void del(int xval, nod *&start) {
    nod *p, *q, *r;
    p = start->next;

    if (p->next == p && p->val == xval) {
        start->next = NULL;
        start->prev = NULL;
        delete p;
    }

    do {
        if (p->val == xval) {
            q = p->prev;
            r = p->next;
            q->next = r;
            r->prev = q;
            if (p == start->next)
                start->next = r;
            else if (p == start->prev)
                start->prev = q;
            delete p;

            return;
        }
        p = p->next;
    } while (p != start->next);
    cout << "\nValoare inexistenta.\n";

    return;
}

void afisare(nod *start) {
    if (start->next == NULL) {
        cout << "Lista este vida.\n";
        return;
    }

    nod *p = start->next;
    cout << "Lista: ";

    do {
        cout << p->val << " ";
        p = p->next;
    } while (p != start->next);
    cout << endl;

    return;
}

int main() {
    int x, t, c;
    nod *p, *q, *start = new nod;

    start->val = 0;
    cout << "Introduceti lista: ";
    cin >> x;
    p = new nod;
    start->next = p;
    p->val = x;

    while (x) {
        cin >> x;
        if (!x)
            break;

        q = new nod;
        q->val = x;
        q->prev = p;
        p->next = q;
        p = q;
    }
    p->next = start->next;
    start->next->prev = p;
    start->prev = p;

    cout << "Meniu functii: " << endl;
    cout << "1. Inserare\n2. Stergere\n3. Afisare\n";
    cout << "ALegeti un numar: ";
    cin >> t;

    while (t >= 1 && t <= 3) {
        switch (t) {
            case 1: {
                cout << "a= ";
                cin >> x;
                cout << "poz= ";
                cin >> c;
                insPoz(x, c, start);
            }
                break;
            case 2: {
                cout << "stergem: ";
                cin >> c;
                del(c, start);
            }
                break;
            case 3:
                afisare(start);
                break;
        }
        cout << endl;
        cout << "ALegeti un numar: ";
        cin >> t;
        cout << endl;
    }

    return 0;
}
