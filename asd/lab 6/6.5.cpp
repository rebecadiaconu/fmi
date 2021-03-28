#include <iostream>

using namespace std;

struct nod {
    int info;
    nod *next, *prev;
};

void ins(nod *&start, int x) {
    nod *p = new nod, *q;
    p->info = x;
    p->next = NULL;
    p->prev = NULL;

    if (start->next == NULL) {
        start->next = p;
        p->prev = start;
    } else {
        q = start->next;
        p->prev = start;
        start->next = p;
        p->next = q;
        q->prev = p;
    }
}


void del(nod *&start) {
    nod *p;
    p = start->prev;
    if (p->next == p) {
        start->next = NULL;
        start->prev = NULL;
        delete p;
        return;
    }

    p->prev->next = p->next;
    p->next->prev = p->prev;
    start->prev = p->prev;
    delete p;

    return;
}

void afisare(nod *start) {
    nod *p = start;
    cout << "Lista: ";

    while (p != start->prev) {
        p = p->next;
        cout << p->info << " ";
    }
    cout << endl;

    return;
}

int main() {
    int x, t, c;
    nod *p, *q, *start = new nod;

    start->info = 0;
    cout << "Lista initiala (pana la 0): ";
    cin >> x;
    p = new nod;
    start->next = p;
    p->info = x;

    while (x) {
        cin >> x;
        if (!x)
            break;
        q = new nod;
        q->info = x;
        q->prev = p;
        p->next = q;
        p = q;
    }

    p->next = start->next;
    start->next->prev = p;
    start->prev = p;

    cout << "Meniu functii: " << endl;
    cout << "1. Inserare\n2. Stergere\n3. Afisare\n";
    cout << "Alege un numar :";
    cin >> t;

    while (t >= 1 && t <= 3) {
        switch (t) {
            case 1: {
                cout << "valoarea este = ";
                cin >> x;
                ins(start, x);
            }
                break;
            case 2: {
                del(start);
            }
                break;
            case 3:
                afisare(start);
                break;
        }
        cout << endl;
        cout << "Alege un numar :";
        cin >> t;
    }

    return 0;
}
