import numpy as np
import matplotlib.pyplot as plt

f = lambda x: np.cos(0.3 * x)
f_deriv = lambda x: -0.3 * np.sin(0.3 * x)

a = -np.pi / 2
b = np.pi
N = 39   # cel mai mic N a.i. eroarea maxima <= 1e-5

x = np.linspace(a, b, N + 1)

h = x[1] - x[0]
interiorNodes = x[1: -1]

y = f(interiorNodes)
y_plus = f(interiorNodes + h)
y_minus = f(interiorNodes - h)
deriv = f_deriv(interiorNodes)

regressive = (y - y_minus) / h
progressive = (y_plus - y) / h
central = (y_plus - y_minus) / (2 * h)


# plotam atat a doua derivata exacta, cat si pe cea aproximata de noi
plt.figure("Aproximarea primei derivate")
plt.title("Aproximarea primei derivate")
plt.plot(interiorNodes, deriv, c='red', label='A doua derivata exacta')
plt.plot(interiorNodes, regressive, label='Diferente finite regresive')
plt.plot(interiorNodes, progressive, label='Diferente finite progresive')
plt.plot(interiorNodes, central, label='Diferente finite centrale')
plt.legend()
plt.show()