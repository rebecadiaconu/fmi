//Varianta 1, Problema 1

#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

int findElement( vector <int> v, int ind1, int ind2){
    while(ind1 <= ind2){
        int mid = (ind1 + ind2) / 2;
        if(v[mid] == mid) return mid;
        if(v[mid] < mid) ind1 = mid + 1;
        if(v[mid] > mid) ind2 = mid - 1;

    }
    return -1;
}

int main() {
    int n, i, x;
    vector <int> v;

    ifstream f("date.in");
    f >> n;

    for(i = 0; i < n; i++){
        f >> x;
        v.push_back(x);
    }


    if(findElement(v, 0, n) ==  -1) cout << "Nu exista niciun element in vector care sa respecte cerinta problemei. \n";
    else cout << "Exista un element in vector astept incat v[i] = i si aceste este: " << findElement(v, 0, n) << endl;

    return 0;
}