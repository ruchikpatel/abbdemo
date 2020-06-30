'''
  Author: Ruchik Patel
  Date: 09/16/2017
  File: randromNumbers_IS.py
  Description: Insertion sort algorithm that sorts reverse orderintegers.
 '''
import sys #import system library/package 

n = int(sys.argv[1]) #System argument 

# For reverse:
nums = list(range(n, 0, -1))

print("Unsorted array: \n ", nums)#Prints unsorted integers first

#Insertion sort function
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