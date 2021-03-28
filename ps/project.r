
# trees contine 31 de randuri si 3 coloane, respectiv pentru grosime, inaltime si volum

# Extragem datele in alte variabile pentru lucru
vectGirth <- c(trees$Girth)
vectHeight <- c(trees$Height)
vectVolume <- c(trees$Volume)

# Exercitiul 1
# Calculam urmatoarele:

# ---- media ----
meanGirth <- mean(vectGirth)
meanHeight <- mean(vectHeight)
meanVolume <- mean(vectVolume)

# ---- varianta ----
varGirth <- var(vectGirth)
varHeight <- var(vectHeight)
varVolume <- var(vectVolume)

# ---- quartile Q1, Q2, Q3 ----
# Q1( "lower quartile") - imparte cele mai mici 25% de celelalte 75%
# Q2( "median") - imparte dataset-ul in jumatate
# Q3( "upper quartile") - imparte cele mai mari 25% de celelalte 75%
# Sortam valorile pentru a face quartilele.

sortedG <- sort(vectGirth)
sortedH <- sort(vectHeight)
sortedV <- sort(vectVolume)

Q1girth <- quantile(sortedG, 1/4)
Q1height <- quantile(sortedH, 1/4)
Q1volume <- quantile(sortedV, 1/4)

Q2girth <- quantile(sortedG, 1/2)
Q2height <- quantile(sortedH, 1/2)
Q2volume <- quantile(sortedV, 1/2)

Q3girth <- quantile(sortedG, 3/4)
Q3height <- quantile(sortedH, 3/4)
Q3volume <- quantile(sortedV, 3/4)

# ---- boxplot ----

par(mfrow = c(2, 3))

boxplot(vectGirth, main = "Girth", col = (c("lightpink")), notch = FALSE, sub = paste("Outlier rows: ", boxplot.stats(vectGirth)$out))
boxplot(vectHeight, main = "Height", col = (c("lightgreen")), notch = FALSE, sub = paste("Outlier rows: ", boxplot.stats(vectHeight)$out))
boxplot(vectVolume, main = "Volume", col = (c("lightblue")), notch = FALSE, sub = paste("Outlier rows: ", boxplot.stats(vectVolume)$out))


# Exercitiul 2
# modele de regresie: simpla si multipla

# ---- simpla ----

# diametru si inaltime
set.seed(100) 
trainingRowIndex <- sample(1:nrow(trees), 0.8*nrow(trees))  # row indices for training data
trainingData <- trees[trainingRowIndex, ]  # model training data
testData  <- trees[-trainingRowIndex, ]   # test data

lmMod <- lm(Girth ~ Height, data=trainingData)  # build the model
GirthPred <- predict(lmMod, testData)  # predict Heightance
summary (lmMod) 
actuals_preds <- data.frame(cbind(actuals=testData$Girth, predicteds=GirthPred))  # make actuals_predicteds dataframe.
correlation_accuracy <- cor(actuals_preds)  # 0.5359649
plot(trees$Girth, trees$Height, main = "Simple Linear - Model Girth ~ Height")
b1 <- sum((trees$Girth-mean(trees$Girth))*(trees$Height-mean(trees$Height)))/sum((trees$Girth - mean(trees$Girth))^2)
a1 <- mean(trees$Height)-b1*mean(trees$Girth)
abline(a1, b1, col = "magenta")


# diametru si volum
set.seed(100) 
trainingRowIndex2 <- sample(1:nrow(trees), 0.8*nrow(trees))  # row indices for training data
trainingData2 <- trees[trainingRowIndex2, ]  # model training data
testData2  <- trees[-trainingRowIndex2, ]   # test data

lmMod2 <- lm(Girth ~ Volume, data=trainingData2)  # build the model
GirthPred2 <- predict(lmMod2, testData2)  # predict Heightance
summary (lmMod2) 
actuals_predss <- data.frame(cbind(actuals=testData2$Girth, predicteds=GirthPred2))  # make actuals_predicteds dataframe.
correlation_accuracy2 <- cor(actuals_predss)  # 0.9718764
plot(trees$Girth, trees$Volume, main = "Simple Linear - Model Girth ~ Volume")
b2 <- sum((trees$Girth-mean(trees$Girth))*(trees$Volume-mean(trees$Volume)))/sum((trees$Girth - mean(trees$Girth))^2)
a2 <- mean(trees$Volume)-b2*mean(trees$Girth)
abline(a2, b2, col = "blue")

# ---- Variabila noua pentru acest set de date ----
trees$Branches = runif(31, 20, 50)
print(trees)

# Regresie simpla cu noua variabila
lmModNou <- lm(trees$Girth ~ trees$Branch, data = trees)
plot(trees$Girth ~ trees$Branch)
abline(lmModNou, col = "darkgreen")
summary(lmModNou)


# ---- multipla ----

# volum in functie de inaltime si diametru
set.seed(100) 
trainingRowIndexM <- sample(1:nrow(trees), 0.8*nrow(trees))  # row indices for training data
trainingDataM <- trees[trainingRowIndexM, ]  # model training data
testDataM  <- trees[-trainingRowIndexM, ]  # test data

multipleLinearMod <- lm(Volume ~ Height + Girth, data = trainingDataM)
print(multipleLinearMod)
summary(multipleLinearMod)
layout(matrix(c(1, 2, 3, 4), 2, 2))  # 4 graphs/page
plot(multipleLinearMod)


# Exercitiul 3
# ---- Repartitie Cauchy ----

# Distributia Cauchy

par(mfrow=c(1,2))

p <- (1/3) # probabilitate aleasa de noi
#size <- length(vectVolume)

#mass function
plot(vectVolume, dcauchy(vectVolume, location = 0, scale=1, p), col="red", main="Mass function", xlab="Volume", ylab="Probability")

#distribution function
plot(vectVolume, pcauchy(vectVolume, location = 0, scale=1, lower.tail = TRUE,  p), col="blue", main="Distribution function", xlab="Volume", ylab="Distribution")

