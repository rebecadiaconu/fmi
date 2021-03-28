'''
What is the output of neural network with 3 hidden
units and 1 output unit having ReLU activations for
the input x = [1, -2], if the weights are W1 = [-0.5, 3, -2; 2, -1, 0],
 B1 = [0, 1, -1], W2 = [-1; -1; 2], B2 = [2]?
'''

import numpy as np

def relu(x):
    return np.maximum(x, 0)

x = np.array([1, 2])
W1 = np.array([[2, 3, 5], [-1, 2, -3]])
B1 = np.array([-1, 2, 3])

W2 = np.array([[2], [-2], [-1]])
B2 = np.array([5])


H1 = W1.T @ x + B1
H1 = relu(H1)

H2 = W2.T @ H1.T + B2
H2 = relu(H2)

print(-relu(23.04))

print(H2.item())

print('\n-------------\n')


'''
How many learned parameters (weights + biases) will a 
network with input size = 2, hidden layer size = 5, output layer size = 1, have?
'''

inpt_size = 3
hidden_layer_size = 5
output_size = 2

First_weight_matrix = inpt_size * hidden_layer_size
First_bias_vector= hidden_layer_size
Second_matrix= hidden_layer_size * output_size
Second_bias_vector= output_size
total= First_weight_matrix + First_bias_vector + Second_matrix + Second_bias_vector
print(total)