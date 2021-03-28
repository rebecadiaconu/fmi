import numpy as np
import matplotlib.pyplot as plt
from sys import exit


# Construieste gridul asociat functiei
def gridDiscret(A, b):
    size = 50  # Numar de puncte pe fiecare axa
    x1 = np.linspace(-3, 4, size)  # Axa x1
    x2 = np.linspace(-4, 3, size)  # Axa x2
    X1, X2 = np.meshgrid(x1, x2)  # Creeaza un grid pe planul determinat de axele x1 si x2

    X3 = np.zeros((size, size))
    for i in range(size):
        for j in range(size):
            x = np.array(
                [X1[i, j], X2[i, j]])  # x e vectorul ce contine coordonatele unui punct din gridul definit mai sus
            X3[i, j] = .5 * x @ A @ x - x @ b  # Evaluam functia in punctul x

    return X1, X2, X3


# Construieste graficul functiei f
def graficFunctie(A, b):
    # Construieste gridul asociat functiei
    X1, X2, X3 = gridDiscret(A, b)

    # Defineste o figura 3D
    plt.figure()
    ax = plt.axes(projection="3d")

    # Construieste graficul functiei f folosind gridul discret X1, X2, X3=f(X1,X2)
    ax.plot_surface(X1, X2, X3, rstride=1, cstride=1, cmap='winter', edgecolor='none')

    # Etichete pe axe
    ax.set_xlabel('x1')
    ax.set_ylabel('x2')
    ax.set_zlabel('f(x1,x2)')

    # Titlu
    ax.set_title('Graficul functiei f');

    # Afiseaza figura
    plt.show()


# Reprezentam grafic aproximarea obtinuta
# la fiecare iteratie pentru fiecare metoda in parte
def aproximareIteratii(A, b, iterGradConjug, xMin):

    # Construim gridul asociat functiei f
    X1, X2, X3 = gridDiscret(A, b)

    # Plotam liniile de nivel ale functiei f
    plt.figure()
    gr = plt.contour(X1, X2, X3, levels=10)  # levels = numarul de linii de nivel
    plt.clabel(gr)

    # Plotam pasii algoritmului, pentru fiecare metoda in parte
    iteratii = np.array(iterGradConjug)
    plt.plot(iteratii[:, 0], iteratii[:, 1], marker='*', label='Pas descendent')


    # adaugam punctul de minim obtinut
    plt.scatter(xMin[0], xMin[1], s=50, c='red', marker='x', linewidth=3, label='Punct de minim')
    plt.title('Gradient conjugat')
    plt.legend()
    plt.show()


def pozitiv_definita(A):
    for i in range(A.shape[0]):
        if np.linalg.det(A[:i, :i]) < 1e-15:
            return False

    return True


def gradient_conjugat(A, b, x, epsilon=1e-5):
    steps = 0
    learning_rate = b - A @ x
    direction = learning_rate
    iterations = [x]

    while np.linalg.norm(learning_rate, ord=2) > epsilon:
        alpha = (direction.T @ learning_rate) / (direction.T @ A @ learning_rate)
        x = x - alpha * direction
        learning_rate = b - A @ x
        beta = (learning_rate.T @ A @ direction) / (direction.T @ A @ direction)
        direction = -learning_rate + beta * direction

        iterations.append(x)
        steps += 1

    return x, steps, iterations


# Avand
#       f(x, y) = 24.5x^2 - 28.0xy - 6x + 26.0y^2 + 7y
# si tinand cont de forma desfasurata pentru functiile cu doua variabile:
#       f(x, y) = a11/2 * x^2 + a12 * xy + a22/2 * y^2 - b1 * x - b2 * y,
# obtinem matricile A si b de forma:

A = np.array([[49.0, -28.0], [-28.0, 52.0]], dtype=float)
b = np.array([[6.0], [-7.0]])

if not (np.allclose(A, A.T, rtol=1e-05, atol=1e-08) and pozitiv_definita(A)):
    print('Matricea nu este simetrica sau pozitiv definita!')
    exit(1)

x0 = np.array([[-2.0], [1.0]])
x_min, k, steps = gradient_conjugat(A, b, x0)

print("Punct minim GRADIENT CONJUGAT: ")
print(x_min)
print("Numar iteratii: ", str(k))
print("\n")

graficFunctie(A, b)
aproximareIteratii(A, b, steps, x_min)