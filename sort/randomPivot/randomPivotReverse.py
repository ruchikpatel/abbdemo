import sys
import random

n = sys.argv[1]
A = []

for item in range(int(n) ,0, -1):
    A.append(item)

print("Unsorted array: \n ", A)#Prints unsorted integers first

def partition(A,l,h):
    x = A[h]
    i = (l-1) 
    
    for j in range(l , h):
        if  A[j] <= x:
            i = i+1
            A[i],A[j] = A[j],A[i]
    
    A[i+1],A[h] = A[h],A[i+1]
    
    return (i+1)

def Randomized_Partition(A, l, h):
    i = (random.randint(l, h))
    A[h], A[i] = A[i], A[h]
    return partition(A,l,h)

def Randomized_quickSort(A, l, h):
    if l < h:
        q = Randomized_Partition(A, l, h)
        Randomized_quickSort(A, l, q-1)
        Randomized_quickSort(A, q+1, h)

print("\n\n\n")
Randomized_quickSort(A, 0,len(A)-1)
print("Sorted array: \n", A) #Prints sorted integers first