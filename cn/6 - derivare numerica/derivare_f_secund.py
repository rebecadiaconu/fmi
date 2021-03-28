import numpy as np
import matplotlib.pyplot as plt


f = lambda x: np.cos(0.3 * x)
f_deriv2 = lambda x: -0.09 * np.cos(0.3 * x)

a = -np.pi / 2
b = np.pi
N = 39   # cel mai mic N a.i. eroarea maxima <= 1e-5

x = np.linspace(a, b, N + 1)

h = x[1] - x[0]
interiorNodes = x[1: -1]

y = f(interiorNodes)
y_plusH = f(interiorNodes + h)
y_minusH = f(interiorNodes - h)

secondDeriv = f_deriv2(interiorNodes)
centralDiffs = (y_plusH - 2 * y + y_minusH) / h ** 2


# plotam atat a doua derivata exacta, cat si pe cea aproximata de noi
plt.figure("Aproximarea celei de-a doua derivate")
plt.title("Aproximarea derivatei")
plt.plot(interiorNodes, secondDeriv, c='red', label='A doua derivata exacta')
plt.plot(interiorNodes, centralDiffs, label='Diferente finite centrale')
plt.legend()
plt.show()

# calculam erorile de trunchiere + eroarea maxima
errors = np.abs(centralDiffs - secondDeriv)
maxError = np.max(errors)

plt.figure("Eroare de trunchiere aproximare derivata")
plt.title("Eroare de trunchiere aproximare derivata")
plt.plot(interiorNodes, errors, label='Diferente finite centrale')
plt.hlines([1e-5], xmin=a, xmax=b, color='red')
plt.legend()
plt.show()

print("Eroarea maxima: ", maxError)