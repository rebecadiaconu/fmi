#include <stdio.h>
#include <stdlib.h>
#include "fisier.h"

int compara_nume(const void *stud1, const void *stud2) {
    student *a = (student *) stud1;
    student *b = (student *) stud2;

    return strcmp(a->nume, b->nume);
}

void citire(student *v, int *nr) {
    student a;
    scanf("%d %100s %f %f %f", &a.legitimatie, &a.nume, &a.mate, &a.info, &a.bac);

    a.medie = Medie(a);

    if (a.medie > 5) a.admis = 1;
    else a.admis = 0;

    v[*nr] = a;
    *nr += 1;
    qsort(v, *nr, sizeof(student), compara_nume);
}

void afisare(student v[], int nr) {
    int i;
    for (i = 0; i < nr; i++) {
        printf("Legitimatie: %d Nume: %100s Nota mate: %.2f Nota info: %.2f Nota bac: %.2f Medie: %.2f Buget: %d\n",
               v[i].legitimatie, v[i].nume, v[i].mate, v[i].info, v[i].bac, v[i].medie, v[i].buget);
    }
}

int compara_medie(const void *stud1, const void *stud2) {
    student *a = (student *) stud1;
    student *b = (student *) stud2;

    return a->medie < b->medie;
}

void buget(student *v, int nr) {
    int i, count_buget;
    count_buget = 0.75 * nr;

    qsort(v, nr, sizeof(student), compara_medie);

    for (i = 0; i < nr; i++)
        if (i < count_buget) v[i].buget = 1;
        else v[i].buget = 0;
}

void taxa(student v[], int nr) {
    int i;

    for (i = 0; i < nr; i++) {
        if (v[i].buget == 0 && v[i].admis == 1)
            printf("Legitimatie: %d Nume: %100s Nota mate: %.2f Nota info: %.2f Nota bac: %.2f Medie: %.2f\n",
                   v[i].legitimatie, v[i].nume, v[i].mate, v[i].info, v[i].bac, v[i].medie);
    }
}

void respinsi(student v[], int nr) {
    int i;

    for (i = 0; i < nr; i++) {
        if (v[i].admis == 0)
            printf("Legitimatie: %d Nume: %100s Nota mate: %.2f Nota info: %.2f Nota bac: %.2f Medie: %.2f\n",
                   v[i].legitimatie, v[i].nume, v[i].mate, v[i].info, v[i].bac, v[i].medie);
    }
}

int main() {
    student v[Max_Studenti];
    int nr = 0, i;

    for (i = 0; i < 5; i++)
        citire(v, &nr);

    int t;
    printf("Meniu functii: \n 1.Afisare alfabetica\n 2.Afisare dupa medie(+ buget completat)\n 3.Taxa\n 4.Respinsi\n");
    printf("Alege un numar: ");
    scanf("%d", &t);

    while (t >= 1 && t <= 4) {
        switch (t) {
            case 1: {
                afisare(v, nr);
            }
                break;
            case 2: {
                buget(v, nr);
                afisare(v, nr);
            }
                break;
            case 3: {
                taxa(v, nr);
            }
                break;
            case 4: {
                respinsi(v, nr);
            }
                break;
        }
        printf("Alege un numar: ");
        scanf("%d", &t);
    }

    return 0;
}
