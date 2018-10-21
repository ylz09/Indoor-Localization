% calculate the deviation difference of targeted attack
% if the sucess, then error distance is 0
% else return the nearest location that is close to the location on the
% attacker's choice

%% header, preprocessing
%h = figure;
%clc
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

%load paris_ks.mat       % save paris_ks.mat iids uids; 
%k = 200;

k = 1000;
uids = randperm(360,360);
uids = [uids,randperm(360,360)];
uids = [uids,randperm(360,280)];
iids = randperm(72,72);
for i=1:12
    iids = [iids,randperm(72,72)];
end
iids = [iids,randperm(72,64)];

% for a given p, what's the error distance? p means fake ap number
dist1=[];
for p=1:35
    fprintf('Target type-1 error distance of %d fake APs\n',p);
    klog=zeros(1,k);
    for j=1:k
        u=uids(j);
        i=iids(j);
        xu=upc(u,:);
        klog(j)=target_dist(p-1,u,i,umap,rmap,xu,rpc);
    end
    dist1=[dist1;klog];
end

% target-know-db
dist2=[];
for p=1:35
    fprintf('target type-2 rates of %d fake APs\n',p);
    klog=zeros(1,k);
    for j=1:k
        u=uids(j);
        i=iids(j);
        xu=upc(u,:);
        klog(j) = target_dist2(p-1,u,i,umap,rmap,xu,rpc,mv);
    end
    dist2=[dist2;klog];
end

% target-partial
mydb=fdb;
dist3=[];
for p=1:35
    fprintf('Target type-3 rates of %d fake APs\n',p);
    klog=zeros(1,k);
    for j=1:k
        u=uids(j);
        i=iids(j);
        xu=upc(u,:);
        klog(j)=target_dist3(p-1,u,i,umap,rmap,mydb,xu,rpc,mv);
    end
    dist3=[dist3;klog];
end

% Target-random attack
dist4=[];
for p=1:35
    fprintf('Target type-4 rates of %d fake APs\n',p);
    klog=zeros(1,k);
    for j=1:k
        u=uids(j);
        i=iids(j);
        xu=upc(u,:);
        ru=umap(u,:);
        ru(randperm(35,p-1)) = -randperm(80,p-1);
        ri=rmap(i,:);
        dist=pdist2(ru,ri);
        klog(j)=feasible_check(dist,ru,u,i,rmap,xu,rpc);
    end   
    dist4=[dist4;klog];
end

%save target_k_cdf.mat dist1 dist2 dist3 dist4;
save ./mat/target_cdf_v2.mat dist1 dist2 dist3 dist4;
target_cdf_fig

%% 2 problem
% given fake ap number and test pair, return the successful probability
function [feasible] = target_dist(k,u,i,umap,rmap,xu,rpc)
ru=umap(u,:);
ri=rmap(i,:);
diff = abs(ru-ri);
[rdff,idx]=sort(diff);

ru(idx(35-k+1:35)) = ri(idx(35-k+1:35));
dist=pdist2(ru,ri);
feasible=feasible_check(dist,ru,u,i,rmap,xu,rpc);

end

function [feasible] = target_dist2(k,u,i,umap,rmap,xu,rpc,mv)
ru=umap(u,:);
ri=rmap(i,:);
diff = abs(ru-ri);
[rdff,idx]=sort(diff);

%ru(idx(35-k+1:35)) = ri(idx(35-k+1:35))*0.95; %0.96; % cant' precisely control! make it easy! magic number!
for ii = 35-k+1:35
    var = mv*randn(1);
    temp=ri(idx(ii))+var;
    ru(idx(ii)) = temp;
end
    
dist=pdist2(ru,ri);
feasible=feasible_check(dist,ru,u,i,rmap,xu,rpc);

end

function [feasible] = target_dist3(k,u,i,umap,rmap,mydb,xu,rpc,mv)

feasible=0;
for s=1:k+1
    ru=umap(u,:);
    fri=mydb(i,:);
    diff = abs(ru-fri);
    [rdff,idx]=sort(diff);
    ri=rmap(i,:);
    
    %ru(idx(35-k+1:35)) = fri(idx(35-k+1:35))*0.93; % cant' precisely control! make it easy! magic number!
    for ii = 35-s+2:35
        var = mv*randn(1);
        temp=ri(idx(ii))+var;
        ru(idx(ii)) = temp;
    end
    
    dist=pdist2(ru,ri);
    feasible=feasible_check(dist,ru,u,i,rmap,xu,rpc);
    if feasible == 0
        return;
    end
end

end

function [feasible] = feasible_check(dist,ru,u,i,rmap,xu,rpc)
for j=1:72
    if j==i || j==u
        continue;
    end
    rj=rmap(j,:);
    d = pdist2(ru,rj);
    if d < dist
        jid= rpc(j,:);
        feasible=pdist2(jid,xu) ;
        return;
    end
end
feasible=0;
end
