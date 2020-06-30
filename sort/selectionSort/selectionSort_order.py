'''
  Author: Ruchik Patel
  Date: 09/16/2017
  File: selectionSort_order.py
  Description: Selection sort algorithm that sorts ordered elements(basically sorting sorted elements)
 
 '''
import sys #import system library/package 

n = int(sys.argv[1]) #System argument 

# For ordered:
nums = list(range(0, n))

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

