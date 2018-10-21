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
cnn_fak=[];
for i = 1 : size(cn10,1)
    t=U;
    t(:,cn10(i,1:8)) = -90; % jamming mean the strength is very low    
    r=logcnk_test(t,R,35,30,0,[]);
    mean_mat(i,:)=r(:,3)';
end
cnn_fak = mean(mean_mat);
save cnn_fak.mat cnn_fak;
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
cnk_fak=[];
for i = 1 : size(cn10,1)
    t=U;
    t(:,cn10(i,1:8)) = -90; % jamming mean the strength is very low    
    r=logcnk_test(t,R,30,24,0,[]);
    mean_mat(i,:)=r(:,3)';
end
cnk_fak = mean(mean_mat);
save cnk_fak.mat cnk_fak;
%}



