close all
clear
clc
load ./mat/rssMap.mat; % R
load ./mat/userMap.mat;% U
load ./mat/rpc.mat rpc; % coordinates of reference point
load ./mat/upc.mat upc; % coordinates of user      point
load ./mat/distribution.mat


mu=R(:,:,1);
[m,n]=size(U);

sigma=R(:,:,2);

for i=1:m %ith user
    for j=1:size(mu,1) % check each reference point in database
        for k=1:35
            if U(i,k)==0 && mu(j,k)~=0 %user 0,not received
                U(i,k)=-120;
            end
%             if U(i,k)~=0 && mu(j,k)==0 %mu 0 ignore
%                 U(i,k)=0;
%             end
            temp(j,k)=(mu(j,k)-U(i,k))^2;
        end
        Dis(i,j)=sqrt(sum(temp(j,:)));
        %         Dis(i,j)=sqrt(sum((mu(j,:)-U(i,:)).^2));
        %distance between user i and reference point j.
    end
end
%%%%choose maximum K and average
K=3;
[m,n]=size(Dis);
loc=[];
for i=1:m %ith user
   [tempDis,index]=sort(Dis(i,:)); 
     returnLA(i,:)=mean(rpc(index(1:K),:)); %%KNN
     %loc=[loc,index(1)];
     index(1:10)
  %returnLA(i,:)=rpc(index(1),:);
end

errMatrix=upc-returnLA;
for i=1:m
    ErrDis_KNN(i,1)=sqrt(sum(errMatrix(i,:).^2));
end
%save ./data/knn.mat ErrDis_KNN
%  SortErrDis=sort(ErrDis_KNN);
% cdf= calculateCdf(ErrDis_KNN,24);
% plot(0:23,cdf)
% figure
%  [x,f]=ecdf(ErrDis);
% % plot(f,x,'r')
