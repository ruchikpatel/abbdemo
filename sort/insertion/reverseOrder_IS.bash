for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 reverseOrder_IS.py $i > ./test/reverse_test_$i.txt
done