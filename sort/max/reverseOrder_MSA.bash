for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 maxSubArray_reverseOrder.py $i > ./test/maxSubArray_reverse_test_$i.txt
done
