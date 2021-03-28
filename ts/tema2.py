#%%
import numpy as np

#%%
''''
    Diaconu Rebeca-Mihaela, Grupa 333
    Tema 2 Tehnici de Simulare, Problema 5
'''

#%%
'''
   1. Sa se genereze variabila Gama(0.5, 0.2, 6) folosind o infasuratoare exponentiala. 
'''

#%%
def init_uniform():
    U0 = np.random.uniform(0, 1)
    U1 = np.random.uniform(0, 1)
    K = 1

    return U0, U1, U0, K


#%%
def compute_x_exp():
    global X
    done = False
    N = 0

    while not done:
        U0, U1, U_star, K = init_uniform()

        while U0 >= U1:
            K += 1
            U0 = U1
            U1 = np.random.uniform(0, 1)

        if K % 2 == 1:
            X = N + U_star
            done = True

    return X

#%%
def gamma_metrics(v_alpha, v_lambda, v):
    gamma_mean = round(v_alpha + (v / v_lambda), 2)
    gamma_std = round(v / (v_lambda * v_lambda), 2)

    return gamma_mean, gamma_std

#%%
v_alpha = 0.5
v_lambda = 0.2
v = 6

gama_values = []

for _ in range(1000):
    X1 = compute_x_exp()
    X = X1 / (1 / v)
    Y = v_alpha + (X / v_lambda)

    gama_values.append(Y)

gamma1, gamma_std1 = gamma_metrics(v_alpha, v_lambda, v)

gamma2 = round(np.mean(gama_values), 2)
gamma_std2 = round(np.std(gama_values), 2)

print(f'Media de selectie: {gamma2}  VS  Media teoretica: {gamma1}')
print(f'Dispersia de selectie: {gamma_std2}  VS  Dispersia teoretica: {gamma_std1}')

#%%
'''
    2. Sa se genereze o variabila hipergeometrica cu parametrii cititi de la tastatura.
'''

#%%
def hipergeom_metrics(n, A, B):
    p = A / (A + B)
    N = A + B

    h_mean = n * p
    h_std = n * p * (1 - p) * (N - n) / (N - 1)

    return h_mean, h_std

#%%
def compute_x_hiper(A, B, n):
    global S
    N = A + B
    p = A / N
    j = 0
    X = 0

    while j < n:
        U = np.random.uniform(0, 1)

        if U < p:
            X += 1
            S = 1
        else:
            S = 0

        N -= 1
        A -= S
        p = A / N

        j += 1

    return X, p


#%%

A = int(input('\n Numar bile albe: '))
B = int(input('\n Numar bile negre: '))
n = int(input(('\n Numar extrageri bile din urna: ')))

hiper1, hiper_std1 = hipergeom_metrics(n, A, B)

hipergeom_values = []

for _ in range(1000):
    X = compute_x_hiper(A, B, n)
    hipergeom_values.append(X)

hiper2 = round(np.mean(hipergeom_values), 2)
hiper_std2 = round(np.std(hipergeom_values), 2)

print(f'Media de selectie: {hiper2}  VS  Media teoretica: {hiper1}')
print(f'Dispersia de selectie: {hiper_std2}  VS  Dispersia teoretica: {hiper_std1}')