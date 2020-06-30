for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 maxSubArray_random.py $i > ./test/MSA_random_test_$i.txt
done
