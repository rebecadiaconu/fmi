import numpy as np
import matplotlib.pyplot as plt


def metoda_newton_raphson(f, f_deriv, x0, epsilon=1e-5):

    x_prev = x0

    x = x0 - f(x0) / f_deriv(x0)

    k = 1
    while (np.abs(x - x_prev) / np.abs(x_prev)) >= epsilon:
        x, x_prev = x - f(x) / f_deriv(x), x
        k += 1

    return x, k


f = lambda x: (x ** 3) - 7 * (x ** 2) + 14 * x - 6

df = lambda x: 3 * (x ** 2) - 14 * x + 14

if f(0) * f(5) >= 0:
    print('Functia nu admite radacina')
    exit(1)

s1, n1 = metoda_newton_raphson(f, df, 0.5)
s2, n2 = metoda_newton_raphson(f, df, 2.5)
s3, n3 = metoda_newton_raphson(f, df, 3.5)
print("Soluția", s1, "după", n1, "pași")
print("Soluția", s2, "după", n2, "pași")
print("Soluția", s3, "după", n3, "pași")


# plotam graficul functiei si solutiile
x = np.linspace(0, 5, 50)
y = f(x)

plt.figure('Metoda secantei')
plt.plot(x, y, linestyle='-', linewidth=3)
plt.legend(['f(x)', 'solution'])

# adaugam solutiile gasite
plt.scatter(s1, f(s1), s=50, c='red', marker='x')
plt.scatter(s2, f(s2), s=50, c='red', marker='x')
plt.scatter(s3, f(s3), s=50, c='red', marker='x')

# adaugam axele OX si OY si label pentru fiecare
plt.axvline(0, c='black')  # Adauga axa OY
plt.axhline(0, c='black')  # Adauga axa OX
plt.xlabel('x')
plt.ylabel('y')

# afisam titlul figurii
plt.title('x^3 - 2x^2 - x + 2')

# afisam graficul
plt.show()