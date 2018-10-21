% target attack3. partial knows db, partial control AP
% 1 given pair data set, get the minial APs need to be attacked
% 2 given attacked AP number, the probability of successful decieve user

%% header, preprocessing
%clc
%load fakeDB.mat %fdb
load ./mat/rssMap.mat; % R
load ./mat/userMap.mat;% U
load ./mat/rpc.mat rpc; % coordinates of reference point
load ./mat/upc.mat upc; % coordinates of user      point
load ./mat/target_suc_rate.mat

% learning the db to get fdb, too good to be true!
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

k = 200;
load pairs.mat

% k = 70;
% uids = randperm(360,k); % 100 random number in [1..360]
% iids = randperm(72,k);
% % atk2-type3-d2
mydb=fdb;

% rates3_2=[];
% for p=1:35
%     rate=0;
%     sum=0;
%     fprintf('defense atk2-type2-d2: rates of %d fake APs\n',p);
%     for j=1:k
%         u=uids(j);
%         i=iids(j);
%         % defense here, before matching, drop the rss first!
%         xx=2;
%         sum=sum+succ_rate3(p-1,u,i,umap,rmap,mydb,xx);
%     end
%     rate=sum/k;
%     rates3_2=[rates3_2,rate];
% end
% 
% % % atk2-type3-d4
% mydb=fdb;
% rates3_4=[];
% for p=1:35
%     rate=0;
%     sum=0;
%     fprintf('defense atk2-type2-d4: rates of %d fake APs\n',p);
%     for j=1:k
%         u=uids(j);
%         i=iids(j);
%         % defense here, before matching, drop the rss first!
%         xx=4;
%         sum=sum+succ_rate3(p-1,u,i,umap,rmap,mydb,xx);
%     end
%     rate=sum/k;
%     rates3_4=[rates3_4,rate];
% end

% % atk2-type3-d8
mydb=fdb;
rates3_8=[];
for p=1:35
    rate=0;
    sum=0;
    fprintf('defense atk2-type2-d8: rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        % defense here, before matching, drop the rss first!
        xx=8;
        sum=sum+succ_rate3(p-1,u,i,umap,rmap,mydb,xx);
    end
    rate=sum/k;
    rates3_8=[rates3_8,rate];
end

mydb=fdb;
rates3_16=[];
for p=1:35
    rate=0;
    sum=0;
    fprintf('defense atk2-type2-d8: rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        % defense here, before matching, drop the rss first!
        xx=16;
        sum=sum+succ_rate3(p-1,u,i,umap,rmap,mydb,xx);
    end
    rate=sum/k;
    rates3_16=[rates3_16,rate];
end

mydb=fdb;
rates3_24=[];
for p=1:35
    rate=0;
    sum=0;
    fprintf('defense atk2-type2-d8: rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        % defense here, before matching, drop the rss first!
        xx=24;
        sum=sum+succ_rate3(p-1,u,i,umap,rmap,mydb,xx);
    end
    rate=sum/k;
    rates3_24=[rates3_24,rate];
end

mydb=fdb;
rates3_34=[];
for p=1:35
    rate=0;
    sum=0;
    fprintf('defense atk2-type2-d8: rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        % defense here, before matching, drop the rss first!
        xx=34;
        sum=sum+succ_rate3(p-1,u,i,umap,rmap,mydb,xx);
    end
    rate=sum/k;
    rates3_34=[rates3_34,rate];
end


%save target_suc_rate.mat rates rates2 rates3 rates4;
% % atk2-type3-median
mydb=fdb;
rates3_m=[];
for p=1:35
    rate=0;
    sum=0;
    fprintf('defense atk2-type2-dm: rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        % defense here, before matching, drop the rss first!
        sum=sum+atk2_medi(p-1,u,i,umap,rmap,mydb);
    end
    rate=sum/k;
    rates3_m=[rates3_m,rate];
end

save ./mat/def_a1t3_suc_rate.mat rates3_2 rates3_4 rates3_8 rates3_16 rates3_24 rates3_34 rates3_m;
def_atk2_type3_zest_fig
%% 2 problem
function [true] = atk2_medi(k,u,target,umap,rmap,mydb)   
% medi(p,u,i,umap,rmap,mydb,xx)
 rmin = 10000000;
% imin = 0;
ru=umap(u,:);
%ri = rmap(target,:);
%fri=rmap(target,:);
fri=mydb(target,:);
diff = abs(ru-fri);
[rdff,idx]=sort(diff);

%ru(idx(35-k+1:35)) = fri(idx(35-k+1:35))*0.98; % cant' precisely control! make it easy! magic number!
%ru(idx(35-k+1:35)) = fri(idx(35-k+1:35))*0.968; % cant' precisely control! make it easy! magic number!
ru(idx(35-k+1:35)) = fri(idx(35-k+1:35))*0.95; % cant' precisely control! make it easy! magic number!
%dist_vec=zeros(72,2);
for i = 1:72
    ri = rmap(i,:);
    dui = median((ru-ri).^2);
%    dist_vec(i,:)=[dui,i];
%     % dk(ru,rj)
    if dui < rmin % pdist2, euclidean distance of ru rj
        rmin = dui;
        imin = i;
    end
%     %fprintf('dui: %4.2f, duj; %4.2f\n',sqrt(dui),pdist2(ru,rj));
end
% res = sortrows(dist_vec,1);
% first= res(1,2);
if target == imin
    true=1;
else
    true=0;
end
%dist = pdist2(rpc(first,:),xu);
% return the predicted distance
%xmin = pdist2(rpc(imin,:),xu);
end

function [succ] = succ_rate3(k,u,i,umap,rmap,mydb,xx)
ru=umap(u,:);
fri=mydb(i,:);
ri = rmap(i,:);
diff = abs(ru-fri);
[rdff,idx]=sort(diff);

%ru(idx(35-k+1:35)) = ri(idx(35-k+1:35))*0.9; % cant' precisely control! make it easy! magic number!
ru(idx(35-k+1:35)) = fri(idx(35-k+1:35))*0.95; % cant' precisely control! make it easy! magic number!
%dist=pdist2(ru,ri);

drop_ap=idx(end-(xx/1)+1:end);
%drop_ap=[drop_ap,idx(1:(xx/2))];
ru(drop_ap) = [];
ri(drop_ap) = [];
rmap(:,drop_ap) = [];
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
