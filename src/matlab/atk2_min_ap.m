% Attack 2 
% 1 given pair data set, get the minial APs need to be attacked
% 2 given attacked AP number, the probability of successful decieve user

%% header, preprocessing
h = figure;
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

%% Test 1
% generate random pairs to test target attack
% just random u index[1..360] and i index [1..72]
umap=U;
rmap=rss;
k = 70;
uids = randperm(360,k); % 100 random number in [1..360] 
iids = randperm(72,k);
% while k > 72
%     iids = randperm(72);
%     iids = [iids,randperm(72,k-72)];
%     k=k-72;
% end
minaps=zeros(1,k);
for p=1:k
    fprintf('Test AP numbers needed of %d-th pair\n',p);
    u=uids(p);
    i=iids(p);
    minaps(p)=get_min_ap(u,i,umap,rmap);
end

plot(minaps,'-.','linewidth',1.5)
xlabel('Test cases index','fontsize',18)
ylabel('Minaml APs needed','fontsize',18)


%% 1st problem
% input: (xu, ru) to (xi,ri)
% output: the minimal number APs needed
function [min_ap] = get_min_ap(u,i,umap,rmap)
%sort the diff
ru=umap(u,:);
ri=rmap(i,:);
diff = abs(ru-ri);
[rdff,idx]=sort(diff);
%change k fake ap
for k=1:35
    % get ru1
    ru(idx(35-k+1:35)) = ri(idx(35-k+1:35));
    dist=pdist2(ru,ri);
    feasible=feasible_check(dist,ru,u,i,rmap);
    if feasible == 1
        min_ap=k;
        return;
    end
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









