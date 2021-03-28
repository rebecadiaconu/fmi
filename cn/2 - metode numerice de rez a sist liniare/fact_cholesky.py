import numpy as np
from sys import exit


def cholesky_direct(A):
    n = len(A[0])
    L = np.zeros(A.shape)

    alpha = A[0, 0]
    if alpha <= 0:
        raise ValueError('A nu este pozitiv definita!')

    L[0, 0] = np.sqrt(A[0, 0])
    for i in range(1, n):
        L[i, 0] = A[i, 0] / L[0, 0]

    for k in range(1, n):
        suma = np.sum([L[k, s] ** 2 for s in range(k)])
        alpha = A[k, k] - suma

        if alpha <= 0:
            raise ValueError('A nu este pozitiv definita!')

        L[k, k] = np.sqrt(alpha)

        for i in range(k + 1, n):
            suma = np.sum([L[i, s] * L[k, s] for s in range(k)])
            L[i, k] = (A[i, k] - suma) / L[k, k]

    return L


A = A = np.array([[25, 15, -5], [15, 18, 0], [-5, 0, 11]], dtype=float)

if not np.allclose(A, A.T, rtol=1e-05, atol=1e-08):
    print('Matricea nu este simetrica, deci nu admite factorizare Cholesky.')
    exit(1)

L = cholesky_direct(A)
print(L)
