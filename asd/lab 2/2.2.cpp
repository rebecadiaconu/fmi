#include <iostream>

using namespace std;

struct nod {
    int info;
    nod *urm;
};

void add_inceput(nod *&prim, nod *&ultim, int x) {
    if (prim == NULL) {
        prim = new nod;
        prim->info = x;
        prim->urm = NULL;
        ultim = prim;
    } else {
        nod *r;
        r = new nod;
        r->info = x;
        r->urm = prim;
        prim = r;
    }
}


int main() {
    int n, i, nrp = 0, nri = 0, x;
    float ma, si = 0;
    nod *prim = NULL, *ultim = NULL;

    cout << "n=";
    cin >> n;

    for (i = 1; i <= n; i++) {
        cout << "x=";
        cin >> x;
        add_inceput(prim, ultim, x);
    }

    nod *r;
    r = prim;
    while (r != NULL)
        if (r->info % 2 == 0) {
            nrp++;
            r = r->urm;
        } else {
            si = si + r->info;
            nri++;
            r = r->urm;
        }

    cout << "nrp=" << nrp << endl;
    if (nri != 0) {
        ma = si / nri;
        cout << "ma=" << ma << endl;
    } else cout << "Nu exista nr impare.";

    return 0;
}
