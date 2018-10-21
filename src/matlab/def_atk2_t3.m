%% Test the effect of different lambda, which means the number of 2-side drop
%% header, preprocessing
%h = figure;
clear;
%load fakeDB.mat %fdb
load ./mat/rssMap.mat; % R
load ./mat/userMap.mat;% U
load ./mat/rpc.mat rpc; % coordinates of reference point
load ./mat/upc.mat upc; % coordinates of user      point
load ./mat/distribution.mat;

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

%% 
umap=U;
rmap=rss;

% k = 1000;
% uids = randperm(360,360);
% uids = [uids,randperm(360,360)];
% uids = [uids,randperm(360,280)];
% iids = randperm(72,72);
% for i=1:12
%     iids = [iids,randperm(72,72)];
% end
% iids = [iids,randperm(72,64)];
load ./mat/pairs1000.mat
k = 1000;
% load ./mat/paris_ks.mat       % save paris_ks.mat iids uids; 
% k = 200;
% uids = randperm(360,k); % 100 random number in [1..360]
% iids = randperm(72,72);
% iids = [iids,randperm(72,72)];
% iids = [iids,randperm(72,56)];

mydb=fdb;

svec1=zeros(k,30);
rates3_0=[];
for p=1:30
    rate=0;
    sums=0;
    fprintf('Target-partial rates of %d fake APs\n',p);
    
    for j=1:k
        u=uids(j);
        i=iids(j);
        xx=0;        % xx mean drop how many aps
        [tmp,z]=succ_rate3(p-1,u,i,umap,rmap,mydb,xx,mv);
        svec1(j,z:end)=1;
        sums=sums+tmp;
    end
    rate=sums/k;
    rates3_0=[rates3_0,rate];
end

svec2=zeros(k,30);
rates3_8=[];
for p=1:30
    rate=0;
    sums=0;
    fprintf('Target-partial rates of %d fake APs\n',p);
    
    for j=1:k
        u=uids(j);
        i=iids(j);
        xx=8;        
        [tmp,z]=succ_rate3(p-1,u,i,umap,rmap,mydb,xx,mv);
        svec2(j,z:end)=1;
        sums=sums+tmp;
    end
    rate=sums/k;
    rates3_8=[rates3_8,rate];
end
% 
svec3=zeros(k,30);
rates3_16=[];
for p=1:30
    rate=0;
    sums=0;
    fprintf('Target-partial rates of %d fake APs\n',p);
    
    for j=1:k
        u=uids(j);
        i=iids(j);
        xx=16;        
        [tmp,z]=succ_rate3(p-1,u,i,umap,rmap,mydb,xx,mv);
        svec3(j,z:end)=1;
        sums=sums+tmp;
    end
    rate=sums/k;
    rates3_16=[rates3_16,rate];
end
% 
svec4=zeros(k,30);
rates3_24=[];
for p=1:30
    rate=0;
    sums=0;
    fprintf('Target-partial rates of %d fake APs\n',p);
    
    for j=1:k
        u=uids(j);
        i=iids(j);
        xx=24;        
        [tmp,z]=succ_rate3(p-1,u,i,umap,rmap,mydb,xx,mv);
        svec4(j,z:end)=1;
        sums=sums+tmp;
    end
    rate=sums/k;
    rates3_24=[rates3_24,rate];
end

svec5=zeros(k,30);
rates3_34=[];
for p=1:30
    rate=0;
    sums=0;
    fprintf('Target-partial rates of %d fake APs\n',p);
    
    for j=1:k
        u=uids(j);
        i=iids(j);
        xx=34;        
        [tmp,z]=succ_rate3(p-1,u,i,umap,rmap,mydb,xx,mv);
        svec5(j,z:end)=1;
        sums=sums+tmp;
    end
    rate=sums/k;
    rates3_34=[rates3_34,rate];
end

save ./mat/bit_vec_aps_1k.mat svec1 svec2 svec3 svec4 svec5;
% save bit_vec_aps.mat svec1 svec2 svec3 svec4 svec5;
% save succ_ratio_ks.mat rates3_0 rates3_8 rates3_16 rates3_24 rates3_34;
% save paris_ks.mat iids uids;
def_atk2_t3_fig

function [succ,z] = succ_rate3(k,u,i,umap,rmap,mydb,xx,mv)
z=31; % z means the minimal fake ap number needed to attack successfully

%ru(idx(35-k+1:35)) = fri(idx(35-k+1:35))*0.95; % cant' precisely control! make it easy! magic number!
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
    
    tmp = ru;
    drop=idx(end-ceil(xx/2)+1:end);
    drop=[idx(1:floor(xx/2)),drop];
    ru(drop)=[];
    ri(drop)=[];
    dist=pdist2(ru,ri);
    %rmap(:,drop)=[];
    succ=1;
    for j=1:72
        if j == i %|| j==u
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
            break;
        end
    end
    if succ==1
        z=s;
        return;
    end
end
succ=0;
end

