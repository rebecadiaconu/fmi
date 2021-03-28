import numpy as np
import copy
import matplotlib.pyplot as plt


def get_coeff():
    a = copy.deepcopy(y)
    b = []
    for j in range(N):
        bj = (y[j + 1] - y[j]) / (x[j + 1] - x[j])
        b.append(bj)

    return a, b


def spline_liniara(i, val):
    return a[i] + b[i] * (val - x[i])


f = lambda x: 4 * np.sin(5 * x) - 3 * np.cos(1 * x) + 3.83 * x
left = -np.pi
right = np.pi
N = 173

x = np.linspace(left, right, N + 1)
y = f(x)

a, b = get_coeff()

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

y_spline = np.array([spline_liniara(intervNth[i], x_grafic[i]) for i in range(len(x_grafic))])

plt.figure('Interpolare cu functii spline liniare')
plt.plot(x_grafic, y_grafic, color="gold", label='Functia exacta')
plt.plot(x_grafic, y_spline, linestyle='--', color="red", label='Spline liniara')
plt.scatter(x, y, s=50, marker="x", label='Noduri de interpolare')
plt.title('Interpolare cu functii spline liniare')
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