for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 heapReverse.py $i > ./test/heapReverse$i.txt
done
