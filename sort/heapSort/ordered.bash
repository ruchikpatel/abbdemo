for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 heapOrder.py $i > ./test/heapOrdered_$i.txt
done