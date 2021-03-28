#include <iostream>
#include <fstream>
#include <string.h>

#define dim 200

using namespace std;

typedef struct{
    char stare[dim];
}A;

typedef struct{
    char final[dim];
}B;

int poz(char ch, char sir[dim]){

    int i;
    for(i=0; i<strlen(sir); i++)
        if(sir[i] == ch) return i;
    return -1;
}


void deleteStare(int ind, char stari[dim], char ch, char fin[dim], char nefin[dim], int viz[]){
    int i;
    for(i=ind; i<strlen(stari)-1;i++)
        viz[i] = viz[i+1];
    for(i=0; i<strlen(stari); i++)
        if(stari[i] == ch) strcpy(stari+i, stari+i+1);
    for(i=0; i<strlen(fin); i++)
        if(fin[i] == ch) strcpy(fin+i, fin+1+i);
    for(i=0; i<strlen(nefin); i++)
        if(nefin[i] == ch) strcpy(nefin+i, nefin+i+1);

}

void afd(char index, int viz[], char stari[dim], char alphab[dim], char mat1[dim][dim]){
    if(viz[poz(index, stari)] == 0) viz[poz(index, stari)] = 1;

    for(int i=0; i<strlen(alphab); i++)
        if(mat1[poz(index,stari)][i] != '-' && viz[poz(mat1[poz(index,stari)][i], stari)] == 0)
            afd(mat1[poz(index, stari)][i], viz, stari, alphab, mat1);

}

int diferit(char ch1, char ch2, char fin[dim], char nefin[dim]){
    int ok = 1;
    if(strchr(fin, ch1) != 0 && strchr(fin,ch2) != 0) ok = 0;
    if(strchr(nefin,ch1) != 0 && strchr(nefin,ch2) != 0) ok = 0;
    return ok;
}

char* pereche(int nr, A sir[], char ch, char stare[dim], char stari[dim], char alphab[dim], char x) {
    int j;
    for (j = 0; j < nr; j++)
        if (strchr(sir[j].stare, x) != 0)
            return sir[j].stare;

}

int main() {
    char alphab[dim], stari[dim], fin[dim], nefin[dim], mat1[dim][dim], init, c;
    int i, j, k, nrtranz, n = 0, mat2[dim][dim];

    ifstream f("tranz2.txt");
     ofstream g("minimal2.txt");

    //citesc starile, alfabetul si starile finale
    f>>stari;
    f>>alphab;
    f>>fin;
    f>>init;

    //formez multimea cu stari nefinale
    for(i=0; i<strlen(stari); i++){
        c = stari[i];
        if(strchr(fin, c) == 0){
            nefin[n] = c;
            n++;
        }
    }

    //construiesc matricea cu tranzitiile
    for(i=0; i<strlen(stari); i++)
        for(j=0; j<strlen(alphab); j++)
            mat1[i][j]  = '-';

    f>>nrtranz;
    for(i=0; i<nrtranz; i++){
        char x, y, z;
        f>>x>>y>>z;
        mat1[poz(x,stari)][poz(y,alphab)] = z;
    }

    //elimin starile in care nu pot ajunge
    int viz[strlen(stari)];
    for(i=0; i<strlen(stari); i++){
        viz[i] = 0;
    }

    afd(init, viz, stari, alphab, mat1);

    i=0;
    while(stari[i]!= NULL){
        if(viz[i] == 0){
            deleteStare(i, stari, stari[i], fin, nefin, viz);
            int j, k;
            for(j=i;j<strlen(stari)-1;j++)
                for(k=0;k<strlen(alphab);k++)
                    mat1[j][k] = mat1[j+1][k];
        }
        else {
            i++;
        }
    }

    //contruiesc matricea pentru minimizarea dfa-ului
    for(i=0; i<strlen(stari); i++)
        for(j=0; j<strlen(stari); j++)
            mat2[i][j] = 0;

    for(i=1; i<strlen(stari);i++)
        for(j=0; j<i; j++)
            if(diferit(stari[i],stari[j],fin, nefin) == 1) mat2[i][j] = 1;

    int modif = 1;
    while(modif == 1) {
        modif = 0;
        for (i = 1; i < strlen(stari); i++)
            for (j = 0; j < i; j++)
                if (mat2[i][j] == 0) {
                    int k, ok = 0;
                    for (k = 0; k < strlen(alphab); k++) {
                        char x, y, aux;
                        x = mat1[i][k];
                        y = mat1[j][k];
                        if (x < y) {
                            aux = x;
                            x = y;
                            y = aux;
                        }

                        if (mat2[poz(x, stari)][poz(y, stari)] == 1) ok = 1;
                    }
                    if (ok == 1) {
                        mat2[i][j] = 1;
                        modif = 1;
                    }
                }
    }

    /*for(i=0;i<strlen(stari);i++)
    {
        for(j=0;j<i;j++)
            cout<<mat2[i][j]<<" ";
        cout<<endl;
    }*/

    char v[strlen(stari)];
    for(i=0; i<strlen(stari); i++)
        v[i] = '-';

    int nr = 0;
    for(i=1;i<strlen(stari); i++)
        for(j=0; j<i; j++)
            if(mat2[i][j] == 0) {
                char x, y;
                x = stari[i];
                y = stari[j];
                if(v[j] == '-')
                {
                    v[i] = y;
                    v[j] = y;
                    nr++;
                }
                else
                {
                    v[i] = v[j];
                }

            }


    for(i=0; i<strlen(stari); i++)
        if(v[i] == '-'){
            v[i] = stari[i];
            nr++;
        }

   /* for(i=0;i <strlen(stari); i++)
        cout<<v[i]<<" ";
    cout<<endl;*/

    A sir[nr];
    n = 0;
    int poz  = 0;
    while(n < nr){
        int m = 0;
        char k = v[poz];
        sir[n].stare[m++] = '(';
        for(i=poz; i<strlen(stari); i++){
            if(v[i] == k)
            {
                sir[n].stare[m] = stari[i];
                m++;
                sir[n].stare[m] = ' ';
                m++;
            }
            else{
                poz = i;
                break;
            }

        }
        sir[n].stare[m++] = ')';
        sir[n].stare[m] = '\0';
        n++;
    }

    for(i=0; i<nr; i++)
    {
        char y, x;
        int ind, k;
        y = sir[i].stare[1];
        for(k=0;k<strlen(stari);k++)
            if(stari[k] == y) ind = k;
        for(j=0; j<strlen(alphab); j++)
        {
            x = mat1[ind][j];
            g<<"Starea  "<<sir[i].stare<<" se duce cu "<<alphab[j]<<" in starea ";
            g<<pereche(nr, sir, alphab[j], sir[i].stare, stari, alphab, x);
            g<<endl;
        }

    }

    int nrf = 0;
    B rez[nr];
    for(i=0; i<nr; i++){
        for(j=0; j<strlen(sir[i].stare); j++)
            if(strchr(fin, sir[i].stare[j]) != 0){
                strcpy(rez[nrf].final, sir[i].stare);
                nrf++;
                break;
            }
    }
    if(nrf == 0)
         g<<"Starea finala a automatului este: "<<rez[nrf].final<<endl;
    else{
        g<<"Starile finale sunt: ";
        for(i=0;i<nrf; i++)
            g<<rez[i].final<<" ";
        g<<endl;
    }

    return 0;
}
