'''
  Author: Ruchik Patel
  Date: 09/16/2017
  File: reversed_MS.py
  Description: Merge sort algorithm that sorts revered generated integers.
 
 '''
import sys

MAX_BOUNDARY = 8888888888888888888 
#Since we are not using integers more than 0-1000, this would a safe to use it as sentinal value.

n = int(sys.argv[1]) #System argument 

mainArray = [] #Array nums that stores integers.

# For reversed:
mainArray = list(range(n, 0, -1))

print("Unsorted array: \n ", mainArray) #Prints unsorted integers first

def mergeSort(nums, startPoint, midPoint, endPoint):

	left = nums[startPoint:midPoint] #Populate left array
	left.append(MAX_BOUNDARY) #Set the last element to max number

	right = nums[midPoint:endPoint] #Populate right array
	right.append(MAX_BOUNDARY) #Set the last element to max number
	i = 0
	j = 0

	for k in range(startPoint,endPoint):
		if (left[i] <= right[j]):
			nums[k] = left[i]
			i = i + 1
		else:
			nums[k] = right[j]
			j = j + 1

# Merge-sort recursion 
def mergeSortRec(nums,startPoint,endPoint):
    if endPoint - startPoint > 1:
        midPoint = int((startPoint+endPoint)/2)
        mergeSortRec(nums,startPoint,midPoint)
        mergeSortRec(nums,midPoint,endPoint)
        mergeSort(nums,startPoint,midPoint,endPoint)

print("\n\n\n")
mergeSortRec(mainArray, 0, len(mainArray))
print("Sorted array: \n", mainArray)
