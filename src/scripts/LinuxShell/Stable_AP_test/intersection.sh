grep -F -f   mac1.txt mac2.txt > m1
grep -F -f   mac3.txt mac4.txt > m2
grep -F -f   mac5.txt mac6.txt > m3
grep -F -f   mac7.txt mac8.txt > m4
grep -F -f   m1 m2 > p1
grep -F -f   m3 m4 > p2
grep -F -f   p1 p2 > i.r
rm m1 m2 m3 m4 p1 p2
