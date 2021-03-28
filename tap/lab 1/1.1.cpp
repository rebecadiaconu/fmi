#include <iostream>
#include <fstream>
#include <vector>
#include <fstream>
#include <algorithm>


using namespace std;

int main()
{
    int nr, x, i, j, k;
    vector <int> v;

    ifstream f("date.txt");
    f>>nr;

    for(i=0; i<nr-2; i++){
        f>>x;
        v.push_back(x);
    }

    v.resize(nr);

    sort(v.begin(), v.end());

    for(k=0; k<nr; k++){
        if ((k > 0) && (v[k] == v[k-1])) ;
        else
        {
            i = k + 1;
            j = nr - 1;
            while(i < j)
            {
                if((i > 1) && (v[i] == v[i-1])) i++;
                else
                {
                    if(v[k] + v[i] + v[j] == 0)
                    {
                        cout<< v[k] << ", " << v[i] << ", " << v[j] << endl;
                        i++;
                    }
                    else if(v[k] + v[i] + v[j] < 0)
                        i++;
                    else if(v[k] + v[i] + v[j] > 0)
                        j--;
                }
            }
        }

    }

    return 0;
}