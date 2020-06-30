import sys
import random
sys.setrecursionlimit(19999)

n = sys.argv[1]
A = []

for item in range(int(n) ,0, -1):
    A.append(item)

print("Unsorted array: \n ", A)#Prints unsorted integers first

def partition(A,l,h):     
    x = A[h]
    i = (l-1 ) 

    for j in range(l , h):
        if  A[j] <= x:
            i = i+1
            A[i],A[j] = A[j],A[i]#EXCHANGE
 
    A[i+1],A[h] = A[h],A[i+1]
    return (i+1)

def quickSort(A,l,h):
    if l < h:
        p = partition(A,l,h)
        quickSort(A, l, p-1)
        quickSort(A, p+1, h)


print("\n\n\n")
quickSort(A, 0 , len(A)-1)
print("Sorted array: \n", A) #Prints sorted integers first
 
