for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 reversed_MS.py $i > ./test/reversed_test_$i.txt
done