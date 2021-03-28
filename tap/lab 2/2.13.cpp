//Varianta 2, Problema 3

#include <iostream>
#include <fstream>
#include <queue>
#include <vector>
#include <algorithm>

using namespace std;

vector <int> tata;

int find(int x){
    if(tata[x] == x) return x;
    return tata[x] = find(tata[x]);
}

int main() {
    int nrAct, maxT = 0, i, cost, deadline, costTotal = 0;
    priority_queue < pair < pair < int, int> , int > > myheap;

    ifstream f("date.in");
    f >> nrAct;

    for(i = 1; i <= nrAct; i++){
        f >> cost >> deadline;
        if(deadline >= maxT ) maxT = deadline;
        myheap.push(make_pair(make_pair(cost, deadline), i));
    }

    tata.resize(maxT + 1);
    for(i = 0; i <= nrAct; i++)
        tata[i] = i;

    cout << "Alegand urmatoarele activitati: ";

    for(i = 0; i < nrAct; i++){
        int p = find(myheap.top().first.second);
        if( p > 0){
            tata[p] = find(p-1);
            costTotal += myheap.top().first.first;
            cout << myheap.top().second << " ";
        }
        myheap.pop();
    }

    cout << "se obtine costul maxim de: " << costTotal <<". \n";

    return 0;
}