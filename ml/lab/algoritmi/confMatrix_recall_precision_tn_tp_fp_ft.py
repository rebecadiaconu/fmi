from sklearn.metrics import confusion_matrix, f1_score, classification_report
from sklearn.metrics import recall_score, precision_score, accuracy_score

#y_true = ["cat", "ant", "cat", "cat", "ant", "bird"]
#y_pred = ["ant", "ant", "cat", "cat", "ant", "cat"]
#y_true = [0, 1, 1, 0, 1, 1, 0, 1]
#y_pred = [0, 1, 1, 0, 0, 1, 1, 0]

y_true = [1, 0,1,1,0,0,1,1]
y_pred = [1, 0,1,1,0,1,1,0]

conf_matrix = confusion_matrix(y_true, y_pred)
tn, fp, fn, tp = conf_matrix.ravel()
precision = tp/(tp+fp)
recall = tp/(tp+fn)
acc = accuracy_score(y_true,y_pred)

print("tn " + str(tn))
print("fp " + str(fp))
print("fn " + str(fn))
print("tp " + str(tp))

print("precision: " + str(precision))
print("recall: " + str(recall))
print("acc: " + str(acc))
print("f1: ", f1_score(y_true, y_pred))

