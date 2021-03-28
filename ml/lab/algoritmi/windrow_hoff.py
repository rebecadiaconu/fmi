import numpy as np
from sklearn.utils import shuffle
import matplotlib.pyplot as plt

x = [(0, 1), (0, 0), (-1, 0), (1, 1)]
x = np.array(x)
y = [-1, 1, 1, -1]
y = np.array(y)
epochs = 1
lr = 0.5


def compute_y(x, W, bias):
    # dreapta de decizie
    # [x, y] * [W[0], W[1]] + b = 0
    return (-x*W[0] - bias) / (W[1] + 1e-10)


def plot_decision_boundary(X, y, W, b, current_x, current_y):
    x1 = -0.5
    y1 = compute_y(x1, W, b)
    x2 = 0.5
    y2 = compute_y(x2, W, b)
    # sterge continutul ferestrei
    plt.clf()
    # ploteaza multimea de antrenare
    color = 'r'
    if current_y == -1:
        color = 'b'
    plt.ylim((-1, 2))
    plt.xlim((-1, 2))
    plt.plot(X[y == -1, 0], X[y == -1, 1], 'b+')
    plt.plot(X[y == 1, 0], X[y == 1, 1], 'r+')
    # ploteaza exemplul curent
    plt.plot(current_x[0], current_x[1], color+'s')
    # afisarea dreptei de decizie
    plt.plot([x1, x2], [y1, y2], 'black')
    plt.show(block=False)
    plt.pause(0.3)


def train(x, y, epochs, lr):
    # init weights
    w = np.zeros(2)
    b = 0

    # init train sz, acc
    train_size = x.shape[0]
    acc = 0.0

    # for each epoch
    for e in range(epochs):

        # daca e cu amestecare, decomentezi, daca e fara, lasi asa
        #x, y = shuffle(x, y)
        for i in range(train_size):
            y_hat = np.dot(x[i][:], w) + b
            err = (y[i] - y_hat)**2
            acc = (np.sign(np.dot(x, w) + b) == y).mean()
            #print(acc)
            w = w - lr*(y_hat - y[i])*x[i][:]

            b = b - lr*(y_hat - y[i])
            plot_decision_boundary(x, y, w, b, x[i][:], y[i])

    return w, b, acc


w, b, acc = train(x, y, epochs, lr)
print(w)
print(b)