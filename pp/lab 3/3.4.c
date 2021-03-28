#include <stdio.h>
#include <stdlib.h>
#include "matrice.h"

matrix citire() {
    matrix result;
    scanf("%d", &result.elem_nenule);

    int i;
    for (i = 0; i < result.elem_nenule; i++) {
        scanf("%d %d %d", &result.elem[i][0], &result.elem[i][1], &result.elem[i][2]);
    }

    return result;
}

void afisare(matrix result) {
    int i;
    for (i = 0; i < result.elem_nenule; i++)
        printf("Linia: %d Coloana: %d Valoarea: %d \n", result.elem[i][0], result.elem[i][1], result.elem[i][2]);

    printf("\n");
}

matrix adunare(matrix m1, matrix m2) {
    matrix result;
    result.elem_nenule = m1.elem_nenule;
    int i, j;

    for (i = 0; i < m1.elem_nenule; i++) {
        result.elem[i][0] = m1.elem[i][0];
        result.elem[i][1] = m1.elem[i][1];
        result.elem[i][2] = m1.elem[i][2];
    }
    printf("Matricea SUMA dupa adaugarea primei matrici: \n");
    afisare(result);

    for (j = 0; j < m2.elem_nenule; j++) {
        int found = 0;

        for (i = 0; i < result.elem_nenule; i++)
            if (m2.elem[j][0] == result.elem[i][0] && m2.elem[j][1] == result.elem[i][1]) {
                result.elem[i][2] += m2.elem[j][2];
                found = 1;
            }

        if (found == 0) {
            result.elem_nenule += 1;
            result.elem[result.elem_nenule][0] = m2.elem[j][0];
            result.elem[result.elem_nenule][1] = m2.elem[j][1];
            result.elem[result.elem_nenule][2] = m2.elem[j][2];
        }
    }

    return result;
}

matrix inmultire(matrix m1, matrix m2) {
    matrix result;
    result.elem_nenule = 0;
    int i, j;

    pafisare(result);

    for (int idx1 = 0; idx1 < m1.elem_nenule; idx1++) {
        for (int idx2 = 0; idx2 < m2.elem_nenule; idx2++) {
            // Daca linia pe care se afla al doilea element este diferita
            // de coloana pe care se afla primul element, atunci ele nu vor
            // fi inmultite.
            if (m1.elem[idx1][1] != m2.elem[idx2][0]) {
                continue;
            }

            // Cautam un element pe linia lui m1.elems[idx1] si coloana lui
            // m2.elems[idx2] in result2. Daca nu exista, cream unul.
            int found = 0;
            for (int idx_res = 0; idx_res < result.elem_nenule; idx_res++) {
                if ((result.elem[idx_res][0] == m1.elem[idx1][0]) &&
                    (result.elem[idx_res][1] == m2.elem[idx2][1])) {
                    // Adaug produsul elementelor in result2at.
                    result.elem[idx_res][2] += m1.elem[idx1][2] * m2.elem[idx2][2];
                    found = 1;
                    break;
                }
            }

            if (!found) {
                printf("Creat element nou pe rand %d, coloana %d cu valoarea %d\n",
                       m1.elem[idx1][0], m2.elem[idx2][1],
                       m1.elem[idx1][2] * m2.elem[idx2][2]);

                result.elem[result2.elem_nenule][0] = m1.elem[idx1][0];
                result.elem[result2.elem_nenule][1] = m2.elem[idx2][1];
                result.elem[result2.elem_nenule][2] =
                        m1.elem[idx1][2] * m2.elem[idx2][2];

                result.elem_nenule += 1;
            }
        }
    }

    // Obs: result2 poate sa nu aiba elementele sortate dupa linie.
    return result;
}

int main() {
    printf("Prima matrice:\n");
    matrix M1 = citire();
    printf("A doua matrice: \n");
    matrix M2 = citire();

    if (L2 != L1 || c1 != c2) printf("Adunarea nu poate avea loc; matricele au dimensiuni diferite.\n");
    else {
        matrix added = adunare(M1, M2);
        printf("SUMA celor doua matrici: \n");
        afisare(added);
    }
    matrix multiply = inmultire(M1, M2);
    printf("Cele doua matrice inmultite: \n");
    afisare(multiply);

    return 0;
}
