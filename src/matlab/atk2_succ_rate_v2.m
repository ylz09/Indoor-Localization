% should be consistent with drop_effect.m

%% header, preprocessing
clear;
%load fakeDB.mat %fdb
load ./mat/rssMap.mat; % R
load ./mat/userMap.mat;% U
load ./mat/rpc.mat rpc; % coordinates of reference point
load ./mat/upc.mat upc; % coordinates of user      point
load ./mat/distribution.mat 

% fdb=[];
% for i=1:5:360
%     mean_per_rp = mean(U(i:i+4,:)); % mean of every five test points correspond to rp
%     %mean_per_rp = U(i+2,:); % mean of every five test points correspond to rp
%     fdb=[fdb;mean_per_rp];
% end
fdb=[];
for i=1:72
    mean_per_rp = R(i,:,1)*1.13; % 
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
for ri=1:72
    for rj=1:35
        if R(ri,rj,1) == 0
            R(ri,rj,1)=-90;
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
rss = R(:,:,1); % only need mean don't need sigma,save space!

%% Test 2
umap=U;
rmap=rss;
%k = 200;
% load paris_ks.mat       % save paris_ks.mat iids uids; 
% k = 200;

load ./mat/pairs1000.mat
k = 1000;
% uids = randperm(360,k); % 100 random number in [1..360]
% iids = randperm(72,72);
% iids = [iids,randperm(72,72)];
% iids = [iids,randperm(72,56)];

%save pairs.mat uids iids
%load pairs.mat

rates=[];
for p=1:30
    rate=0;
    sums=0;
    fprintf('Target-optimal rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        sums=sums+succ_rate(p-1,u,i,umap,rmap);
    end
    rate=sums/k;
    rates=[rates,rate];
end

% target-know-db
rates2=[];
for p=1:30
    rate=0;
    sums=0;
    fprintf('target-know-db rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        sums=sums+succ_rate2(p-1,u,i,umap,rmap,mv); % mv, mean variance, loaded from distribution.mat
    end
    rate=sums/k;
    rates2=[rates2,rate];
end

% target-partial
mydb=fdb;
rates3=[];
for p=1:30
    rate=0;
    sums=0;
    fprintf('Target-partial rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        sums=sums+succ_rate3(p-1,u,i,umap,rmap,mydb,mv);
    end
    rate=sums/k;
    rates3=[rates3,rate];
end

% Target-random attack
rates4=[];
for p=1:30
    r=0;
    sums=0;
    fprintf('Target-random rates of %d fake APs\n',p);
    
    for j=1:k
        u=uids(j);
        i=iids(j);
        ru=umap(u,:);
        ri=rmap(i,:);
        ru(randperm(35,p-1)) = -randperm(100,p-1);
        dist=pdist2(ru,ri);
        feasible=feasible_check(dist,ru,u,i,rmap);
        if feasible == 1
            sums=sums+1;
        end
    end   
    
    r=sums/k;
    rates4=[rates4,r];
end

%save target_suc_rate1.13.mat rates rates2 rates3 rates4;
save ./mat/target_suc_rate_v2_1k.mat rates rates2 rates3 rates4;
atk2_succ_rate_fig
%% 2 problem
% given fake ap number and test pair, return the successful probability
function [succ] = succ_rate(k,u,i,umap,rmap)

succ=0;
% for s=1:k+1
    ru=umap(u,:);
    ri=rmap(i,:);
    diff = abs(ru-ri);
    [rdff,idx]=sort(diff);

    ru(idx(35-k+1:35)) = ri(idx(35-k+1:35));
    dist=pdist2(ru,ri);
    feasible=feasible_check(dist,ru,u,i,rmap);
    if feasible == 1
        succ=1;
        return;
    end
% end
end

function [succ] = succ_rate2(k,u,i,umap,rmap,mv)

%ru(idx(35-k+1:35)) = ri(idx(35-k+1:35))*0.95; %0.96; % cant' precisely control! make it easy! magic number!
succ=0;
%mv=5;
% for s=1:k+1
    ru=umap(u,:);
    ri=rmap(i,:);
    diff = abs(ru-ri);
    [rdff,idx]=sort(diff);

    for ii = 35-k+1:35
        var = mv*randn(1);
        temp=ri(idx(ii))+var;
        ru(idx(ii)) = temp;
    end
    
    dist=pdist2(ru,ri);
    feasible=feasible_check(dist,ru,u,i,rmap);
    if feasible == 1
        succ=1;
        return;
    end
% end

end

function [succ] = succ_rate3(k,u,i,umap,rmap,mydb,mv)

%ru(idx(35-k+1:35)) = fri(idx(35-k+1:35))*0.95; % cant' precisely control! make it easy! magic number!
succ=0;
for s=1:k+1
    ru=umap(u,:);
    fri=mydb(i,:);
    diff = abs(ru-fri);
    [rdff,idx]=sort(diff);
    ri = rmap(i,:);

    for ii = 35-s+2:35
        var = mv*randn(1);
        temp=fri(idx(ii))+var;
        ru(idx(ii)) = temp;
    end
    
    dist=pdist2(ru,ri);
    feasible=feasible_check(dist,ru,u,i,rmap);
    if feasible == 1
        succ=1;
        return;
    end
end

end

function [feasible] = feasible_check(dist,ru,u,i,rmap)
for j=1:72
    if j==i %|| j==u
        continue;
    end
    rj=rmap(j,:);
    d = pdist2(ru,rj);
    if d < dist
        feasible=0 ;
        return;
    end
end
feasible=1;
end
