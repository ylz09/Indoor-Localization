# split the abcd.txt into files whose name are the landmark prefix

awk -F\| '{split($1,a,"-"); print $2 > a[1]a[2]".dat"}' abcd.txt