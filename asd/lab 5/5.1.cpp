#include <iostream>

using namespace std;

struct stiva {
    int info;
    stiva *urm;
};

void push(int a, stiva *&varf) {
    stiva *aux = new stiva;
    aux->info = a;
    aux->urm = varf;
    varf = aux;
}

int pop(stiva *&varf) {
    stiva *aux = new stiva;
    int val;

    aux = varf->urm;
    val = varf->info;
    delete varf;
    varf = aux;

    return val;
}

int peek(stiva *varf) {
    return varf->info;
}

bool empty(stiva *varf) {
    if (varf == NULL)
        return 0;
    else return 1;
}

int search(int a, stiva *varf) {
    int dist = 0;
    while (varf != NULL) {
        if (varf->info == a)
            return dist;
        else dist++;
        varf = varf->urm;
    }

    return -1;
}

void afisare(stiva *varf) {
    while (varf != NULL) {
        cout << varf->info << " ";
        varf = varf->urm;
    }

    cout << endl;
    cout << endl;
}

int main() {
    int a;
    char t;
    stiva *varf = NULL;

    cout << "Meniu functii: " << endl;
    cout << "1. Adaugarea unui element in varful stivei." << endl;
    cout << "2. Scoaterea elementului din varful stivei si returnarea ca rezultat al unei functii." << endl;
    cout << "3. Intoarce elementul din varful stivei fara a-l scoate din stiva." << endl;
    cout << "4. Verificare daca stiva e vida sau nu." << endl;
    cout << "5. Verificare daca un element se regaseste in stiva si returneaza distanta fata de varf." << endl;
    cout << "6. Afisarea stivei." << endl;
    cout << "Alege un numar: ";
    cin >> t;

    while (t > '0' && t <= '9') {
        switch (t) {
            case '1': {
                cout << "a=";
                cin >> a;
                push(a, varf);
            }
                break;
            case '2': {
                if (varf != NULL)
                    cout << pop(varf) << endl;
                else cout << "Stiva este goala." << endl;
            }
                break;
            case '3': {
                if (varf != NULL)
                    cout << peek(varf) << endl;
                else cout << "Stiva este goala." << endl;
            }
                break;
            case '4': {
                if (bool(varf) == 1)
                    cout << "Avem elemente in stiva." << endl;
                else cout << "Stiva este vida." << endl;
            }
                break;
            case '5': {
                cout << "Elementul pe care-l cauti: ";
                cin >> a;
                int poz = search(a, varf);
                if (poz == -1)
                    cout << "Elementul nu este in stiva." << endl;
                else
                    cout << "Elementul cautat se afla in stiva la distanta " << poz << " de varf." << endl;
            }
                break;
            case '6': {
                cout << "Stiva este: ";
                afisare(varf);
            }
                break;
        }

        cout << endl;
        cout << "Alege un numar: ";
        cin >> t;
    }

    return 0;
}
