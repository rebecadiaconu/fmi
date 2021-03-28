import numpy as np

'''
What is the output of the perceptron if input=[2.4, 3.0], 
weights=[-0.5, 0.2], bias=1.0 (activation function - sign)?
'''

# weights * input + bias = [-0.5, 0.2] * [[2.4], [3.0]] + 1.0
# = -0.5 * 2.4 + 0.2 * 3.0 + 1
# = -1.2 + 0.6 + 1 = 0.4
def sigmoid(X):
   return 1/(1+np.exp(-X))

weights = np.asarray([0.5, 0.2])
inpt = np.asarray([2.4, 3.0])
bias = 1.0
output = np.sum(inpt*weights) + bias

print("output: ", output)
print(sigmoid(output))


print('----------------------')

'''
If the current weights of a perceptron are [0.2, 0.4],
their gradients are=[-2.4, -1.2], and the learning rate is 0.1.
 What are the weights after the weights update operation?
'''

# W_nou = W - learning_rate * gradients
curentWeights = [0.2, 0.4]
gradients = [-2.4, -1.2]
lr = 0.1

newWeights = []
for i in range(len(curentWeights)):
  newWeights.append(curentWeights[i]-lr*gradients[i])

print(newWeights)

'''
Care sunt punctele in care dreapta 
de separare a percetronului w = [-4, 2], b = [2] intersecteaza axele?
'''
# pentru a ti da a doua coordonata a punctului, o bagi pe prima la X, rulezi
# si ti o returneaza pe a doua
# ex: pentru x = 0 da -1 -> (0,-1)


def f(x, w, b, c=0):
    # given x1, return x2 such that [x1,x2] are on the line w.x + b = c
    return (-w[0] * x - b + c) / w[1]

w = [-4,2]
b = 2
x = 0.5

print(f(x,w,b))