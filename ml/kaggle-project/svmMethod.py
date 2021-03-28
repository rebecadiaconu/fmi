import os
import numpy as np
import librosa
import librosa.display
import matplotlib.pyplot as plt
from sklearn import svm
from sklearn import preprocessing
from sklearn.metrics import confusion_matrix, classification_report


# functie pentru luarea datelor si extragerea de feature
# pentru fiecare fisier audio
def getData(path, fileN):
    trainPath = os.listdir(path=path)

    # lista features
    audio = []
    # lista nume fisiere audio
    names = []
    # lista labels fisiere audio
    labels = []
    # index for plotting the first 3 audio files
    index = 0

    with open(fileN) as fileName:
        for line in fileName:
            x = [x for x in line.strip().split(',')]
            names.append(x[0])
            if len(x) != 1:
                labels.append(int(x[1]))

            xToRead = trainPath[trainPath.index(x[0])]
            x, sampleRate = librosa.load(
                os.path.join(path, xToRead), sr=None)


            # ploting the first 3 audio files
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


# functie folosita pentru normalizarea si scalarea datelor
def normalizeData(trainfeatures, validFeatures, type=None):
    global scaler
    if type == 'min_max':
        scaler = preprocessing.MinMaxScaler()
    elif type == 'standard':
        scaler = preprocessing.StandardScaler()
    elif type == 'l1':
        scaler = preprocessing.Normalizer(norm='l1')
    elif type == 'l2':
        scaler = preprocessing.Normalizer(norm='l2')
    else:
        print("Incorrect type!")
        exit()

    # xToFit = np.concatenate((train_features, valid_features))
    scaler.fit(trainfeatures)
    scaler.fit(validFeatures)

    return scaler.transform(trainfeatures), scaler.transform(validFeatures)


# !!! datele de test, validation, train se descarca de pe kaggle

trainNames, trainLabels, trainFeatAudio = getData("./train/train/", 'train.txt')
validNames, validationLabels, validationFeatAudio = getData("./validation"
                                                            "/validation/", 'validation.txt')
testNames, testLbl, testFeatAudio = getData("./test/test", 'test.txt')

# datele de train, valid si test scalate si normalizate
scaledTr, scaledValid = normalizeData(trainFeatAudio, validationFeatAudio, 'standard')
scaledTr1, scaledTest = normalizeData(trainFeatAudio, testFeatAudio, 'standard')

# declararea modeluiui
svmModel = svm.SVC(C=10, kernel='rbf')
# antrenam modelul pe train data pentru validation
svmModel.fit(scaledTr, trainLabels)

# predictii pentru validation
preds = svmModel.predict(scaledValid)
preds.astype(int)

# antrenam modelul pe validation data pentru test
svmModel.fit(scaledValid, validationLabels)
# predictii pentru test
predsTest = svmModel.predict(scaledTest)
predsTest.astype(int)

np.savetxt('toValid.txt', preds)
np.savetxt('toTest.txt', predsTest)

# calculam acuratetea si f1_score pentru predictiile pe validation
# formam confusion_matrix pe datele de validation + plot
labels = ['0', '1']

confMat = confusion_matrix(validationLabels, preds)
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
print(classification_report(validationLabels, preds))


# formam fisierul pentru kaggle
file = open('toKaggle.txt', 'w+')
file.write("name,label\n")
for i in range(len(testNames)):
    file.write(f"{testNames[i]},{int(predsTest[i])}\n")

file.close()
