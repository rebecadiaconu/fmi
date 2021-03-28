# LOSS FUNCTIONS

import numpy as np
from sklearn.metrics import mean_absolute_error
from sklearn.metrics import mean_squared_error
from sklearn.metrics import mean_squared_log_error


# regresion fara bias
y_true = [100, -25, 0.5]
y_pred = [101, -23, 0]
print("mse: ", mean_squared_error(y_true, y_pred))
print("mae: ", mean_absolute_error(y_true, y_pred))

y_true = [3, 5, 2.5, 7]
y_pred = [2.5, 5, 4, 8]
print("msLoge: ", mean_squared_log_error(y_true, y_pred))


# binary cross entropy
def cross_entropy(predictions, targets):
    N = predictions.shape[0]
    ce = -np.sum(targets * np.log(predictions)) / N
    return ce


predictions = np.array([[0.25, 0.25, 0.25, 0.25]])
targets = np.array([[1, 0, 0, 0]])

print("cross entropy: ", cross_entropy(predictions, targets))
