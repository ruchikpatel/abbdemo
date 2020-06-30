'''
  Author: Ruchik Patel
  Date: 09/16/2017
  File: randromNumbers_IS.py
  Description: Insertion sort algorithm that sorts randomly generated integers.
 
 '''

import random #import random library/package
import sys #import system library/package 

n = int(sys.argv[1]) #System argument 

nums = [] #Array nums that stores integers.

# For random:
for i in range(0, n):
    nums.append(random.randint(0, 1000))

print("Unsorted array: \n ", nums)#Prints unsorted integers first 

#Insert sort function
def insertion_sort(nums):
	for j in range(1,len(nums)):
		key = nums[j]
		i = j - 1
		while i >= 0 and nums[i] > key:
			nums[i + 1] = nums[i]
			i -= 1
		nums[i + 1] = key


print("\n\n\n")
insertion_sort(nums) #Calling the insertion sort function 
print("Sorted array: \n", nums) #Prints sorted integers first