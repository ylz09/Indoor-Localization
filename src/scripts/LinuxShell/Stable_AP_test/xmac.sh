# !bin/sh
i=1
for f in ./ap*.txt
do
    name=$(printf mac%d.txt $i);
    awk '{print $1}' $f > $name;
    i=$(($i+1));
done
