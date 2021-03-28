import numpy as np
from numpy.linalg import norm
import sklearn.preprocessing as preprocessing


a = np.array([10, 20, 30])
print(a)
l = norm(a, 1)        # 1 pt L1, 2 pt L2
print(l)

result = np.divide(a, l)
print(result)

print("\n------------\n")

def normalize(train_data, type=None):
    if type is None:
        return train_data
    elif type == 'standard':
        scaler = preprocessing.StandardScaler()
        scaler.fit(train_data)
        return scaler.transform(train_data)
    elif type == 'min-max':
        scaler = preprocessing.MinMaxScaler()
        scaler.fit(train_data)
        return scaler.transform(train_data)
    elif type == 'l1' or type == 'l2':
        scaler = preprocessing.Normalizer(type)
        scaler.fit(train_data)
        return scaler.transform(train_data)


data = [[4,2,3,-1]]
print(normalize(data, 'standard'))