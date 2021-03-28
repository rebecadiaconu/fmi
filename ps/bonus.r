#bonus

#dam valori pentru dimensiunile X si Y
n <- 3 #dimensiunea lui X
m <- 4 #dimensiunea lui Y

frepcomgen = function(n, m) {
  mat <- matrix(0, n + 2, m + 2)
  mat[n + 2, m + 2] <- 1 #punem in colt dreapta jos 1
  
  #generam pe prima linie valori pentru yi
  tempY <- runif(m, -10, 10)
  tempY <- sort(tempY)
  for (c in 2:(ncol(mat) - 1))
  {
    mat[1, c] <- round(tempY[c-1], 3)
  }
  #generam pe prima col valori pentru xi
  tempX <- runif(n, -10, 10)
  tempX <- sort(tempX)
  for (r in 2:(nrow(mat) - 1))
  {
    mat[r, 1] <- round(tempX[r-1], 3)
  }
  
  mat[2, m + 2] <- round(runif(1, 0.0, 1.0), 3) #generam primul q
  
  mat[n + 2, 2] <- round(runif(1, 0.0, 1.0), 3) #generez primul p
  s <- mat[n + 2, 2]
  for (c in 3:(ncol(mat) - 2))
    #generez p(m-1) valori si le pun pe ultima linie
  {
    mat[n + 2, c] <- round(runif(1, 0.0, 1.0 - s), 3)
    s <- s + mat[n + 2, c]
    if (s > 1)
    {
      s <- s - mat[n + 2, c]
      c <- c - 1
    }
  }
  
  #generez prima linie de pi-uri. Vor fi m-1 pi-uri generate
  s <- 0
  for (c in 2:(ncol(mat) - 2))
  {
    mat[2, c] <- round(runif(1, 0.0, min(mat[n + 2, c], (mat[2, m + 2] - s))), 3)
    s <- s + mat[2, c]
    if (s > mat[2, m + 2])
    {
      s <- s - mat[2, m + 2]
      c <- c - 1
    }
  }
  
  for (r in 3:(nrow(mat) - 2))
  {
    for (c in 2:(ncol(mat) - 2))
    {
      s <- 0
      for (i in 2:(r - 1))
      {
        s <- s + mat[i, c]
      }
      mat[r, c] <-round(runif(1, 0.0, mat[n + 2, c] - s), 3)
      s <- s + mat[r, c]
      if (s > mat[n + 2, c])
      {
        s <- s - mat[r, c]
        c <- c - 1
      }
    }
  }
  #adaugam in continuare pi-uri pentru a ajunge la nr necesar(n*m-1)
  #de pe ultima coloana incepand cu linia a doua, pana la linia n-1
  sp <- 0
  for (c in 2:(ncol(mat) - 2))
    sp <- sp + mat[n + 2, c]
  
  for (r in 3:(nrow(mat) - 2))
  {
    s <- 0
    for (c in 2:(ncol(mat) - 2))
      s <- s + mat[r, c]
    mat[r, m + 1] <- round(runif(1, 0.0, (1.0 - s - mat[2, m + 2]) / (n)), 3)
    s <- s + mat[r, m + 1]
    while ((s + mat[2, m + 2]) >= 1)
    {
      s <- s - mat[r, m + 1]
      mat[r, m + 1] <-
        round(runif(1, 0.0,(1.0 - s - mat[2, m + 2]) / (n) ), 3)
      s <- s + mat[r, m + 1]
    }
    
  }
  return(mat)
  
}

#stochez repartitia comuna generata
incMat <- frepcomgen(n, m)
print(incMat)

#transmitem repartitia comuna generata si nr elem din x si din y
fcomplrepcom = function(incMat, n, m) {
  #completez valoarea lipsa de pe prima linie a pi-urilor
  for (c in 2:(ncol(incMat) - 2))
    incMat[2, m + 1] <- incMat[2, m + 1] + incMat[2, c]
  incMat[2, m + 1] <- incMat[2, m + 2] - incMat[2, m + 1]
  #completez valoarea lipsa de pe linia p-urilor
  for (c in 2:(ncol(incMat) - 2))
    incMat[n + 2, m + 1] <- incMat[n + 2, m + 1] + incMat[n + 2, c]
  incMat[n + 2, m + 1] <- incMat[n + 2, m + 2] - incMat[n + 2, m + 1]
  
  for (r in 3:(nrow(incMat) - 2))
  {
    for (c in 2:(ncol(incMat) - 1))
      incMat[r, m + 2] <- incMat[r, m + 2] + incMat[r, c]
  }
  
  for (c in 2:(ncol(incMat)))
  {
    for (r in 2:(nrow(incMat) - 2))
      incMat[n + 1, c] <- incMat[n + 1, c] + incMat[r, c]
    incMat[n + 1, c] <- incMat[n + 2, c] - incMat[n + 1, c]
  }
  return(incMat)
}

completeMat <- fcomplrepcom(incMat, n, m)
print(completeMat)

#Cov(5X, -3Y)=-15*cov(X, Y)
x <- completeMat[1:(n+1), 1]
y <- completeMat[1, 1:(m + 1)]
if(n==m)
  print(-15 * cov(x, y))
if(n!=m)
  print(-15*(mean(x*y)-(mean(x)*mean(y))))

#P(0<X<3/Y>2) = P(0<X<3,Y>2)/P(Y>2)
s <- 0
sy <- 0
for(i in 2:(n+1))
{
  if(completeMat[i, 1]>0 && completeMat[i,1]<3)
    for(j in 2:(m+1))
    {
      if(completeMat[1,j]>2)
        s <- s+ completeMat[i,j]
    }
}
for(j in 2:(m+1))
{
  if(completeMat[1,j]>2)
    sy <- sy + completeMat[n+2,j]
}
print(s/sy)

#P(X>6, Y<7)
s <- 0
for(i in 2:(n+1))
{
  if(completeMat[i, 1]>6)
    for(j in 2:(m+1))
    {
      if(completeMat[1,j]<7)
        s <- s+ completeMat[i,j]
    }
}
print(s)

#verificam daca X si Y sunt independente verificand daca PIij=pi*qj pentru 0<i<m+2 si 0<j<n+2
fverind = function(completeMat, n, m)
{
  ok = 1 #presupunem ca sunt independente
  for (r in 2:nrow(completeMat) - 1)
  {
    for (c in 2:ncol(completeMat) - 1)
      if (ok != 0)
        if (completeMat[r, c] != (completeMat[r, m + 2] * completeMat[n + 2, c]))
          #daca cel putin un produs nu este egal, atunci X si Y nu sunt independente
          ok = 0
  }
  return (ok)
}

ind <- fverind(completeMat, n, m)

if (ind == 1)
  print("Sunt independente")

if (ind == 0)
  print("Nu sunt independente")



fvernecor = function(completeMat, n, m)
{
  if(n==m)
  {
    if (cov(completeMat[1:(n + 1), 1], completeMat[1, 1:(m + 1)]) == 0)
      print("Variabile necorelate")
  
    if (cov(completeMat[1:(n + 1), 1], completeMat[1, 1:(m + 1)]) != 0)
      print("Variabile corelate")
  }
  else
  {
    covar <- mean(completeMat[1:(n + 1), 1]*completeMat[1, 1:(m + 1)])-(mean(completeMat[1:(n + 1), 1])*mean(completeMat[1, 1:(m + 1)]))
    if (covar == 0)
      print("Variabile necorelate")
    
    if (covar != 0)
      print("Variabile corelate")
  }
    
}

fvernecor(completeMat, n, m)
