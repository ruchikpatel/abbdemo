for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 randomPivotRandom.py $i > ./test/randomPivotRandom$i.txt
done
