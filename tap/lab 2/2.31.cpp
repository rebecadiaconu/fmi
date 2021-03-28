//Varianta 3, Problema 1

#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

int main() {
    int okp=0, oki=0, oke=0, si=0, sp=0, i, n, x;
    vector <int> vp, vi;
    ifstream f("date.in");

    f>>n;

    if(n%2 == 1) cout<<"Numarul de elemente de pe tabla este impar. Va rugam sa-l modificati. \n";
    else {
        for (i = 0; i < n; i++) {
            f >> x;
            if (i % 2 == 0) {
                sp += x;
                vp.push_back(x);
            } else {
                si += x;
                vi.push_back(x);
            }
        }
        vi.resize(n / 2);
        vp.resize(n / 2);

        if (si > sp) oki = 1;
        else if (sp > si) okp = 1;
        else oke = oki = 1;

        if (oki == 1 && oke == 0){
            cout << "Primul jucator a obtinut suma " << si << "( ";
            for (i = 0; i < n / 2; i++)
                cout << vi[i] << " ";
            cout << "), iar cel de-al doilea " << sp<<"( ";
            for(i=0; i<n/2; i++)
                cout << vp[i] << " ";
            cout << "). Deci primul jucator a castigat.\n";
        }
        if(okp == 1) {
            cout << "Primul jucator a obtinut suma " << sp << "( ";
            for (i = 0; i < n / 2; i++)
                cout << vp[i] << " ";
            cout << "), iar cel de-al doilea " << si <<"( ";
            for(i=0; i<n/2; i++)
                cout<<vi[i]<<" ";
            cout<<"). Deci primul jucator a castigat.\n";
        }
        if(oki == 1 && oke == 1) {
            cout << "Jucatorii au obtinut aceeasi suma: " << sp << ", deci primul jucator a castigat. \n";
            cout << "Primul jucator a ales urmatoarele: (";
            for (i = 0; i < n / 2; i++)
                cout << vi[i] << " ";
            cout << "), iar cel de-al doilea ( ";
            for(i=0; i<n/2; i++)
                cout << vp[i] << " ";
            cout << ").";
        }
    }

    return 0;
}