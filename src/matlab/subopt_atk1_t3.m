%% atk4: know fake DB, NO precise control (worse case!)
% reuse function of sub_optimal_attack
% First is to learn the distribution of the fake rss we can get

%% construct fake DB
%construct the fake DB using the use test data
load ./mat/rssMap.mat; % R
load ./mat/userMap.mat;% U
load ./mat/rpc.mat rpc; % coordinates of reference point
load ./mat/upc.mat upc; % coordinates of user      point
load ./mat/distribution.mat

fdb=[];
for i=1:72
    mean_per_rp = R(i,:,1)*1.2; % 
    fdb=[fdb;mean_per_rp];
end
% substitute 0 with -90
for ri=1:72
    for rj=1:35
        if fdb(ri,rj) == 0
            fdb(ri,rj)=-90;
        end
    end
end
% fdb=[];
% for i=1:5:360
%     mean_per_rp = mean(U(i:i+4,:)); % mean of every five test points correspond to rp
%     fdb=[fdb;mean_per_rp];
% end
% %save fakeDB.mat fdb;
% use fake DB
R=fdb;

%%
% substitute 0 with -90
% for ri=1:72
%     for rj=1:35
%         if R(ri,rj) == 0
%             R(ri,rj)=-90;
%         end
%     end
% end
for ui=1:360
    for uj=1:35
        if U(ui,uj) == 0
            U(ui,uj)=-90;
        end
    end
end

%% Second is to modify the optimal attack algorithm
% fake DB and not precise control
u=360;
universe3=zeros(u,2,35);
avg3=zeros(1,35);
for k = 1:25
    res=zeros(u,2);  
    fprintf("atk4: FakeAp Num: %d\n",k);
    %j=0;
    for i=1:360
        %fprintf("atk4: User indxe: %d, FakeAp Num: %d\n",i,k);
        %j=j+1;
        ru = U(i,:); xu = upc(i,:);% current user rss and coordinates
        res(i,:)=sub_optimal_attack_2(i,k,mv,R,ru,rpc,xu);
    end
    avg3(k)= mean(res(:,2));
    universe3(:,:,k)=res; % k layer
end
%save avg_atk4_1.real.mat universe4 avg4;
save ./mat/type3.mat universe3 avg3;









