# Repo Probabilitati si Statistica - An II


# Cerinta proiect
  
    1. Folosind setul de date  X  efectuaţi operaţii de statistică descriptivă pentru variabilele din acest 
    set de date(medie, varianţa, quartile, boxplot, interpretări). 
    
    2. Folosind setul de date X construiţi două modele de regresie(o regresie simplă şi una multiplă) alegând
    după cum consideraţi potrivite variabila răspuns şi respectiv variabilele predictor. 
    Adaugati la setul de date initial una sau mai multe variabile pe care sa le consideraţi potrivite a fi 
    incluse in cel puţin un model de regresie. Generaţi datele aferente variabilei nou adăugate conform unei 
    repartiţii potrivite( folosiţi funcţiile din R care ȋncep cu r: ex. pentru repartiţia normală rnorm). 
    Justificaţi alegerile făcute şi interpretaţi rezultatele obţinute ȋn urma evaluării celor două modele 
    de regresie. Care din cele două modele construite consideraţi că este mai potrivit pentru setul vostru
    de date? Daţi cel puţin două argumente pentru alegerea făcută.  

    3. Alegeţi o repartiţie diferită de cele studiate la laboratorul sau la cursul de Probabilităţi şi 
    Statistică şi construiţi ȋn două reprezentări alăturate funcţia de masă/densitatea de probabilitate
    (după cum e o repartiţie a unei variabile aleatoare discretă sau continuă) şi respectiv funcţia de 
    repartiţie. Indicaţi proprietăţile pe care le identificaţi la cele două funcţii şi precizaţi la ce 
    este folosită repartiţia respectivă ȋn practică( adică ce fel de fenomene poate modela).        
    
    
# Cerinta Bonus

     Fie două variabile aleatoare discrete X şi Y.
     
    a) Construiţi o funcţie frepcomgen care primeşte ca parametri m şi n şi care generează un tabel cu 
    repartiţia comună a v.a. X şi Y incompletă, dar ȋntr-o formă ȋn care poate fi completată ulterior. 
    
    #Observaţie: 
    Se cere la a) să generaţi valorile lui X, valorile lui Y şi suficient de multe valori
    pentru pi, qj şi respectiv 𝜋ij astfel ȋncât să poată fi determinată repartiţia comună a celor doua v.a. 
    
    #Nota:
    Ȋn construirea algoritmului puteţi ȋncepe de la cazul particular m=3 si n=2. Dacă reuşiţi să oferiţi 
    soluţia doar pentru acest caz particular, dar nu şi pentru cazul general veţi primi punctaj parţial.  
    
    b) Construiţi o funcţie fcomplrepcom care completează repartiţia comună generată la punctul anterior
    (pentru cazul particular sau pentru cazul general). Nota: Ȋn cazul ȋn care nu ştiţi să rezolvaţi punctul a) 
    puteţi construi o funcţie care să determine repartiţia comună pornind de la un exemplu discutat la seminar.
    
    c) Având la dispoziţie repartiţia comună a v.a. X şi Y de la punctul b) calculaţi: 
    1) Cov(5X,-3Y)
    2) P(0<X<3/Y>2) 
    3) P(X>6,Y<7) 
    
    d) Pentru exemplul obţinut la punctul b) construiţi două funcţii fverind şi respectiv fvernecor cu 
    ajutorul cărora să verificaţi dacă variabilele X şi Y sunt:
    1) independente 
    2) necorelate 
