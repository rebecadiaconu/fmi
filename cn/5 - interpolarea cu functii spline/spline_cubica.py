import numpy as np
import copy
import matplotlib.pyplot as plt


def get_coeff():
    a = copy.deepcopy(y)

    # retinem coloana termenilor liberi ai sistemului
    B = np.zeros((N + 1, 1))
    B[0] = f_deriv(x[0])
    for i in range(1, N):
        B[i] = 3 * (y[i + 1] - y[i - 1]) / h
    B[N] = f_deriv(x[N])

    # rezolvam sistemul => b
    b = np.linalg.solve(M, B)

    # urmam formula si obtinem coeficientul c si d din b-uri
    c = np.zeros(N)
    d = np.zeros(N)

    for i in range(N):
        c[i] = 3 * (y[i + 1] - y[i]) / (h ** 2) - (b[i + 1] + 2 * b[i]) / h
        d[i] = - 2 * (y[i + 1] - y[i]) / (h ** 3) + (b[i + 1] + b[i]) / (h ** 2)

    return a, b, c, d


def splineCubica(i, val):
    T = val - x[i]
    return a[i] + b[i] * T + c[i] * (T ** 2) + d[i] * (T ** 3)


f = lambda x: 4 * np.sin(5 * x) - 3 * np.cos(1 * x) + 3.83 * x
f_deriv = lambda x: 20 * np.cos(5 * x) + 3 * np.sin(1 * x) + 3.83
left = -np.pi
right = np.pi
N = 173

x = np.linspace(left, right, N + 1)
y = f(x)

# pentru coeficientul b trebuie rezolvat un sistem de ecuatii liniare: M * b = B
M = np.zeros((N + 1, N + 1))

M[0, 0] = 1
for i in range(1, N):
    M[i, i - 1] = 1
    M[i, i] = 4
    M[i, i + 1] = 1
M[N, N] = 1

h = x[1] - x[0]
a, b, c, d = get_coeff()

# Reprezentam grafic functia
x_grafic = np.linspace(left, right, 500)
y_grafic = f(x_grafic)

intervNth = []
for i in range(len(x_grafic)):
    pos = 0
    for j in range(N):
        if x[j] <= x_grafic[i] <= x[j + 1]:
            pos = j
            break

    intervNth.append(pos)

y_spline = np.array([splineCubica(intervNth[i], x_grafic[i]) for i in range(len(x_grafic))])

plt.figure('Interpolare cu functii spline cubice')
plt.plot(x_grafic, y_grafic, color="gold", label='Functia exacta')
plt.plot(x_grafic, y_spline, linestyle='--', color="red", label='Functia spline')
plt.scatter(x, y, s=50, marker="x", label='Noduri de interpolare')
plt.title('Interpolare cu functii spline cubice')
plt.legend()
plt.show()


# Calculam si plotam eroarea maxima
errors = [np.abs(y_grafic[i] - y_spline[i]) for i in range(len(x_grafic))]
max_error = np.max(errors)

# print(maxError_ex3 <= 1e-5)

plt.figure()
plt.plot(x_grafic, errors)
plt.hlines(1e-5, xmin=left, xmax=right, color='red')
plt.hlines(max_error, label='Eroarea maxima', xmin=left, xmax=right, color='orange')
plt.title('Eroarea de trunchiere cu functie Spline')
plt.legend()
plt.show()

print("Eroarea maxima: ", str(max_error), "\n")