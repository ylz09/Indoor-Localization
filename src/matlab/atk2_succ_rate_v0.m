% target attack. optmial: knows DB and precisely control
% 1 given pair data set, get the minial APs need to be attacked
% 2 given attacked AP number, the probability of successful decieve user

%% header, preprocessing
%h = figure;
%clc
load ./mat/rssMap.mat; % R
load ./mat/userMap.mat;% U
load ./mat/rpc.mat rpc; % coordinates of reference point
load ./mat/upc.mat upc; % coordinates of user      point
% substitute 0 with -90
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
k = 70;
uids = randperm(360,k); % 100 random number in [1..360]
iids = randperm(72,k);

rates=[];
for p=1:35
    rate=0;
    sum=0;
    fprintf('Test rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        sum=sum+succ_rate(p,u,i,umap,rmap);
    end
    rate=sum/k;
    rates=[rates,rate];
end

% compare with random attack
rnd=[];
for p=1:35
    r=0;
    sum=0;
    fprintf('Test random rates of %d fake APs\n',p);
    
    for j=1:k
        u=uids(j);
        i=iids(j);
        ru=umap(u,:);
        ri=rmap(i,:);
        ru(randperm(35,p)) = -randperm(100,p);
        dist=pdist2(ru,ri);
        feasible=feasible_check(dist,ru,u,i,rmap);
        if feasible == 1
            sum=sum+1;
        end
    end   
    
    r=sum/k;
    rnd=[rnd,r];
end
save ./mat/target_rnd.mat rates rnd; % Mistake!

%% 2 problem
% given fake ap number and test pair, return the successful probability
function [succ] = succ_rate(k,u,i,umap,rmap)
ru=umap(u,:);
ri=rmap(i,:);
diff = abs(ru-ri);
[rdff,idx]=sort(diff);

ru(idx(35-k+1:35)) = ri(idx(35-k+1:35));
dist=pdist2(ru,ri);
feasible=feasible_check(dist,ru,u,i,rmap);
if feasible == 1
    succ=1;
else
    succ=0;
end
end

function [feasible] = feasible_check(dist,ru,u,i,rmap)
for j=1:72
    if j==i || j==u
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
