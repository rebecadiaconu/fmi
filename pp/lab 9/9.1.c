#include <stdio.h>
#include <stdlib.h>

#define max_lung 100

typedef struct {
    int salariu;
    char cnp[13];
    char *nume;
    int varsta;
} angajat;

void creare(char *fis) {
    angajat a;
    FILE *f = fopen(fis, "wb");

    a.nume = (char *) malloc(max_lung);
    printf("Nume  CNP    Varsta   Salariu\n");
    scanf("%s %13s %d %d", a.nume, a.cnp, &a.varsta, &a.salariu);
    fwrite(&a, sizeof(angajat), 1, f);

    fclose(f);
    free(a.nume);
}

void afisCod(char *fis, char y[13]) {
    FILE *f = fopen(fis, "rb");
    angajat a;
    while (fread(&a, sizeof(angajat), 1, f)) {
        if (strcmp(y, a.cnp) == 0) {
            printf("Angajatul cu CNP-ul %s se numeste %s , de %d ani si cu salariul %d.\n", y, a.nume, a.varsta,
                   a.salariu);
            break;
        }
    }

    fclose(f);
}

void adaugare(char *nume, angajat a) {
    FILE *f = fopen(nume, "a+");
    a.nume = (char *) malloc(max_lung);
    printf("Nume  CNP    Varsta   Salariu\n");
    scanf("%s %13s %d %d", &a.nume, &a.cnp, &a.varsta, &a.salariu);
    fwrite(&a, sizeof(angajat), 1, f);

    fclose(f);
}

void salariuMediu(char *numebin, char *text) {
    float salMediu = 0;
    int nr = 0;
    FILE *f = fopen(numebin, "rb");
    FILE *txt = fopen(text, "w");
    angajat a;

    while (fread(&a, sizeof(angajat), 1, f)) {
        salMediu = salMediu + a.salariu;
        nr++;
        fprintf(txt, "Angajatul %s are salariul %d. \n", a.nume, a.salariu);
    }

    salMediu = salMediu / nr;
    fprintf(txt, "%f", salMediu);

    fclose(f);
    fclose(txt);
}

void salMaxim(char *bin) {
    int vmax = 0;
    FILE *f = fopen(bin, "rb");
    angajat a;

    while (fread(&a, sizeof(angajat), 1, f)) {
        if (a.salariu > vmax) vmax = a.salariu;
    }

    fseek(f, 0, 0);
    printf("Persoanele care au salariul maxim sunt: \n");
    while (fread(&a, sizeof(angajat), 1, f)) {
        if (a.salariu == vmax) printf("%s   ", a.nume);
    }

    fclose(f);
}

int main() {
    int n;
    char sir[13];
    printf("Citim n angajati, unde n este: ");
    scanf("%d", &n);

    for (i = 0; i < n; i++)
        creare("angajati.bin");

    printf("CNP-ul dupa care facem cautarea este: ");
    scanf("%s", &sir);

    afisCod("angajati.bin", sir);
    salariuMediu("angajati.bin", "salarii.txt");
    salMaxim("angajati.bin");

    return 0;
}
