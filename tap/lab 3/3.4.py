import math

def findIndice1(mid, dist):
    i = mid - 1
    while i >= 0:
        if list[i][0] < (list[mid][0] - dist): return i
        else: i -= 1
    return 0

def findIndice2(mid, dist):
    i = mid + 1
    while i < len(list):
        if list[i][0] > (list[mid][0] + dist): return i
        else: i += 1
    return len(list1) - 1

def calcDist(p1, p2):
    return math.sqrt( ((p1[0]-p2[0])**2)+((p1[1]-p2[1])**2) )

def distInter(st, dr, distMin):
    i, j = findIndice1((st + dr) // 2, distMin), findIndice2(st + dr // 2, distMin)
    if i == st: return distMin
    if j == len(list1) - 1: return distMin
    if j - i > 7:
        for k in range(i, j + 1):
            for q in range(i + 1, i + 8):
                min = calcDist(list1[k], list1[q])
                if min < distMin:
                    distMin = min
    else:
        for k in range(i, j):
            for q in range(i + 1, j + 1):
                min = calcDist(list1[k], list1[q])
                if min < distMin:
                    distMin = min
    return distMin


def distance(distMin, st, dr):
    if dr - st == 1:
        if distMin < calcDist(list[st], list[dr]): return distMin
        else: return calcDist(list[st], list[dr])
    if dr - st == 2:
        d1 = calcDist(list[dr], list[st])
        d2 = calcDist(list[dr], list[dr - 1])
        d3 = calcDist(list[dr - 1], list[st])
        if d1 <= d2 and d1 <= d3 and d1 <= distMin: return d1
        if d2 <= d1 and d2 <= d3 and d2 <= distMin: return d2
        if d3 <= d1 and d3 <= d2 and d3 <= distMin: return d3
        return distMin
    mid = (st + dr) //2
    dist1 = distance(distMin, st, mid)
    dist2 = distance(distMin, mid + 1, dr)
    if dist1 <= distMin: distMin = dist1
    if dist2 <= distMin: distMin = dist2
    dist3 = distInter(st, dr, distMin)

    if dist3 <= distMin: return dist3
    return distMin

#main
f = open("date.in", "r+")
input = f.read().split()

mylist =[]
list =[]
with open("date.in") as f:
    for line in f:
        mylist = line.strip().split(' ')
        mylist = [int(i) for i in mylist]
        list.append(mylist)

list.sort(key = lambda list: list[0])
list1 = list[0:len(list)-1]
list1.sort(key = lambda list1: list1[1])

distMin = calcDist(list[0], list[1])
dist = distance(distMin, 0, len(list)-1)

print(dist)
