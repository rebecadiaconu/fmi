#include <iostream>
#include <string.h>

using namespace std;

struct nod {
    char cuv[25];
    nod *st, *dr;
};

void DRS(nod *p) {
    if (p->dr != NULL)
        DRS(p->dr);

    cout << p->cuv << " ";

    if (p->st != NULL)
        DRS(p->st);
}

nod *findMinNod(nod *p) {
    if (p->st == NULL)
        return p;

    return findMinNod(p->st);
}

nod *rootInit(char x[]) {
    nod *p = new nod;

    p->st = NULL;
    p->dr = NULL;
    strcpy(p->cuv, x);

    return p;
}

nod *insert(nod *&p, char x[]) {
    if (p == NULL)
        return rootInit(x);

    if (strcmp(x, p->cuv) < 0)
        p->st = insert(p->st, x);

    else if (strcmp(x, p->cuv) > 0)
        p->dr = insert(p->dr, x);

    return p; ///egale
}

nod *deletee(nod *&p, char x[]) {
    if (p == NULL)
        return p;

    if (strcmp(x, p->cuv) < 0)
        p->st = deletee(p->st, x);
    else if (strcmp(x, p->cuv) > 0)
        p->dr = deletee(p->dr, x);
    else {
        if (p->st == NULL || p->dr == NULL) {
            nod *temp = p->st != NULL ? p->st : p->dr;

            if (temp == NULL) {
                temp = p;
                p = NULL;
            } else
                *p = *temp;

            delete temp;
        } else {
            nod *temp = findMinNod(p->dr);
            strcpy(p->cuv, temp->cuv);
            p->dr = deletee(p->dr, temp->cuv);
        }
    }

    return p;
}

int main() {
    char x[35];
    nod *root = NULL;

    cout << "Sir de cuvinte (pana la 0): ";

    while (true) {
        cin >> x;
        if (!strcmp(x, "0")) break;
        root = insert(root, x);
    }

    cout << "\nSir de cuvinte ordonat descrescator: ";
    DRS(root);
    cout << "\n";

    return 0;
}
