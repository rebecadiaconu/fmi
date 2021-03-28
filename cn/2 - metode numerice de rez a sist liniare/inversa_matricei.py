import numpy as np
import copy
from sys import exit


def subst_descendenta(A, b):
    n = len(A[0])
    solution = [float('nan') for _ in range(n)]

    solution[n - 1] = b[n - 1] / A[n - 1, n - 1]

    for i in range(n - 2, -1, -1):
        suma = np.sum([A[i, j] * solution[j] for j in range(i + 1, n)])
        solution[i] = 1 / A[i, i] * (b[i] - suma)

    return solution


def gauss_pivot_totala(A, b):
    global p, m
    n = len(A[0])
    mat_extinsa = np.block([A, b])
    index = [i for i in range(n)]

    for k in range(n - 1):
        pivot = 0

        for i in range(k, n):
            for j in range(k, n):
                if np.abs(mat_extinsa[i, j]) > pivot:
                    pivot = np.abs(mat_extinsa[i, j])
                    p = i
                    m = j

        if pivot == 0:
            raise ValueError('Sistem incomp. sau comp. nedeterminat!')

        if p != k:
            mat_extinsa[[p, k]] = mat_extinsa[[k, p]]

        if m != k:
            index[m], index[k] = index[k], index[m]
            mat_extinsa[:, [k, m]] = mat_extinsa[:, [m, k]]

        for l in range(k + 1, n):
            m_lk = mat_extinsa[l, k] / mat_extinsa[k, k]
            mat_extinsa[l] = mat_extinsa[l] - m_lk * mat_extinsa[k]

    if mat_extinsa[n - 1, n - 1] == 0:
        raise ValueError('Sistem incomp. sau comp. nedeterminat!')

    a_pivot = np.array([mat_extinsa[i, :n] for i in range(n)])
    b_pivot = np.array([mat_extinsa[i, n] for i in range(n)])

    return a_pivot, b_pivot, index


B = np.array([[0., 3., -8., -1.],
              [-8., 0., -5., 7.],
              [-4., -10., -1., -8.],
              [-6., -7., -6., 6.]])

if np.linalg.det(B) > 1e-15:
    print("Matricea nu este inversabila!")
    exit(1)

n = len(B[0])
In = np.identity(n)
inversa = np.zeros(B.shape)

for i in range(n):
    matrix = copy.deepcopy(B)

    b_pivot, i_pivot, index = gauss_pivot_totala(matrix, In[:, [i]])
    sol = np.array([[float('nan')] for _ in range(n)])
    sol_temp = subst_descendenta(b_pivot, i_pivot)

    for j in range(n):
        sol[index[j]] = sol_temp[j]

    inversa[:, [i]] = sol

print("Matricea este inversabila.\nInversa ei este: \n")
print(inversa)
print(np.abs(1 - np.linalg.det(np.dot(B, inversa))) < 1e-15)
