import numpy as np
import matplotlib.pyplot as plt
import math


def metoda_bisectiei(f, a, b, epsilon=1e-5):
    f_a = f(a)
    f_b = f(b)

    assert f_a * f_b < 0, "functia nu are solutie pe intervalul curent"

    x_num = (a + b) / 2

    x_iterations = math.floor(np.log2((b - a) / epsilon) - 1) + 1

    for step in range(1, x_iterations):
        value = f(x_num)

        if value == 0:
            break
        elif f_a * value < 0:
            b = x_num
        else:
            a = x_num

        x_num = (a + b) / 2

    return x_num


f = lambda x: (x ** 3) - 7 * (x ** 2) + 14 * x - 6

if f(0) * f(5) >= 0:
    print('Functia nu admite radacina')
    exit(1)

a = metoda_bisectiei(f, 0, 1)
b = metoda_bisectiei(f, 1, 3.2)
c = metoda_bisectiei(f, 3.2, 4)
print(a)
print(b)
print(c)

# plotam graficul functiei si solutiile
x = np.linspace(0, 5, 50)
y = f(x)

plt.figure('Metoda secantei')
plt.plot(x, y, linestyle='-', linewidth=3)
plt.legend(['f(x)', 'solution'])

# adaugam solutiile gasite
plt.scatter(a, f(a), s=50, c='red', marker='x')
plt.scatter(b, f(b), s=50, c='red', marker='x')
plt.scatter(c, f(c), s=50, c='red', marker='x')

# adaugam axele OX si OY si label pentru fiecare
plt.axvline(0, c='black')  # Adauga axa OY
plt.axhline(0, c='black')  # Adauga axa OX
plt.xlabel('x')
plt.ylabel('y')

# afisam titlul figurii
plt.title('x^3 - 2x^2 - x + 2')

# afisam graficul
plt.show()
