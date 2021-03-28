#include <iostream>

using namespace std;

struct nod {
    int val, bf;
    nod *st, *dr;
};

int max(int a, int b) {
    return (a > b) ? a : b;
}

void SRD(nod *p) {
    if (p->st != NULL)
        SRD(p->st);

    cout << p->val << " ";

    if (p->dr != NULL)
        SRD(p->dr);
}

void RSD(nod *p) {
    cout << p->val << " ";

    if (p->st != NULL)
        RSD(p->st);

    if (p->dr != NULL)
        RSD(p->dr);
}


int search(nod *p, int x) {
    if (p == NULL)
        return 0;

    if (p->val == x)
        return 1;

    if (search(p->st, x) || search(p->dr, x))
        return 1;

    return 0;
}


int height(nod *p) {
    if (p == NULL)
        return 0;

    return max(height(p->st), height(p->dr)) + 1;
}

int balance(nod *p) {
    if (p == NULL)
        return 0;

    return height(p->st) - height(p->dr);
}

int findMaxVal(nod *p) {
    if (p->dr == NULL)
        return p->val;

    return findMaxVal(p->dr);
}

nod *findMinNod(nod *p) {
    if (p->st == NULL)
        return p;

    return findMinNod(p->st);
}

nod *rootInit(int x) {
    nod *p = new nod;
    p->st = NULL;
    p->dr = NULL;
    p->val = x;
    p->bf = 0;

    return p;
}

nod *rightRotate(nod *y) {
    nod *x = y->st;
    nod *T2 = x->dr;

    x->dr = y;
    y->st = T2;

    y->bf = balance(y);
    x->bf = balance(x);

    return x;
}

nod *leftRotate(nod *x) {
    nod *y = x->dr;
    nod *T2 = y->st;

    y->st = x;
    x->dr = T2;

    x->bf = balance(x);
    y->bf = balance(y);

    return y;
}

nod *insertAVL(nod *&p, int x) {
    if (p == NULL)
        return rootInit(x);

    if (x < p->val)
        p->st = insertAVL(p->st, x);
    else if (x > p->val)
        p->dr = insertAVL(p->dr, x);
    else
        return p; ///egale

    ///balans
    p->bf = balance(p);

    // Left Left Case / rotatie right
    if (p->bf > 1 && x < p->st->val)
        return rightRotate(p);

    // Right Right Case / rotatie left
    if (p->bf < -1 && x > p->dr->val)
        return leftRotate(p);

    // Left Right Case / rotatie left right
    if (p->bf > 1 && x > p->st->val) {
        p->st = leftRotate(p->st);
        return rightRotate(p);
    }

    // Right Left Case / rotatie right left
    if (p->bf < -1 && x < p->dr->val) {
        p->dr = rightRotate(p->dr);
        return leftRotate(p);
    }

    return p;
}

nod *deleteAVL(nod *&p, int x) {
    if (p == NULL)
        return p;

    if (x < p->val)
        p->st = deleteAVL(p->st, x);
    else if (x > p->val)
        p->dr = deleteAVL(p->dr, x);
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
            p->val = temp->val;
            p->dr = deleteAVL(p->dr, temp->val);
        }
    }

    if (p == NULL)
        return p;

    ///balans
    p->bf = balance(p);

    if (p->bf > 1 && p->st->bf >= 0) //LLC
        return rightRotate(p);

    if (p->bf > 1 && p->st->bf < 0) //LRC
    {
        p->st = leftRotate(p->st);
        return rightRotate(p);
    }

    if (p->bf < -1 && p->dr->bf <= 0) //RRC
        return leftRotate(p);

    if (p->bf < -1 && p->dr->bf > 0) //RLC
    {
        p->dr = rightRotate(p->dr);
        return leftRotate(p);
    }

    return p;
}


int main() {
    int t, x;
    nod *root = NULL;

    cout << "1. Inserare\n";
    cout << "2. Cautare\n";
    cout << "3. Maxim\n";
    cout << "4. Stergere\n";
    cout << "5. Afisare SRD\n";
    cout << "6. RSD.\n";
    cout << "t= ";
    cin >> t;

    while (t >= 1 && t <= 6) {
        switch (t) {
            case 1: {
                cout << "x = ";
                cin >> x;
                if (search(root, x))
                    cout << x << " se afla deja in arbore.";
                else {
                    root = insertAVL(root, x);
                    cout << x << " a fost inserat.";
                }
            }
                break;
            case 2: {
                cout << "x = ";
                cin >> x;
                if (search(root, x))
                    cout << "Elementul " << x << " se afla in arbore.";
                else
                    cout << "Elementul " << x << " nu a fost gasit.";
            }
                break;
            case 3: {
                if (root != NULL)
                    cout << "Elementul maxim din arbore este " << findMaxVal(root);
                else
                    cout << "Arborele este vid.";
            }
                break;
            case 4: {
                cout << "x = ";
                cin >> x;
                if (search(root, x)) {
                    root = deleteAVL(root, x);
                    cout << x << " a fost sters.";
                } else
                    cout << x << " nu a fost gasit in arbore.";
            }
                break;
            case 5: {
                if (root == NULL)
                    cout << "Arborele este vid.";
                else
                    SRD(root);
            }
                break;
            case 6: {
                if (root == NULL)
                    cout << "Arborele este vid.";
                else
                    RSD(root);
            }
                break;
            case 0:
                break;
            default:
                cout << "Optiune invalida.\n";
                break;
        }

        cout << "\n";
        cout << "t= ";
        cin >> t;
    }

    return 0;
}
