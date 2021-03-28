import numpy as np
import matplotlib.pyplot as plt


def chebyshev(k):
    x = np.cos(np.pi * ((N - k) / N))
    return (left + right) / 2 + ((right - left) / 2) * x


def newton_pol():
    coef = [y[0]]

    def sum_before_k(k):
        sum = coef[0]
        for i in range(1, k):
            sum += coef[i] * (np.prod([xs[k] - xs[j] for j in range(i)]))

        return sum

    for k in range(1, N + 1):
        term = np.prod([xs[k] - xs[j] for j in range(k)])
        c = (y[k] - sum_before_k(k)) / term
        coef.append(c)

    def get_value(x):
        pol = coef[0]
        for k in range(1, N + 1):
            pol += coef[k] * (np.prod([x - xs[j] for j in range(k)]))

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
pol = newton_pol()
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
