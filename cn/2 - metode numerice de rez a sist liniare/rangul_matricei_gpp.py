import numpy as np


def rang_gpp(A):
    global p
    m = np.shape(A)[0]
    n = np.shape(A)[1]

    rang = 0
    h = 0
    k = 0

    while h < m and k < n:

        pivot = 0

        for j in range(h, m):
            if np.abs(A[j, k]) > pivot:
                pivot = np.abs(A[j, k])
                p = j

        if pivot == 0:
            k += 1
        else:
            if p != h:
                A[[p, h]] = A[[h, p]]

            for l in range(h + 1, m):
                m_lk = A[l, k] / A[h, k]
                A[l] = A[l] - m_lk * A[k]

            h += 1
            k += 1
            rang += 1

    return rang


A = np.array([[4., -1., 5., 0.],
              [1., 0., -3., 0.],
              [0., 0., 0., 1.],
              [3., -1., 8., 0.]], dtype=float)

rang = rang_gpp(A)

print('Rangul matricei: ', rang)

