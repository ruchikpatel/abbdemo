for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 randomNumbers_IS.py $i > ./test/randomNumbers_test_$i.txt
done