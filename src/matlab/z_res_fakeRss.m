clear;
load cn10.mat;
load userMap.mat;
load map.mat;

%
%1st:
% likelihood, n = 35, k=35, opt=29 no attack
% opt: inner tuning parameter
r=logcnk_test(U,R,35,29,0,[]);
mean(r(:,3));
cnn = r(:,3)';
save cnn.mat cnn;
%}

%
% last test use k = 30, which is not correct...
%2ed
% likelihood, n = 35, k=35, opt=29 5 APs attack
mean_mat=[];
cnn_fakerss=[];
i=1;
for rss = -100:-30
    t=U;
    t(:,[1,5,10,15,20,25,30,35]) = rss;      %jamming mean the strength is very low %cn10(rss,1:8)
    r=logcnk_test(t,R,35,30,0,[]);
    mean_mat(:,i)=r(:,3); i = i+1;
end
cnn_fakerss = mean_mat;
save cnn_fakerss.mat cnn_fakerss;
%}

%
%3rd
% likelihood, n = 35, k=30, no attack
% opt=24
r=logcnk_test(U,R,30,24,0,[]); % 24 inner parameter
cnk = r(:,3)';
save cnk.mat cnk;
%}

%
%4th
% likelihood, n = 35, k=30,  5 APs attack, opt = 25
mean_mat=[];
cnk_fakerss=[];
i=1;
for rss = -100:-30
    t=U;
    t(:,[1,5,10,15,20,25,30,35]) = rss; % jamming mean the strength is very low    
    r=logcnk_test(t,R,30,24,0,[]);
    mean_mat(:,i)=r(:,3); i = i +1;
end
cnk_fakerss = mean_mat;
save cnk_fakerss.mat cnk_fakerss;
%}

