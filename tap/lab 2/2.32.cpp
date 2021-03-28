//Varianta 3, Problema 2

#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

#define dim 100002

vector <int> tata, viz, g[dim], afis;
int nr;

void DFS(int x){
    viz[x] =  1;
    for(int i = 0; i < g[x].size(); i++)
        if(viz[g[x][i]] == 0) DFS(g[x][i]);

    if(afis[x] == 0){
        cout << x << " ";
        nr++;
        afis[tata[x]] = 1;
    }
}


int main(){
    int n, m, x, y, i;

    ifstream f("date.in");
    f >> n >> m;

    tata.resize(n+1);
    viz.resize(n+1);
    afis.resize(n+1);

    for(i = 1; i <= m; i++){
        f >> x >> y;
        tata[y] = x;

        g[x].push_back(y);
        g[y].push_back(x);
    }



    cout<<"Multimea nodurilor neadiacente este: ";
    DFS(1);
    cout<<" si cardinalul acesteia este "<<nr<<endl;

    return 0;
}