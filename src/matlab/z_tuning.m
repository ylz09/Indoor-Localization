close all;
clear;
load userMap.mat;
load map.mat;

x=zeros(1,0);
y=zeros(1,0);
h=zeros(2,0);
for i=1:35
r=logcnk_test(U,R,30,i,0);
acy=0;
[v,t]=mode(r(:,4));
if v
acy=t/size(r,1);
else
acy=(size(r,1)-t)/size(r,1);
end 
x(i)=i;
y(i)=[acy];
h=[h;x(i),y(i)];
end