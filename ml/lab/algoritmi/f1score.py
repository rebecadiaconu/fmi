from sklearn.metrics import f1_score, accuracy_score

y_true = [8, 7, 4, 1, 0, 6, 3, 2]
y_pred = [5, 6, 6, 1, 0, 2, 2, 1]

print("acc:", accuracy_score(y_true,y_pred))
print("f1: ", f1_score(y_true, y_pred))