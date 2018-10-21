% 1 given pair data set, get the minial APs need to be attacked
% 2 given attacked AP number, the probability of successful decieve user

%% header, preprocessing
%h = figure;
clear;
%load fakeDB.mat %fdb
load ./mat/rssMap.mat; % R
load ./mat/userMap.mat;% U
load ./mat/rpc.mat rpc; % coordinates of reference point
load ./mat/upc.mat upc; % coordinates of user      point
load ./mat/distribution.mat


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


k = 1000;
uids = randperm(360,360);
uids = [uids,randperm(360,360)];
uids = [uids,randperm(360,280)];

iids = randperm(72,72);
for i=1:12
    iids = [iids,randperm(72,72)];
end
iids = [iids,randperm(72,64)];


%save pairs.mat uids iids
%load pairs.mat

% target-partial
mydb=fdb;
rates3_0=[];
for p=1:30
    rate=0;
    sum=0;
    fprintf('Target-partial rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        xx=0;
        sum=sum+succ_rate3(p-1,u,i,umap,rmap,mydb,xx);
    end
    rate=sum/k;
    rates3_0=[rates3_0,rate];
end

% target-partial
mydb=fdb;
rates3_8=[];
for p=1:30
    rate=0;
    sum=0;
    fprintf('Target-partial rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        xx=8;
        sum=sum+succ_rate3(p-1,u,i,umap,rmap,mydb,xx);
    end
    rate=sum/k;
    rates3_8=[rates3_8,rate];
end

% target-partial
mydb=fdb;
rates3_16=[];
for p=1:30
    rate=0;
    sum=0;
    fprintf('Target-partial rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        xx=16;
        sum=sum+succ_rate3(p-1,u,i,umap,rmap,mydb,xx);
    end
    rate=sum/k;
    rates3_16=[rates3_16,rate];
end

mydb=fdb;
rates3_26=[];
for p=1:30
    rate=0;
    sum=0;
    fprintf('Target-partial rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        xx=26;
        sum=sum+succ_rate3(p-1,u,i,umap,rmap,mydb,xx);
    end
    rate=sum/k;
    rates3_26=[rates3_26,rate];
end

% target-partial
mydb=fdb;
rates3_30=[];
for p=1:30
    rate=0;
    sum=0;
    fprintf('Target-partial rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        xx=30;
        sum=sum+succ_rate3(p-1,u,i,umap,rmap,mydb,xx);
    end
    rate=sum/k;
    rates3_30=[rates3_30,rate];
end

mydb=fdb;
rates3_34=[];
for p=1:30
    rate=0;
    sum=0;
    fprintf('Target-partial rates of %d fake APs\n',p);
    for j=1:k
        u=uids(j);
        i=iids(j);
        xx=34;
        sum=sum+succ_rate3(p-1,u,i,umap,rmap,mydb,xx);
    end
    rate=sum/k;
    rates3_34=[rates3_34,rate];
end

mydb=fdb;
rates_lm_=[];
for lm=1:35
    rate=0;
    sum=0;
    fprintf('Target-partial rates of %d fake APs\n',lm);
    for j=1:k
        u=uids(j);
        i=iids(j);
        k=8;
        sum=sum+succ_rate3(lm-1,u,i,umap,rmap,mydb,xx);
    end
    rate=sum/k;
    rates3_34=[rates3_34,rate];
end


% Target-random attack
% rates4=[];
% for p=1:30
%     r=0;
%     sum=0;
%     fprintf('Target-random rates of %d fake APs\n',p);
%     
%     for j=1:k
%         u=uids(j);
%         i=iids(j);
%         ru=umap(u,:);
%         ri=rmap(i,:);
%         ru(randperm(35,p-1)) = -randperm(100,p-1);
%         dist=pdist2(ru,ri);
%         feasible=feasible_check(dist,ru,u,i,rmap);
%         if feasible == 1
%             sum=sum+1;
%         end
%     end   
%     
%     r=sum/k;
%     rates4=[rates4,r];
% end

save ./mat/target_trk.mat rates3_0 rates3_8 rates3_16 rates3_26 rates3_30 rates3_34;
trk_k_atk2_fig

%% 2 problem

function [succ] = succ_rate3(k,u,i,umap,rmap,mydb,xx)
ru=umap(u,:);
fri=mydb(i,:);
diff = abs(ru-fri);
[rdff,idx]=sort(diff);
ri = rmap(i,:);

ru(idx(35-k+1:35)) = fri(idx(35-k+1:35))*0.95; % cant' precisely control! make it easy! magic number!
tmp = ru;
drop=idx(end-ceil(xx/2)+1:end);
drop=[idx(1:floor(xx/2)),drop];
ru(drop)=[];
ri(drop)=[];
dist=pdist2(ru,ri);
%rmap(:,drop)=[];

for j=1:72
    if j == i || j==u
        continue;
    end
    rj=rmap(j,:);
    ru=tmp;
    [tdiff,tidx] = sort(abs(rj-ru));
    tdrop = tidx(end-ceil(xx/2)+1:end);
    tdrop = [tidx(1:floor(xx/2)),drop];
    ru(tdrop)=[];
    rj(tdrop)=[];
    if pdist2(ru,rj) < dist
        succ=0;
        return;
    end
end
succ=1;

end




