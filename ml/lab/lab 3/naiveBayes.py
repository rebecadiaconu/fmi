import matplotlib.pyplot as plt
import numpy as np
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import confusion_matrix

# incarcam imaginile de training si label-urile corespunzatoare
trainImages = np.loadtxt('train_images.txt')
trainLabels = np.loadtxt('train_labels.txt')
trainLabels.astype(int)

# incarcam imaginile de test si label-urile corespunzatoare
testImages = np.loadtxt('test_images.txt')
testLabels = np.loadtxt('test_labels.txt')
testLabels.astype(int)


maxValue = 255
minValue = 0
numBins = 10


# Ex 2
def vals2bins(x, start, stop, numBins):
    bins = np.linspace(start, stop, numBins)
    x = np.digitize(x, bins)

    return x - 1


# Ex 3
xToTrain = vals2bins(trainImages, minValue, maxValue, 5)
xToTest = vals2bins(testImages, minValue, maxValue, 5)

clasifier = MultinomialNB()
clasifier.fit(xToTrain, trainLabels)
accuracy = clasifier.score(xToTest, testLabels)
print("Ex 3")
print("Accuracy: ", accuracy)


# Ex 4
noOfBinsList = [3, 5, 7, 9, 11]
bestClf = 0
bestNoOfBins = 0
bestAcc = -1

print("\nEx 4")
for noOfBins in noOfBinsList:
    trainInterv = vals2bins(trainImages, minValue, maxValue, noOfBins)
    testInterv = vals2bins(testImages, minValue, maxValue, noOfBins)

    clasifier.fit(trainInterv, trainLabels)
    acc = clasifier.score(testInterv, testLabels)
    print("Pentru noOfBins = " + str(noOfBins) + ": " + str(acc))

    if acc > bestAcc:
        bestClf = clasifier
        bestNoOfBins = noOfBins

# Ex 5
preds = bestClf.predict(xToTest)
misclasified = np.where(preds != testLabels)[0]

for i in range(10):
    image = testImages[misclasified[i], :]
    image = np.reshape(image, (28, 28))

    plt.imshow(image.astype(np.uint8), cmap='gray')
    plt.title('prediction = %d' % preds[misclasified[i]])
    plt.show()

# Ex 6
print("\nEx 6")
print(confusion_matrix(testLabels, preds))
