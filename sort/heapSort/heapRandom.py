import sys
import math
import random

n= sys.argv[1]
A = []

A.append('')  # Removing that first element
for item in range(0,int(n)):
    A.append(random.randint(1,1000))

def Max_Heapify(A, i,size):
    l = 2 * i
    r =  2 * i+ 1
 
    if l <= size and A[l] > A[i]:
        largest = l
    else:
        largest = i
    if r <= size and A[r] > A[largest]:
        largest = r
    if not largest == i:
        A[i], A[largest] = A[largest],A[i]
        Max_Heapify(A,largest, size)
        

def Build_Max_Heap(A, size):
   n = len(A)
   
   for i in range ((size)//2,0,-1):
       Max_Heapify(A,i, size)


def HeapSort(A):
    size = len(A) - 1
    Build_Max_Heap(A, size)
    
    for i in range ((len(A) - 1),1,-1):
        A[1], A[i] = A[i], A[1]
        size = size - 1
        Max_Heapify(A,1,size)
    
print("Unsorted array: \n ", A)#Prints unsorted integers first
print("\n\n\n")
HeapSort(A) #Calling the insertion sort function 
print("Sorted array: \n", A) #Prints sorted integers first
        
