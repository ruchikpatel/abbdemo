for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 bubbleSort_order.py $i > ./test/bubble_test_$i.txt
done