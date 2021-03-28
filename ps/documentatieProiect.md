# Probabilitati & Statistica
# Documentatie set de date „trees”

	Setul de date „trees” ofera masuratori pentru diametrul, inaltimea si volumul de cherestea a 31 de arbori. 
		Girth – diametrul arborelui, in inchi
		Height – inaltimea in ft
		Volume – volumul de cherestea in ft cubi

# Cerinta 1

    Extragem vectorii pentru fiecare dintre cele 3 masuratori si ii retinem in niste variabile pentru
    modelarea mai usoara pe viitor.
    
    Calculam media si varianta folosind functiile mean, respectiv var, care iau ca parametru masuratoarea specificata.
    Pentru a calcula quartilele avem nevoie sa sortam fiecare vector in parte, pentru a putea delimita valorile cele 
    mai mici de cele mai mari. Utilizam functiile sort si quantile. Valorile ¼, ½ si ¾ separa quartila in proportiile 
    necesare (25% - 75%, 50% - 50%, 75% - 25%).
    
    Boxplot-urile pentru fiecare dintre cele 3 masuratori:
      Girth – mediana = 12.9
      Height – mediana = 72
      Volume – mediana = 24.2
      
    → Interpretari:
    
    Putem observa uitandu-ne la boxplot-uri ca:
    In cazul inaltimii si a diametrului arborilor datele sunt distribuite aproape simetric, avand in vedere 
    ca cele doua jumatati ale dreptunghiului si whisker-ele sunt relativ egale, spre deosebire de volum, 
    unde dimensiunile par sa varieze de o parte si de alta a medianei.
    
    De asemenea, pentru cele 2 dimensiuni, inaltime si diametru, nu avem niciun outlier, respectiv outlier extrem.
    Pentru volum, avem in numar de 77 de outlier-ere si un outlier extrem, semn ca punctul  se afla la o 
    distanta mai mare decât 3 interquartile fata de laturile dreptunghiului.
 

# Cerinta 2

     La aceasta cerinta am avut de facut o regresie simpla, o regresie multima si sa adaugam la setul de date initial
     una sau mai multe variabile pe care sa le consideram potrivite a fi incluse in cel puţin un model de regresie.
     
     Pentru regresia simpla, am calculat AIC si BIC pentru orice posibilitate de combinare intre cele 3 masuratori si
     am obtinut pentru :
        diametru in functie de volum valorile AIC ≅ 55 si BIC ≅ 59
        diametru si inaltime AIC ≅ 115 si BIC ≅ 119
        
     Luand in considerare ca acestea erau cele mai mici doua valori, am facut regresia simpla pentru fiecare caz 
     in parte.
     Bineinteles ca am testat si cat de bun este modelul pentru setul de date dat, corelatia in cazul 1 fiind 
     de 0.9718764, lucru ce se poate observa si pe grafic, iar in cazul 2 de 0.5359649, fapt ce sugereaza ca 
     modelul generat nu este unul bun, majoritatea punctelor fiind mult prea indepartate pentru a putea trasa 
     o dreapta care sa le cuprinda pe toate. 
     
     Am ales sa facem 2 regresii multiple pentru a ilustra ambele posibilitati precizate anterior.

     Pentru regresia multipla nu am procedat la fel ca pentru cea simpla, alegand ce variabile sa luam in functie 
     de AIC si BIC, ci am cautat sa gasim o variabila dependenta de alte doua, independente intre ele. 
     Deci am ales sa luam volumul in functie de inaltime si diamentru, in orice alt caz cele doua variabile de 
     care ar depinde prima nu ar fi independente intre ele.
     
     Care dintre cele doua este mai buna si de ce?
     Pe general, noi am considerat ca regresia multipla este mai benefica, deoarece ia in considerare un set 
     mult mai mare de date independente ce afecteaza o variabila dependenta de acestea, deci in cazul setului de 
     date trees, putem spune ca este de preferat folosirea regresiei multiple. In principiu depinde de ce doreste 
     utilizatorul sa afle.

     Pentru generarea noii variabile am ales sa adaugam numarul de ramuri pe care le poate avea un arbore
     si am folosit functia runif, dupa care am facut o regresie simpla cu aceasta.

# Cerinta 3

     Am ales o repartitie Cauchy pentru a calcula si pentru a afisa graficele respective, folosind numarul de 
     masuratori ale volumului si a unei probabilitati alese, 1/3. 
     
     Pentru functia de masa si functia de distributie folosim functiile dcauchy si pcauchy. 
