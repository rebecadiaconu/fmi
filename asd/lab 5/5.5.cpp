#include <iostream>

using namespace std;

struct nod {
    int info;
    nod *urm;
};

nod *prim, *ultim;

void push(int a, nod *&coada) {
    nod *aux = new nod;
    aux->info = a;
    aux->urm = NULL;

    if (coada == NULL)
        coada = ultim = aux;
    else {
        ultim->urm = aux;
        ultim = aux;
    }
}

int pop(nod *&coada) {
    nod *aux = new nod;
    int val;

    aux = coada->urm;
    val = coada->info;
    delete coada;
    coada = aux;

    return val;
}

int peek(nod *coada) {
    return coada->info;
}

bool empty(nod *coada) {
    if (coada == NULL) return 0;
    else return 1;
}

int search(int a, nod *coada) {
    int dist = 0;
    while (coada != NULL) {
        if (coada->info == a) return dist;
        else dist++;
        coada = coada->urm;
    }

    return -1;
}

void afisare(nod *coada) {
    nod *r = coada;

    while (r != NULL) {
        cout << r->info << " ";
        r = r->urm;
    }
    cout << endl;
    cout << endl;
}

int main() {
    int a;
    char t;
    nod *prim = NULL, *ultim = NULL;

    cout << "Meniu functii: " << endl;
    cout << "1. Adaugarea unui element in coada." << endl;
    cout << "2. Scoaterea primului element din coada si returnarea ca rezultat al unei functii." << endl;
    cout << "3. Intoarce primul element din coada fara a-l scoate din stiva." << endl;
    cout << "4. Verificare daca coada e vida sau nu." << endl;
    cout << "5. Verificare daca un element se regaseste in coada si returneaza distanta fata de primul element."
         << endl;
    cout << "6. Afisarea cozii." << endl;
    cout << "Alege un numar: ";
    cin >> t;

    while (t > '0' && t <= '9') {
        switch (t) {
            case '1': {
                cout << "a=";
                cin >> a;
                push(a, prim);
            }
                break;
            case '2': {
                if (prim != NULL)
                    cout << pop(prim) << endl;
                else cout << "Coada este goala." << endl;
            }
                break;
            case '3': {
                if (prim != NULL)
                    cout << peek(prim) << endl;
                else cout << "Coada este goala." << endl;
            }
                break;
            case '4': {
                if (bool(prim) == 1)
                    cout << "Avem elemente in coada." << endl;
                else cout << "Coada este vida." << endl;
            }
                break;
            case '5': {
                cout << "Elementul pe care-l cauti: ";
                cin >> a;
                int poz = search(a, prim);
                if (poz == -1)
                    cout << "Elementul nu este in coada." << endl;
                else
                    cout << "Elementul cautat se afla in coada la distanta " << poz << " de primul element." << endl;
            }
                break;
            case '6': {
                cout << "Coada este: ";
                afisare(prim);
            }
                break;
        }

        cout << endl;
        cout << "Alege un numar: ";
        cin >> t;
    }

    return 0;
}
