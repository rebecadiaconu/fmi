#varianta 1, problema 1

def findElement(v, ind1, ind2):
    while(ind1 <= ind2):
        mid = (int)((ind1 + ind2)/2);
        if(v[mid] == mid): return mid
        if(v[mid] < mid): ind1 = mid + 1
        if(v[mid] > mid): ind2 = mid - 1

    return -1

f = open("date.in", "r+")
input = f.read().split()

n = int(input[0])
v = [None]*n
for i in range (n):
    v[i] = int(input[i+1])

if(findElement(v, 0, n) == -1):
    print("Nu exista niciun element in vector care sa respecte cerinta problemei. \n")
else:
    print("Exista un element in vector astept incat v[i] = i si aceste este: ", findElement(v, 0, n))