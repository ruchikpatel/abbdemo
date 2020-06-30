for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 heapRandom.py $i > ./test/heapRandom$i.txt
done
