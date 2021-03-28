#include <iostream>

using namespace std;

struct nod {
    char info;
    nod *urm;
};

void push(int a, nod *&stiva) {
    nod *aux = new nod;
    aux->info = a;
    aux->urm = stiva;
    stiva = aux;
}

void pop(nod *&stiva) {
    nod *aux = new nod;
    aux = stiva->urm;
    delete stiva;
    stiva = aux;
}


int main() {
    char c;
    nod *stiva = NULL;

    cout << "Sirul w este: ";
    cin >> c;

    while (c == 'a' || c == 'b') {
        if (stiva != NULL)
            if (c != stiva->info)
                pop(stiva);
            else push(c, stiva);
        else push(c, stiva);
        cin >> c;
    }

    if (stiva == NULL)
        cout << "Numarul de caractere 'a' este egal cu numarul de caractere 'b' ." << endl;
    else cout << "Numarul de caractere 'a' nu este egal cu numarul de caractere 'b' ." << endl;

    return 0;
}
