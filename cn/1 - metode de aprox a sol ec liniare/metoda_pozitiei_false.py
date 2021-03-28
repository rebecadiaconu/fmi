import numpy as np
import matplotlib.pyplot as plt


def metoda_pozitiei_false(f, a, b, epsilon=1e-5):
    f_a = f(a)
    f_b = f(b)
    x_prev = (a * f_b - b * f_a) / (f_b - f_a)
    f_prev = f(x_prev)

    x_num = x_prev

    k = 1
    while True:
        if f_prev == 0:
            break
        elif f_a * f_prev < 0:
            b = x_prev
        elif f_a * f_prev > 0:
            a = x_prev

        f_a = f(a)
        f_b = f(b)
        x_num = (a * f_b - b * f_a) / (f_b - f_a)

        if np.abs(x_num - x_prev) / np.abs(x_prev) < epsilon:
            break

        f_x = f(x_num)
        x_prev, f_prev = x_num, f_x
        k += 1

    return x_num, k


f = lambda x: (x ** 3) - 19 * x + 30

if f(-5) * f(5) >= 0:
    print('Functia nu admite radacina')
    exit(1)

r1, n1 = metoda_pozitiei_false(f, -6, -4)
print("Am găsit soluția", r1, "în", n1, "iterații")
r2, n2 = metoda_pozitiei_false(f, 1, 2.5)
print("Am găsit soluția", r2, "în", n2, "iterații")
r3, n3 = metoda_pozitiei_false(f, 2.5, 4)
print("Am găsit soluția", r3, "în", n3, "iterații")


# plotam graficul functiei si solutiile
x = np.linspace(-5, 5, 50)
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