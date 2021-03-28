from sklearn.neighbors import KNeighborsClassifier
import numpy as np
from sklearn.neighbors import DistanceMetric
from sklearn.metrics import accuracy_score

dist = DistanceMetric.get_metric('manhattan')

X = np.asarray([[1, 4, 2], [5, 4, 8], [2, 6, 5], [1, 1, 1], [2, 9, 6]])
y = np.asarray([2, 3, 3, 1, 2])

neigh = KNeighborsClassifier(n_neighbors=3)
neigh.fit(X, y)

X_test = np.asarray([[5,3,8]])
print(neigh.predict(X_test))

print('-----------------')

from sklearn.neighbors import KNeighborsClassifier
model = KNeighborsClassifier(n_neighbors=1, metric='l2')
X = [[1, 4, 1], [5, 4, 8], [2, 6, 5], [1, 1, 1], [2, 9, 6]]
Y = [1, 1, 1, 0, 0]
to_pred = [[1,22,1]]
model.fit(X, Y)
pred = model.predict(to_pred)
print(pred)


print(' ---------------- ')
print('date de train si date de test')
# de modificat sus!!

X_train = [[1,3], [2,1], [3,1], [2,-1], [-1,0], [-1,2]]
Y_train = [1,1,1,-1,-1,-1]
X_test = [[1,1], [2,-1], [1,3], [-1,-1]]
Y_test = [1,1,-1,-1]

model.fit(X_train, Y_train)
pred = model.predict(X_test)
print(accuracy_score(Y_test, pred))