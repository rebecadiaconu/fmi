#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef struct {
    int id;
    char nume[20];
    char prenume[20];
    float nota;
} student;

void creare(char *nume, int n) {
    FILE *f = fopen(nume, "wb");
    int i;

    for (i = 0; i < n; i++) {
        student x;
        printf(" ID  Nume   Prenume   Nota\n");
        scanf("%d %s %s %f", &x.id, &x.nume, &x.prenume, &x.nota);
        fwrite(&x, sizeof(student), 1, f);
    }

    fclose(f);
}

void afisare(char *binar, char *fisier) {
    FILE *f = fopen(binar, "rb");
    FILE *text = fopen(fisier, "w");
    int i;

    fseek(f, 0, 0);
    student x;
    while (fread(&x, sizeof(student), 1, f)) {
        fprintf(text, "Studentul %s %s cu ID-ul %d are nota %f \n", x.nume, x.prenume, x.id, x.nota);
    }

    fclose(f);
    fclose(text);
}

void modificare(char *nume, int a, float b) {
    FILE *f = fopen(nume, "rb+");
    student x;

    while (fread(&x, sizeof(student), 1, f)) {
        if (x.id == a)
            break;
    }

    if (feof(f)) {
        printf("Acest id nu exista. \n");
        return;
    }

    x.nota = b;
    int tmp = sizeof(student);
    fseek(f, -tmp, 1);
    fwrite(&x, sizeof(student), 1, f);
    fclose(f);
}

void adaugare(char *nume, student x) {
    FILE *f = fopen(nume, "a+");

    printf(" ID  Nume   Prenume   Nota\n");
    scanf("%d %s %s %f", &x.id, &x.nume, &x.prenume, &x.nota);
    fseek(f, 0, 2);
    fwrite(&x, sizeof(student), 1, f);

    fclose(f);
}

int main() {
    int n, id;
    float notaNoua;
    student x;
    printf("n= ");
    scanf("%d", &n);

    creare("studenti.bin", n);
    afisare("studenti.bin", "stud.txt");

    printf("ID-ul cautat este: ");
    scanf("%d", &id);
    printf("Noua nota este: ");
    scanf("%f", &notaNoua);
    modificare("studenti.bin", id, notaNoua);
    afisare("studenti.bin", "stud.txt");

    adaugare("studenti.bin", x);
    afisare("studenti.bin", "stud.txt");

    return 0;
}