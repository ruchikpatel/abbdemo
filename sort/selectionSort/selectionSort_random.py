'''
  Author: Ruchik Patel
  Date: 09/16/2017
  File: selectionSort_random.py
Description: Bubble sort algorithm that sorts randomly generated integers.
 '''

import random #import random library/package
import sys #import system library/package 

n = int(sys.argv[1]) #System argument 

# For random:
nums = [] #Array nums that stores integers.
for i in range(0, n):
    nums.append(random.randint(0, 1000))


print("Unsorted array: \n ", nums)#Prints unsorted integers first

def selectionSort(nums):
    for i in range(0,len(nums)-1):
        min = i
        
        for j in range(i+1,len(nums)):
            if nums[j] < nums[min]:
                min = j

        nums[min],nums[i] = nums[i],nums[min]


print("\n\n\n")
selectionSort(nums)	#Calling the insertion sort function 
print("Sorted array: \n", nums) #Prints sorted integers first

