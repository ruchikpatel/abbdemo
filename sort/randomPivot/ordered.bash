for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 randomPivotOrdered.py $i > ./test/randomPivotOrdered_$i.txt
done
