'''
  Author: Ruchik Patel
  Date: 10/11/2017
  File: bubbleSort_reverseOrder.py
  Description: maxsubarray algorithm 
 
 '''

import sys
import math #Using it for infinity since the question didn't specified the limit for numbers so.

n = int(sys.argv[1]) #System argument 

ARRRY = list(range(n, 0, -1))

print("Unsorted array: \n ", ARRRY)#Prints unsorted integers first

def MaxCrossingSubarray(ARRRY, low, mid, high):
    leftSum = -math.inf #Assin the left array to neg infinity.
    sum = 0

    for i in range(mid, low - 1, -1):
        sum = sum + ARRRY[i]

        if sum > leftSum:
            leftSum = sum
            maxLeft = i
            
    rightSum = -math.inf
    sum = 0

    for j in range(mid + 1, high + 1):
        sum = sum + ARRRY[j]
        if sum > rightSum:
            rightSum = sum
            maxRight = j

            LR_sum = leftSum + rightSum

    return (maxLeft, maxRight, LR_sum)


def MaximumSubarray(ARRRY, low, high):
    #Recursion function
    if high == low:
        return (low, high, ARRRY[low])

    else:
        mid = int((low + high)/2)
        (leftLow, left_High, leftSum) = MaximumSubarray(ARRRY, low, mid)

        (rightLow, right_High, rightSum) = MaximumSubarray(ARRRY, mid + 1, high)

        (cross_Low, cross_High, crossSum) = MaxCrossingSubarray(ARRRY, low, mid, high)

        if leftSum >= rightSum & leftSum >= crossSum:
            return leftLow, left_High, leftSum

        elif rightSum >= leftSum & rightSum >= crossSum:
            return rightLow, right_High, rightSum

        else:
            return cross_Low, cross_High, crossSum

print("\n\n\n")
ARRRY, lowKey, highKey = MaximumSubarray(ARRRY, 0, len(ARRRY)-1)   #Calling the insertion sort function 
print("Array: \n", ARRRY, lowKey,highKey) #Prints sorted integers first



        
