import numpy as np
from sys import exit


def subst_ascendenta(A, b):
    n = len(A[0])
    solution = [float('nan') for _ in range(n)]

    solution[0] = b[0] / A[0, 0]

    for i in range(1, n):
        solution[i] = (1 / A[i, i]) * (b[i] - np.sum([A[i, j] * solution[j] for j in range(i)]))

    return solution


A = np.array([[1, 0, 0], [4, 4, 0], [-2, -1, 2]], dtype=float)
b = np.array([[1, 8, -1]], dtype=float).T

if np.abs(np.linalg.det(A)) < 1e-14:
    print("Sistemul nu are solutie")
    exit(1)

sol = subst_ascendenta(A, b)

for i in range(len(sol)):
    print(str(i + 1) + ". ", sol[i])