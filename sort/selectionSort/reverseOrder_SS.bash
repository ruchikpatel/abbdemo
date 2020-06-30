for ((i=500; i<=10000; i+=500));
do
    /usr/bin/time python3 selectionSort_reverse.py $i > ./test/selection_reverse_test_$i.txt
done
