#include<iostream>
#include<cstring>
#include<string>
#include <fstream>
#include<iomanip>

using namespace std;

#define dim 200

typedef struct{
    string T;
    string s[dim];
    int nrCuv;
}cyk;

cyk v[dim];

string concat( string a, string b)
{
    int i;
    string aux=a;
    for(i=0; i<b.length(); i++)
        if(aux.find(b[i]) > aux.length())
            aux+=b[i];
    return (aux);
}

void gram(string tranz, int n)
{
    int i, nr = 0, poz;

    poz=tranz.find("->");
    v[n].T = tranz[0];
    tranz = tranz.substr(poz+2, tranz.length());
    while(tranz.length())
    {
        i=tranz.find("|");
        if(i>tranz.length())
        {
            v[n].s[nr++] = tranz;
            tranz="";
        }
        else
        {
            v[n].s[nr++] = tranz.substr(0,i);
            tranz=tranz.substr(i+1,tranz.length());
        }
    }
    v[n].nrCuv = nr;
}

string prod(string prod, int nrtranz)
{
    int i,k;
    string aux="";

    for(i=0; i<nrtranz; i++)
    {
        k=0;
        while(v[i].s[k] != "" && k<v[i].nrCuv)
        {
            if(prod==v[i].s[k])
            {
                aux=concat(aux, v[i].T);
            }
            k++;
        }
    }
    return (aux);
}

string combina(string a, string b, int nrtranz)  // BA * AB = {BA, BB, AA, BB}
{
    int i,j;
    string sir, rez="";
    for(i=0; i<a.length(); i++)
        for(j=0; j<b.length(); j++)
        {
            sir="";
            sir=sir+a[i]+b[j];
            rez=rez+ prod(sir, nrtranz);
        }
    return (rez);
}

int main()
{
    int i, j, l, k, nrtranz;
    string tranz, cuv, s, start, aux;

    ifstream f("cyk1.txt");
    ofstream g("lfa1.txt");
    f>>start;
    f>>nrtranz;

    for(i=0; i<nrtranz; i++)
    {
        f>>tranz;
        gram(tranz, i);
    }
    f>>cuv;

    string mat[dim][dim];
    f >> cuv;

    for(i=0;i<cuv.length();i++)       //Assigns values to principal diagonal of matrix
    {
        s="";
        aux = "";
        aux += cuv[i];
        for(j=0; j<nrtranz; j++)
        {
            k=0;
            while(k < v[j].nrCuv){
                if(v[j].s[k] == aux)
                {
                    s = concat(s, v[j].T);
                }
                k++;
            }
        }
        mat[i][i] = s;
    }
    for(k=1; k<cuv.length(); k++)       //Assigns values to upper half of the matrix
    {
        for(j=k;j<cuv.length(); j++)
        {
            s="";
            for(l=j-k;l<j;l++)
            {
                aux = combina(mat[j-k][l], mat[l+1][j], nrtranz);
                s = concat(s, aux);
            }
            mat[j-k][j] = s;
        }
    }

    for(i=0; i<cuv.length(); i++)
    {
        k=0;
        l = cuv.length()-i-1;
        for(j=l; j<cuv.length(); j++)
        {
            g<<setw(5)<<mat[k++][j]<<" ";
        }
        g<<endl;
    }

    for(i=0; i<start.length(); i++)
        if(mat[0][cuv.length()-1].find(start[i]) <= mat[0][cuv.length()-1].length())   //Checks if last element of first row contains a Start variable
        {
            g<<"Cuvantul poate fi generat. \n";
            return 0;
        }
        else g<<"Cuvantul nu poate fi generat. \n";

    return 0;
}
