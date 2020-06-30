for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 quickSortOrdered.py $i > ./test/quickSort_Ordered_$i.txt
done
