import librosa
import librosa.display
import os
import numpy as np
from sklearn.metrics import confusion_matrix, classification_report
import matplotlib.pyplot as plt


class KnnClassifier:

    def __init__(self, trainAudioFile, trainLabels):
        self.trainAudioFile = trainAudioFile
        self.trainLabels = trainLabels

    def classifyAudio(self, testAudio, numOfNeighbors=3, metric='l2'):
        global distances

        if metric == 'l2':
            distances = np.sqrt(np.sum((self.trainAudioFile - testAudio) ** 2, axis=1))
        elif metric == 'l1':
            distances = np.sum(abs(self.trainAudioFile - testAudio), axis=1)
        else:
            print('Error! Try another metric!')

        sortIndex = np.argsort(distances)
        sortIndex = sortIndex[:numOfNeighbors]

        nearestLabels = []
        for index in sortIndex:
            nearestLabels.append(self.trainLabels[index])

        hist = np.bincount(nearestLabels)

        return np.argmax(hist)

    def classifyAudios(self, testAudios, numOfNeighbors=3, metric='l1'):
        noOfTestFile = len(testAudios)
        preds = np.zeros(noOfTestFile, np.int)

        for i in range(noOfTestFile):
            preds[i] = self.classifyAudio(testAudios[i, :], numOfNeighbors=numOfNeighbors, metric=metric)

        return preds


def getData(path, file):
    trainPath = os.listdir(path=path)

    audio = []
    names = []
    labels = []
    index = 0

    with open(file) as fileName:
        for line in fileName:
            x = [x for x in line.strip().split(',')]
            names.append(x[0])
            if len(x) != 1:
                labels.append(int(x[1]))

            xToRead = trainPath[trainPath.index(x[0])]
            x, sampleRate = librosa.load(
                os.path.join(path, xToRead), sr=None)

            # ploting the first 3 sounds
            if index < 3:
                index += 1
                plt.figure()
                librosa.display.waveplot(y=x, sr=sampleRate)
                plt.xlabel("Time (in seconds) -->")
                plt.ylabel("<-- Amplitude " + xToRead + " -->")
                plt.show()

            featureArray = np.mean(librosa.feature.mfcc(x, sr=sampleRate, n_mfcc=50).T, axis=0)
            audio.append(featureArray)

    return names, labels, audio

trainNames, trainLabels, trainFeatAudio = getData("./train/train/", 'train.txt')
validNames, validationLabels, validationFeatAudio = getData("./validation"
                                                            "/validation/", 'validation.txt')
testNames, testLbl, testAudio = getData("./test/test", 'test.txt')

trainFeatAudio = np.array(trainFeatAudio)
validationFeatAudio = np.array(validationFeatAudio)
testAudio = np.array(testAudio)


clf = KnnClassifier(trainFeatAudio, trainLabels)
pred = clf.classifyAudios(validationFeatAudio, 5, "l1")

# formam confusion_matrix pe datele de validation + plot
labels = ['0', '1']

confMat = confusion_matrix(validationLabels, pred)
print(confMat)
fig = plt.figure()
ax = fig.add_subplot(111)
plt.title('Confusion matrix')
fig.colorbar(ax.matshow(confMat))
ax.set_xticklabels([''] + labels)
ax.set_yticklabels([''] + labels)
plt.xlabel('Predicted')
plt.ylabel('Validation')
plt.show()
print('Report : ')
print(classification_report(validationLabels, pred))

clfNew = KnnClassifier(np.concatenate((trainFeatAudio, validationFeatAudio)), np.concatenate((trainLabels, validationLabels)))
predTest = clf.classifyAudios(testAudio, 5, "l1")

# formam fisierul pentru kaggle
file = open('knnMethod.txt', 'w+')
file.write("name,label\n")
for i in range(len(testNames)):
    file.write(f"{testNames[i]},{int(predTest[i])}\n")

file.close()