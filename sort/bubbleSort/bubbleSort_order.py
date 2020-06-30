'''
  Author: Ruchik Patel
  Date: 09/16/2017
  File: bubbleSort_order.py
  Description: Bubble sort algorithm that sorts ordered elements(basically sorting sorted elements)
 '''
 
import sys #import system library/package 

n = int(sys.argv[1]) #System argument 

# For ordered:
nums = list(range(0, n))

print("Unsorted array: \n ", nums)#Prints unsorted integers first


#Bubble sort function
def bubbleSort(nums):
    for i in range(0, len(nums)):
        for j in range(len(nums)-1, i, -1):
            if nums[j] < nums[j-1]:
                nums[j],nums[j-1] = nums[j-1],nums[j]

print("\n\n\n")
bubbleSort(nums)	#Calling the insertion sort function 
print("Sorted array: \n", nums) #Prints sorted integers first
