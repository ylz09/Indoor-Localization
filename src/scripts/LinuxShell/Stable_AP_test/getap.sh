# !bin/sh
i=1
for f in ./*.txt
do
    #echo $f;
    name=$(printf ap%d.txt $i);
    #echo $name;
    sort $f | uniq -w 18 > $name;
    i=$(($i+1));
done
