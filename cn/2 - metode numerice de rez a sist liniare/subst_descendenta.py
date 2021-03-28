import numpy as np
from sys import exit


def subst_descendenta(A, b):
    n = len(A[0])
    solution = [float('nan') for _ in range(n)]

    solution[n - 1] = b[n - 1] / A[n - 1, n - 1]

    for i in range(n - 2, -1, -1):
        solution[i] = 1 / A[i, i] * (b[i] - np.sum([A[i, j] * solution[j] for j in range(i + 1, n)]))

    return solution


A = np.array([[2, -1, -2], [0, 4, 4], [0, 0, 1]], dtype=float)
b = np.array([[-1, 8, 1]], dtype=float).T

if np.abs(np.linalg.det(A)) < 1e-14:
    print("Sistemul nu are solutie")
    exit(1)

sol = subst_descendenta(A, b)

for i in range(len(sol)):
    print(str(i + 1) + ". ", sol[i])