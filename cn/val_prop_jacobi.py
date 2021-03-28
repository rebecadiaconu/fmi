import numpy as np
from sys import exit


def modul_matrice(A):
    n = len(A[0])
    squared_sum = np.sum([A[i, j] ** 2 for j in range(n) for i in range(n)]) - np.sum([A[i, i] ** 2 for i in range(n)])

    return np.sqrt(squared_sum)


def metoda_jacobi(A, epsilon=1e-5):
    global teta, p, q
    n = len(A[0])

    while modul_matrice(A) > epsilon:
        pivot = 0

        for i in range(n):
            for j in range(n):
                if i < j and np.abs(A[i, j]) > pivot:
                    pivot = np.abs(A[i, j])
                    p = np.min([i, j])
                    q = np.max([i, j])

        if A[p, p] == A[q, q]:
            teta = np.pi / 4
        else:
            teta = (np.arctan(2 * A[p, q] / (A[q, q] - A[p, p]))) / 2

        c = np.cos(teta)
        s = np.sin(teta)

        for j in range(n):
            if j != p and j != q:
                u = A[p, j] * c - A[q, j] * s
                v = A[p, j] * s + A[q, j] * c
                A[p, j], A[q, j] = u, v
                A[j, p], A[j, q] = u, v

        u = c ** 2 * A[p, p] - 2 * c * s * A[p, q] + s ** 2 * A[q, q]
        v = s ** 2 * A[p, p] + 2 * c * s * A[p, q] + c ** 2 * A[q, q]
        A[p, p], A[q, q] = u, v
        A[p, q] = A[q, p] = 0.

    return A


A = np.array([[17., -2., 3 * np.sqrt(3)],
              [-2., 8., 2 * np.sqrt(3)],
              [3 * np.sqrt(3), 2 * np.sqrt(3), 11.]], dtype=float)
n = len(A[0])

if not np.allclose(A, A.T, rtol=1e-05, atol=1e-08):
    print('Matricea nu este simetrica')
    exit(1)

A_Jacobi = metoda_jacobi(A)

print("Matricea Jacobi asociata lui A este:")
print(A_Jacobi)

print('\nValorile proprii ale matricei A sunt: ')
for val_proprie in [A_Jacobi[k, k] for k in range(n)]:
    print(val_proprie)