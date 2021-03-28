from sklearn import svm
from sklearn.metrics import accuracy_score, f1_score
from sklearn import preprocessing
import matplotlib.pyplot as plt
import numpy as np
import os


# Ex 2
def normalize(train_features, test_features, type=None):
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

    scaler.fit(train_features)
    scaled_train_feats = scaler.transform(train_features)
    scaled_test_feats = scaler.transform(test_features)

    return scaled_train_feats, scaled_test_feats


# Ex 3 & 4
class BagOfWords:

    def __init__(self):
        self.vocab = {}
        self.words = []
        self.vocab_len = 0

    def build_vocabulary(self, train_features):
        # step 1 -> iterate through docs from train_features
        # then through words in docs
        for doc in train_features:
            for word in doc:
                # step 2 -> add new words to the vocab
                if word not in self.vocab.keys():
                    self.vocab[word] = len(self.vocab)
                    self.words.append(word)

        # step 3 -> set vocab length
        self.vocab_len = len(self.words)

        # step 4 -> make the list of words np array
        self.words = np.array(self.words)

    def transform_features(self, features):
        features_nums = np.zeros((len(features), self.vocab_len))
        for doc_id, doc in enumerate(features):
            for word in doc:
                if word in self.vocab:
                    features_nums[doc_id, self.vocab[word]] += 1

        return features_nums


# Ex 5
path = "./data"
tr_sent = ['I like apples', 'I like tasty apples', 'Apples grow in trees']
# tr_labels = np.load(os.path.join(path, 'training_labels.npy'))
#
# tst_sent = np.load(os.path.join(path, 'test_sentences.npy'), allow_pickle=True)
# tst_labels = np.load(os.path.join(path, 'test_labels.npy'))

bow_model = BagOfWords()
bow_model.build_vocabulary(tr_sent)
print(bow_model.vocab_len)
#
# tr_feat_trans = bow_model.transform_features(tr_sent)
# tst_feat_trans = bow_model.transform_features(tst_sent)
#
# scaled_tr, scaled_tst = normalize(tr_feat_trans, tst_feat_trans, 'l2')
#
#
# # print(scaled_tr)
# # print(scaled_tst)
#
# # Ex 6
# def plotCoeff(classifier, feature_names, top_features=20):
#     coef = classifier.coef_.ravel()
#     top_positive_coefficients = np.argsort(coef)[-top_features:]
#     top_negative_coefficients = np.argsort(coef)[:top_features]
#     top_coefficients = np.hstack([top_negative_coefficients, top_positive_coefficients])
#
#     # create plot
#     plt.figure(figsize=(15, 5))
#     colors = ['red' if c < 0 else 'blue' for c in coef[top_coefficients]]
#     plt.bar(np.arange(2 * top_features), coef[top_coefficients], color=colors)
#     feature_names = np.array(feature_names)
#     plt.xticks(np.arange(1, 1 + 2 * top_features), feature_names[top_coefficients], rotation=60, ha='right')
#     plt.show()
#
#
# svm = svm.SVC(C=10, kernel='linear')
# svm.fit(scaled_tr, tr_labels)
# preds = svm.predict(scaled_tst)
# acc = accuracy_score(tst_labels, preds)
# print("Accuracy:", acc)
# scoreF1 = f1_score(tst_labels, preds)
# print("F1 Score: ", scoreF1)
# plotCoeff(svm, bow_model.words)