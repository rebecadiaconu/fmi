# Documentatie Bonus

    a)	
    Trebuie construita o functie ce primeste parametrii n si m si genereaza un tabel cu repartitia 
    comuna a variabilelor aleatoare X si Y, incompleta, cu numarul minim de valori din tabel.
    
    - variabilele xi si yj, i=1,n, j=1,m sunt generate aleator in intervalul [-10,10] (ales de noi)
    - pentru a putea rezolva ulterior tabelul, avem nevoie de cel putin (n * m) - 1 elemente, dintre care 
    alegem un q si (m-1) p-uri (fig. 1)
    - ulterior adaugam pi-urile astfel: de la linia 1 pana la (n-1), pe coloanele de la 1 la (m-1)
    - adaugam si restul pi-urilor necesare pentru a completa numarul necesar de elemente in urmatorul mod:
    pe coloana m de pe linia 2 pana pe linia (n-1) 

    b)	
    Pentru a putea calcula folosim urmatorii pasi:
    - Se calculeaza mai intai termenul de pe prima linie, ultima coloana
    - Apoi p-ul de pe ultima coloana
    - Se calculeaza q-urile de pe liniile 2 – (n-1)
    - Se calculeaza pi-urile de pe coloanele 1 – (m+1) (inclusiv ultimul q)
    
    
    c)	
    Cu ajutorul functiilor din R se calculeaza: Cov(5X, -3Y), P(0<X<3/Y>2), P(X>6,Y<7)
    
    i) Cov(5X, -3Y)
      i.1) Daca n=m folosim formula covariantei din R (Cov(aX + bY, cX + dY)=a*c*Var(X) + (a*d + b*c) * Cov(X, Y) 
    + b*d*Var(Y) )
      i.2) Daca n!=m, conform fig.4, nu putem folosi formula si vom folosi Cov(aX + bY, cX + dY) = a*c*Var(X) + 
    (a*d + b*c) * Cov(X, Y) + b*d*Var(Y), unde Cov(X, Y) o calculam ca E(X*Y)-E(X)*E(Y)
    
    ii) P(0 < X < 3 / Y > 2) – am cautat valorile din tabel in care X este cuprins intre 0 si 3 si Y > 2, am facut 
    suma, pe care apoi am impartit-o la suma qj-urilor in care Y > 2
    iii) P(X > 6, Y < 7) – am cautat valorile din tabel in care X > 6 si Y < 7 si le adunam


    d)	
    Trebuie sa construim 2 functii ce verifica daca v.a X si Y sunt independente, necorelate:
    - Independente (verificam daca exista πij care sa nu fie egal cu produsul dintre pi si qj => 
    πij!= pi * qj => nu sunt independente)
    - Necorelate (verificam daca δ(x,y) este 0)
