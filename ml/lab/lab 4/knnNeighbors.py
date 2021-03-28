import numpy as np
import os
import matplotlib.pyplot as plt
from sklearn.metrics import accuracy_score


class KnnClassifier:

    def __init__(self, train_images, train_labels):
        self.train_imgs = train_images# (1000, 784)
        self.train_labels = train_labels

    def cls_img(self, test_img, k = 3, metric = "l2"):

        # 1. Compute the distances
        if metric == "l2":
         distances = np.sqrt(np.sum((self.train_imgs - test_img) ** 2, axis=1))
        elif metric == "l1":
         distances = np.sum(abs(self.train_imgs - test_img), axis=1)
        else:
            print("Error!")
            exit()

        # print distances.shape
        # print np.min(distances)

        # 2. Sort the indexes of the distances
        inds_sorted = np.argsort(distances)
        # print dists[inds_sorted[0]]

        # 3. Get the first k neigh
        inds_sorted = inds_sorted[:k]
        # print inds_sorted

        # 4. Get the corresp labels
        nearest_lbls = self.train_labels[inds_sorted]  # [10, 11, 34]
        # print nearest_lbls # [2, 2, 7]

        # 5. Count the labels
        histc = np.bincount(nearest_lbls)
        # Nearest labels:  [3 3 3]
        # Neighbors count labels in common:  [0 0 0 3]

        return np.argmax(histc)

    def cls_imgs(self, test_imgs, k = 3, metric = "l2"):
        # 1. How many test imgs
        no_tst_imgs = test_imgs.shape[0]

        # 2. Initialize preds list
        pred_lbls = np.zeros((no_tst_imgs), np.int)

        # 3. For each img in the test set
        for i in range(no_tst_imgs):
            pred_lbls[i] = self.cls_img(test_imgs[i, :], k = k, metric = metric)

        return pred_lbls


tr_imgs = np.loadtxt('train_images.txt')
tr_labels = np.loadtxt('train_labels.txt')
tr_labels = tr_labels.astype(int)


tst_imgs = np.loadtxt('test_images.txt')
tst_labels = np.loadtxt('test_labels.txt')
tst_labels = tst_labels.astype(int)

# Instantiate the classifier
clf = KnnClassifier(tr_imgs, tr_labels)

# Classify test imgs
preds = clf.cls_imgs(tst_imgs, 3, "l2")
acc = accuracy_score(tst_labels, preds)
# print acc
np.savetxt("predictii_3nn_l2_mnist.txt", preds)

# Problema 4
# a)
neighs = [i for i in range(1, 10, 2)]
accs_l2 = np.zeros(len(neighs))

for n in range(len(neighs)):
  preds = clf.cls_imgs(tst_imgs, k = neighs[n], metric = "l2")
  accs_l2[n] = accuracy_score(tst_labels, preds)

np.savetxt("acc_l2.txt", accs_l2)


# b) use l1 as metric

neighs = [i for i in range(1, 10, 2)]
accs_l1 = np.zeros(len(neighs))

for n in range(len(neighs)):
  preds = clf.cls_imgs(tst_imgs, k = neighs[n], metric = "l1")
  accs_l1[n] = accuracy_score(tst_labels, preds)

np.savetxt("acc_l1.txt", accs_l1)

accs_l2 = np.loadtxt("acc_l2.txt")
accs_l1 = np.loadtxt("acc_l1.txt")
plt.plot(neighs, accs_l1)
plt.plot(neighs, accs_l2)
plt.gca().legend(("L1", "L2"))
plt.xlabel("K")
plt.ylabel("accuracy")
plt.show()
