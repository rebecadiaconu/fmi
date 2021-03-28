import numpy as np
import copy
from sys import exit


def subst_descendenta(A, b):
    n = len(A[0])
    solution = [float('nan') for _ in range(n)]

    solution[n - 1] = b[n - 1] / A[n - 1, n - 1]

    for i in range(n - 2, -1, -1):
        summ = np.sum([A[i, j] * solution[j] for j in range(i + 1, n)])
        solution[i] = 1 / A[i, i] * (b[i] - summ)

    return solution


def subst_ascendenta(A, b):
    n = len(A[0])
    solution = [float('nan') for _ in range(n)]

    solution[0] = b[0] / A[0, 0]

    for i in range(1, n):
        summ = np.sum([A[i, j] * solution[j] for j in range(i)])
        solution[i] = (1 / A[i, i]) * (b[i] - summ)

    return solution


def factLU_GFP(A):
    global p
    n = len(A[0])
    L = np.identity(n)
    U = copy.deepcopy(A)
    w = [i for i in range(n)]

    for k in range(n - 1):
        pivot = 0
        L[k, k] = 1

        for j in range(k, n):
            if np.abs(U[j, k]) > pivot:
                pivot = np.abs(U[j, k])
                p = j
                break

        if pivot == 0:
            raise ValueError('A nu admite fact. LU cu GFP')

        if p != k:
            U[[k, p]] = U[[p, k]]
            w[k], w[p] = w[p], w[k]

        for l in range(k + 1, n):
            m_lk = U[l, k] / U[k, k]
            L[l, k] = m_lk
            U[l] = U[l] - m_lk * U[k]

    if U[n - 1, n - 1] == 0:
        raise ValueError('A nu admite fact. LU cu GFP')

    return L, U, w


A = np.array([[2., 3., 2.],
              [4., 8., 5.],
              [-4., 0., 10.]], dtype=float)
b = np.array([[5., 18., 20.]], dtype=float).T

if np.linalg.det(A) == 0:
    print('Sistemul nu admite solutie unica!')
    exit(1)

L, U, w = factLU_GFP(A)
print(L)
print(U)
c = copy.deepcopy(b)

for i in range(len(w)):
    b[w[i]] = c[i]

y = subst_ascendenta(L, b)
x = subst_descendenta(U, y)

for i in range(len(x)):
    print(str(i + 1) + ". ", x[i])