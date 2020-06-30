for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 bubbleSort_reverseOrder.py $i > ./test/bubble_reverse_test_$i.txt
done
