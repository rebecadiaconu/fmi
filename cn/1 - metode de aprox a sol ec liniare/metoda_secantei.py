import numpy as np
import matplotlib.pyplot as plt


def metoda_secantei(f, a, b, x0, x1, epsilon=1e-5):
    global x_num
    x_prev = x1
    x_prev2 = x0

    k = 1
    while np.abs(x_prev - x_prev2) / np.abs(x_prev2) >= epsilon:
        x_num = (x_prev2 * f(x_prev) - x_prev * f(x_prev2)) / (f(x_prev) - f(x_prev2))
        x_prev, x_prev2 = x_num, x_prev
        k += 1

        if x_num < a or x_num > b:
            raise ValueError('Introduceti alte valori pentru x0 si x1')

    return x_num, k


f = lambda x: (x ** 3) - 7 * x + 6


a, b = -3, 3

if f(a) * f(b) >= 0:
    print('Functia nu admite radacina')
    exit(1)

r1, n1 = metoda_secantei(f, a, b, -3, -2.5)
print("Am găsit soluția", r1, "în", n1, "iterații")
r2, n2 = metoda_secantei(f, a, b, 0.5, 1.5)
print("Am găsit soluția", r2, "în", n2, "iterații")
r3, n3 = metoda_secantei(f, a, b, 1.5, 2.5)
print("Am găsit soluția", r3, "în", n3, "iterații")


# plotam graficul functiei si solutiile
x = np.linspace(a, b, 50)
y = f(x)

plt.figure('Metoda secantei')
plt.plot(x, y, linestyle='-', linewidth=3)
plt.legend(['f(x)', 'solution'])

# adaugam solutiile gasite
plt.scatter(r1, f(r1), s=50, c='red', marker='x')
plt.scatter(r2, f(r2), s=50, c='red', marker='x')
plt.scatter(r3, f(r3), s=50, c='red', marker='x')

# adaugam axele OX si OY si label pentru fiecare
plt.axvline(0, c='black')  # Adauga axa OY
plt.axhline(0, c='black')  # Adauga axa OX
plt.xlabel('x')
plt.ylabel('y')

# afisam titlul figurii
plt.title('x^3 - 2x^2 - x + 2')

# afisam graficul
plt.show()