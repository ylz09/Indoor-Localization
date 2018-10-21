%% atk3: suboptimal,control AP with fake DB
% This means we can precisely control AP but do not know the DB
% reuse function of optimal_attack
%% First step
% construct the fake DB using the use test data
% This fake DB is better than real one
% 1. mean 5 rss are more representive than 1 rp
% 2. mean 5 rss are more similar to the test data
% only pick 2 of 5 to construct fake DB
load 'rssMap.mat'; % R
load 'userMap.mat';% U

fdb=[];
for i=1:5:360
    mean_per_rp = mean(U(i:i+4,:)); % mean of every five test points correspond to rp
    fdb=[fdb;mean_per_rp];
end
save fakeDB.mat fdb;

%% Second step
% same as the optimal attack except using fake DB
% reuse the function optimal_attack(u,k,R,U,rpc,upc), subst R with fdb
load 'fakeDB.mat'; % R
load rpc.mat rpc; % coordinates of reference point
load upc.mat upc; % coordinates of user      point
% use fake DB
R=fdb;
% substitute 0 with -90
for ri=1:72
    for rj=1:35
        if R(ri,rj) == 0
            R(ri,rj)=-90;
        end
    end
end
for ui=1:360
    for uj=1:35
        if U(ui,uj) == 0
            U(ui,uj)=-90;
        end
    end
end

%% optimal attack but with fake DB
u=360;
universe3=zeros(u,2,35);
avg3=zeros(1,35);
for k = 1:35
    res=zeros(u,2);   
    fprintf("atk3: FakeAp Num: %d\n",k);
    %j=0;
    for i=1:360
        %fprintf("atk3: User indxe: %d, FakeAp Num: %d\n",i,k);
        %j=j+1;
        ru = U(i,:); xu = upc(i,:);% current user rss and coordinates
        res(i,:)=optimal_attack(i,k,R,ru,rpc,xu);
    end
    avg3(k)= mean(res(:,2));
    universe3(:,:,k)=res; % k layer of cube
end
%save avg_atk3.real.mat universe3 avg3;






