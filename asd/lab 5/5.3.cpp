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
    int poz = 0, pozitie, ok = 1;
    char c;
    nod *stiva = NULL;

    cout << "Sirul w este: ";
    cin >> c;

    if (c == ')') ok = 0;
    else
        while (c == '(' || c == ')') {
            if (stiva != NULL) {
                if (c != stiva->info)
                    pop(stiva);
                else push(c, stiva);
            } else push(c, stiva);

            poz++;

            if (stiva == NULL)
                pozitie = poz;

            cin >> c;
        }

    if (ok == 1) {
        if (stiva == NULL)
            cout << "Sirul are parantezele puse corect." << endl;
        else if (stiva->info == '(') cout << "Sirul are paratezele puse corect." << endl;
        else
            cout << "Sirul nu are parantezele puse corect. Prima paranteza ')' care nu are pereche se afla pe pozitia "
                 << pozitie + 1 << endl;
    } else cout << "Sirul nu are parantezele puse corect, pentru ca prima paranteza citita este inchisa." << endl;

    return 0;
}
