import numpy as np
from skimage import io
import os

# a) -> citire imagini din folder

# varianta 1
fNames = os.listdir(path="C:/Users/Asus/Desktop/IA/ML/Lab/images/")
images = np.zeros((len(fNames), 400, 600))

for i in range(len(fNames)):
    image = np.load(os.path.join("C:/Users/Asus/Desktop/IA/ML/Lab/images/", fNames[i]))
    images[i] = image

# varianta 2
'''
images = np.zeros((9, 400, 600))
for index in range(9):
    image = np.load("C:/Users/Asus/Desktop/IA/ML/Lab/images/car_" + str(index) + ".npy")
    images[i] = image
'''

# verificam ca am citit imaginile corect
print(images.shape)

# b) -> returnati suma valorilor tuturor pixelilor
print("Suma tuturor pixelilor: ", np.sum(images))

# c) -> calculati suma valorilor pizelilor pentru fiecare imag in parte
sumArray = np.sum(images, axis=(1, 2))
print("Suma pixelilor per imagine: ", sumArray)

# d) -> afisati indexul imaginii cu suma maxima
print("Index imagine cu suma pixelilor maxima: ", np.argmax(sumArray))

# e) -> calculati imaginea medie si afisati-o

# calculam imaginea medie
meanImage = np.mean(images, axis = (0))
# afisam imaginea medie
io.imshow(meanImage.astype(np.uint8))   # pentru a putea fi afisata,
                                        # trebuie sa aiba tipul unsigned int
io.show()

# f) -> calculati deviatia standard a imaginilor cu np.std
print("Deviatia standard: ", np.std(images))

# g) -> normalizati imaginile (se scade media din fiecare si se imparte la devstd)
normImages = np.subtract(images, meanImage) / np.std(images)

for image in normImages:
    io.imshow(image.astype(np.uint8))
    io.show()

# h) -> decupeaza imaginile (liniile intre 200-300, col 280-400
cutImages = images[:, 200:301, 280:401]

for image in cutImages:
    io.imshow(image.astype(np.uint8))
    io.show()