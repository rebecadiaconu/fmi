//varianta 3, problema 3

#include <iostream>
#include <fstream>
#include <vector>
#include <bits/stdc++.h>

using namespace std;

int mergeS(int st, int mid, int dr, vector <int> v){
    int nri = 0;
    int i, j;
    vector <int> vs, vd;

}

int mergeSort(int st, int dr, vector <int> v){
    int inv = 0;
    if(st == dr) return 0;
    if(dr - st == 1)
        if(v[st] > 2*v[dr]) return 1;
        else return 0;
    if(dr - st == 2){
        int nr = 0;
        if(v[st] > 2*v[dr]) nr++;
        if(v[st] > 2*v[st + 1]) nr++;
        return nr;
    }
    int mid = (int)(st + dr) / 2;
    inv = mergeSort(st, mid, v);
    inv += mergeSort(mid + 1, dr, v);
    inv += mergeS(st, mid, dr, v);

    return inv;

}

int main(){
    int n;
    vector <int> v;

    ifstream f("date.in");
    f >> n;

    for(int i = 0; i < n; i++){
        int x;
        f >> x;
        v.push_back(x);
    }




    return 0;
}