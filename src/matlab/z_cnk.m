v=1:2:35;
c=nchoosek(v,10);
size(c);


% total 300 fake ap combination
cn10=[];

cn10=[cn10;c(1:100,:)];
cn10=[cn10;c(10000:10100,:)];
cn10=[cn10;c(20000:20100,:)];
cn10=[cn10;c(30000:30100,:)];
cn10=[cn10;c(40000:40100,:)];

save cn10.mat cn10;

%{
cnt = 0;
for i = 1 : size(c,1)
    if c(i,1) == 19
        cnt = cnt+1;
    end
end
disp(cnt)

1 cnk
   330
4 cnk
   210
7 cnk
   126
10 cnk
    70
13 cnk
    35
16 cnk
    15
19 cnk
     5
%}