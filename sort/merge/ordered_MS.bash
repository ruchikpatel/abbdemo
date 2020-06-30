for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 ordered_MS.py $i > ./test/ordered_test_$i.txt
done