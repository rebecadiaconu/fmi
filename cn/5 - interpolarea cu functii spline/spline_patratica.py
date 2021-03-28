import numpy as np
import copy
import matplotlib.pyplot as plt


def get_coeff():
    h = x[1] - x[0]
    a = copy.deepcopy(y)
    b, c = np.zeros(N), np.zeros(N)
    b[0] = f_deriv(x[0])

    for j in range(N - 1):
        b[j + 1] = 2 * (y[j + 1] - y[j]) / h - b[j]
        c[j] = (y[j + 1] - y[j] - h * b[j]) / (h ** 2)

    return a, b, c


def spline_patratica(i, val):
    return a[i] + b[i] * (val - x[i]) + c[i] * ((val - x[i]) ** 2)


f = lambda x: 4 * np.sin(5 * x) - 3 * np.cos(1 * x) + 3.83 * x
f_deriv = lambda x: 20 * np.cos(5 * x) + 3 * np.sin(1 * x) + 3.83
left = -np.pi
right = np.pi
N = 173

x = np.linspace(left, right, N + 1)
y = f(x)

a, b, c = get_coeff()

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

y_spline = np.array([spline_patratica(intervNth[i], x_grafic[i]) for i in range(len(x_grafic))])

plt.figure('Interpolare cu functii spline patratice')
plt.plot(x_grafic, y_grafic, color="gold", label='Functia exacta')
plt.plot(x_grafic, y_spline, linestyle='--', color="red", label='Spline patratica')
plt.scatter(x, y, s=50, marker="x", label='Noduri de interpolare')
plt.title('Interpolare cu functii spline patratice')
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

