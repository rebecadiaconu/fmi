# Laborator 2, LearnNumpy
import os

import numpy as np
from skimage import io

# Ex1
# a) Read images
path = "images"
fnames = os.listdir(path)
print(fnames)

images = np.zeros((len(fnames), 400, 600))
print(images)

for index in range(len(fnames)):
    # image = np.load("images/car_" + str(index) + ".npy")
    # sau
    image = np.load(os.path.join(path, fnames[index]))
    images[index] = image

print("----- a) -----\n",images.shape)

# b) suma imaginilor

S = np.sum(images)
print("----- b) -----\n",S)

# c) suma pixeli fiecare imagine

s_list = np.sum(images, axis=(1, 2))
print("----- c) -----\n",s_list)


# d) index suma maxima
ind_max = np.argmax(np.sum(images, axis=(1,2)))
print("----- d) -----\n",ind_max)


# e) img medie
meanImg = np.mean(images, axis=0)
io.imshow(meanImg.astype(np.uint8))
io.show()


# f) deviatia standard
stdDev = np.std(images)
print("----- f) -----\n", stdDev)


# g) normalize: subtract: images.shape = (9, 400, 600), mean_img = (400, 600)

normImgs = np.subtract(images, meanImg) / stdDev
print(normImgs)
for norm in normImgs:
    io.imshow(norm.astype(np.uint8))
    io.show()

# h) decupare imagini

cutImgs = images[:, 200:300, 280:400]
for cut in cutImgs:
    io.imshow(cut.astype(np.uint8))
    io.show()
