import numpy as np
import matplotlib.pyplot as plt


def chebyshev(k):
    x = np.cos(np.pi * ((N - k) / N))
    return (left + right) / 2 + ((right - left) / 2) * x


def newton_DD():
    def get_matrix():
        Q = np.zeros([N + 1, N + 1])

        for i in range(N + 1):
            Q[i, 0] = y[i]

        for j in range(1, N + 1):
            for i in range(j, N + 1):
                Q[i, j] = (Q[i, j - 1] - Q[i - 1, j - 1]) / (xs[i] - xs[i - j])

        return Q

    def get_value(x):
        Q = get_matrix()
        pol = Q[0, 0]

        for k in range(1, N + 1):
            pol += Q[k, k] * (np.prod([x - xs[j] for j in range(k)]))

        return pol

    return get_value


f = lambda x: -2 * np.sin(3 * x) - 9 * np.cos(3 * x) + 1.07 * x
left = -np.pi
right = np.pi
N = 21
xs = np.array([chebyshev(k) for k in range(N + 1)])
y = f(xs)

x_grafic = np.linspace(left, right, 500)
y_grafic = f(x_grafic)

# Plotam functia + aproximarile facute
plt.plot(x_grafic, y_grafic, linestyle='-', label='funcția f')
plt.scatter(xs, y, c='red')
pol = newton_DD()
y_approx = np.array([pol(x) for x in x_grafic])
plt.plot(x_grafic, y_approx, c='orange', linestyle='--', label=f'aproximare cu polinom de gradul {N}')
plt.legend()
plt.show()

# Plotam eroarea de trunchiere
errors = np.abs(y_approx - y_grafic)
max_error = np.max(errors)
print('Eroarea de trunchiere maxima este: ', max_error)

plt.plot(x_grafic, errors, linestyle='--', label=f'eroare pentru N={N}')
plt.hlines(1e-5, xmin=left, xmax=right, color='red')
plt.hlines(max_error, label='Eroarea maximă', xmin=left, xmax=right, color='orange')
plt.legend()
plt.show()
