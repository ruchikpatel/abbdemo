for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 randomPivotReverse.py $i > ./test/randomPivotReverse$i.txt
done
