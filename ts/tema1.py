import numpy as np


'''
    Imagine a floor marked with an infinite number of parallel, equidistant lines, a width 
    ℓ apart.
    We now toss a needle of length L < ℓ onto the floor, where it lands at a uniform random position
    and with a uniform random orientation. Buffon’s needle problem is to determine the probability
    that the needle intersects one of the lines on the floor. The probability depends on the ratio
    of the length of the needle, L, to the distance between the lines on the floor, ℓ.
'''


#  functie ce imi genereaza automat coordonatele pentru aruncarea acului:
# x - punctul unde mijlocul acului atinge podeaua
# theta - unghiul pe care acesta il face cu axa verticala din x
def toss_needle():
    x = np.random.uniform(0, floor_len)
    theta = np.random.uniform(0, np.pi)

    return x, theta


# verificam daca acul a intersectat una dintre liniile de pe podea
def cross_line():
    x, theta = toss_needle()
    hit_right = x + ((needle_len / 2.0) * np.sin(theta))
    hit_left = x - ((needle_len / 2.0) * np.sin(theta))

    return hit_right > floor_len or hit_left < 0.0


# pentru un anumit numar de ace, calculam probabilitatea ca unul din ele sa intersecteze una din liniile de pe podea
def estimate_prob_needle_crosses_line():
    crosses = 0

    for i in range(no_tosses):
        if cross_line():
            crosses += 1

    return (crosses / no_tosses) * 100.0


no_tosses = 1000
floor_len = 2
needle_len = 2

print("Probabilitatea ca un ac din cele date sa intersecteze una din liniile verticale este: ", np.round(estimate_prob_needle_crosses_line(), 2), "% .")
