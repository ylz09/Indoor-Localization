# Extract the Location-Rssvector.dat by location using awk
awk -F\| '{split($1,a,"-"); print $2 > a[1]a[2]".txt"}'

#  Transform
awk -F\| '{ \
split($1,a,"-"); \
if( \
(a[1]=="a"&& a[3]=="b")|| \
(a[1]=="b"&& a[3]=="c")||\
(a[1]=="c"&& a[3]=="d")||\
(a[1]=="d"&& a[3]=="a")\
)\
print $2 > a[1]a[2]".txt"}' counterclolckwise.dat

%s/null/0/g

# Load
sz *.txt

#After ETL, all the files or database are update to the matlab directory for the radio construction
