import numpy as np
import matplotlib.pyplot as plt


def f2(x, sigma):
    return 1/(sigma * np.sqrt(2 * np.pi)) * np.exp(-(x ** 2) / (2 * (sigma ** 2)))


def Integrare(f, x, metoda):
    interValue = 0
    h = x[1] - x[0]
    y = f(x, sigma)

    if metoda == 'dreptunghi':
        sumDreptunghi = np.sum(y[::2])
        interValue = 2 * h * sumDreptunghi

    elif metoda == 'trapez':
        sumTrapez = np.sum(y[1:-2])
        interValue = (h / 2) * (y[0] + 2 * sumTrapez + y[-1])

    elif metoda == 'Simpson':
        sumSimpson1 = np.sum(y[1:-1:2])
        sumSimpson2 = np.sum(y[2:-1:2])

        interValue = (h / 3) * (y[0] + 4 * sumSimpson1 + 2 * sumSimpson2 + y[-1])

    return interValue


a, b = -10, 10
sigma = 1.0

nInf = 3
nSup = 27
N = range(nInf, nSup, 2)

dreptValues = []
trapezValues = []
simpsonValues = []

for noSubInterv in N:
    x = np.linspace(a, b, noSubInterv)

    integrala1 = Integrare(f2, x, 'dreptunghi')
    integrala2 = Integrare(f2, x, 'trapez')
    integrala3 = Integrare(f2, x, 'Simpson')

    dreptValues.append(integrala1)
    trapezValues.append(integrala2)
    simpsonValues.append(integrala3)


plt.figure()
plt.title('Aproximarea valorii integralei folosind diferite formule de cuadratură')
plt.plot(N, dreptValues, label='Dreptunghi')
plt.plot(N, trapezValues, label='Trapez')
plt.plot(N, simpsonValues, label='Simpson')
plt.hlines([1], xmin=nInf, xmax=nSup - 1, linestyle='--', color='red')
plt.legend()
plt.show()