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


def factLU_GPP(A):
    global p
    n = len(A[0])
    L = np.identity(n)
    U = copy.deepcopy(A)
    P = np.identity(n)

    for k in range(n - 1):
        L[k, k] = 1
        p = np.argmax(np.abs(U[k:, k])) + k

        if U[p, k] == 0:
            raise ValueError('A nu admite fact. LU cu GPP')

        if p != k:
            U[[p, k]] = U[[k, p]]
            P[[p, k]] = P[[k, p]]

            if k > 0:
                L[[p, k], :k] = L[[k, p], :k]

        for l in range(k + 1, n):
            m_lk = U[l, k] / U[k, k]
            L[l, k] = m_lk
            U[l] = U[l] - m_lk * U[k]

    if U[n - 1, n - 1] == 0:
        raise ValueError('A nu admite fact. LU cu GFP')

    return L, U, P


A = np.array([[0., 1., 2.],
              [1., 0., 1.],
              [3., 2., 1.]], dtype=float)
b = np.array([[8, 4, 10]], dtype=float).T

if np.linalg.det(A) == 0:
    print('Sistemul nu admite solutie unica!')
    exit(1)

L, U, P = factLU_GPP(A)
print(L)
print(U)

y = subst_ascendenta(L, np.dot(P, b))
print(y)
x = subst_descendenta(U, y)

for i in range(len(x)):
    print(str(i + 1) + ". ", x[i])

