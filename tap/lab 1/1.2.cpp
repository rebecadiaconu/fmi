#include <iostream>
#include <queue>
#include <fstream>

using namespace std;

float vmin(float a, float b, float c){
    if(a <= b && a <= c) return a;
    if(b <= a && b <= c) return b;
    if(c <= a && c <= b) return c;
}

int main() {
    int n, x, y, z, i, m = 0, hmax = 0;
    float r = 0;
    priority_queue <pair<pair<int, int>, int> > myheap;

    ifstream f("date.txt");
    f >> n;

    for (i = 0; i < n; i++) {
        f >> x >> y >> z;

        float c = vmin(x,y,z);
        if(c/2 > r) r = c/2;

        if (x < y) myheap.push(make_pair(make_pair(x, y), z));
        else myheap.push(make_pair(make_pair(y, x), z));

        if (y < z) myheap.push(make_pair(make_pair(y, z), x));
        else myheap.push(make_pair(make_pair(z, y), x));

        if (z < x) myheap.push(make_pair(make_pair(z, x), y));
        else myheap.push(make_pair(make_pair(x, z), y));

    }
    

    pair <int, int> poz;
    poz = make_pair(0,0);
    for(i=0; i<myheap.size() - 1; i++) {
        pair <pair <int, int>, int> p;
        p = myheap.top();
        myheap.pop();

        if (p.first.first == myheap.top().first.first && p.first.second == myheap.top().first.second) {
            if(vmin(p.first.first, p.first.second, p.second+ myheap.top().second )/2 >= r)
            {
                hmax = p.second+ myheap.top().second;
                poz = make_pair(p.first.first, p.first.second);
                r = vmin(p.first.first, p.first.second, p.second+ myheap.top().second)/2;
            }
        }

        else if(vmin(p.first.first, p.first.second, p.second)/2 >= r) {
            r = vmin(p.first.first, p.first.second, p.second)/2;
            poz = make_pair(p.first.first, p.first.second);
            hmax = p.second;
        }
        
    }


    cout<<"Tripletul cu cea mai mare raza este: ("<<poz.first<<" "<<poz.second<<" "<<hmax<<")."<<endl;
    cout<<"Raza este: "<<r;

    return 0;

}
