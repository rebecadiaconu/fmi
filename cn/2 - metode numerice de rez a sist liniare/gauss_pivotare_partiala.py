import numpy as np
from sys import exit


def subst_descendenta(A, b):
    n = len(A[0])
    solution = [float('nan') for _ in range(n)]

    solution[n - 1] = b[n - 1] / A[n - 1, n - 1]

    for i in range(n - 2, -1, -1):
        suma = np.sum([A[i, j] * solution[j] for j in range(i + 1, n)])
        solution[i] = 1 / A[i, i] * (b[i] - suma)

    return solution


def gauss_pivot_partiala(A, b):
    n = len(A[0])
    mat_extinsa = np.block([A, b])

    for k in range(n - 1):
        p = np.argmax(np.abs(mat_extinsa[k:, k])) + k

        if mat_extinsa[p, k] == 0:
            raise ValueError('Sistem incomp. sau comp. nedeterminat!')

        if p != k:
            mat_extinsa[[p, k]] = mat_extinsa[[k, p]]

        for l in range(k + 1, n):
            m_lk = mat_extinsa[l, k] / mat_extinsa[k, k]
            mat_extinsa[l] = mat_extinsa[l] - m_lk * mat_extinsa[k]

    if mat_extinsa[n - 1, n - 1] == 0:
        raise ValueError('Sistem incomp. sau comp. nedeterminat!')

    a_pivot = np.array([mat_extinsa[i, :n] for i in range(n)])
    b_pivot = np.array([mat_extinsa[i, n] for i in range(n)])

    return a_pivot, b_pivot


A = np.array([[0, 1, 2], [1, 0, 1], [3, 2, 1]], dtype=float)
b = np.array([[8, 4, 10]], dtype=float).T

if np.abs(np.linalg.det(A)) < 1e-14:
    print("Sistemul nu are solutie")
    exit(1)

a_pivot, b_pivot = gauss_pivot_partiala(A, b)
sol = subst_descendenta(a_pivot, b_pivot)

for i in range(len(sol)):
    print(str(i + 1) + ". ", sol[i])