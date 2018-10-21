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

%%
umap=U;
rmap=rss;
k = 200;
% uids = randperm(360,k); % 100 random number in [1..360]
% iids = randperm(72,72);
% iids = [iids,randperm(72,72)];
% iids = [iids,randperm(72,56)];

%save pairs.mat uids iids
load ./mat/pairs.mat

mydb=fdb;
rates_lm_0=[];
for lm=1:35
    rate=0;
    sum=0;
    fprintf('Target-partial rates of %d fake APs\n',lm);
    for j=1:k
        u=uids(j);
        i=iids(j);
        n=0;
        sum=sum+succ_rate3(lm-1,u,i,umap,rmap,mydb,n);
    end
    rate=sum/k;
    rates_lm_0=[rates_lm_0,rate];
end

% mydb=fdb;
% rates_lm_8=[];
% for lm=1:35
%     rate=0;
%     sum=0;
%     fprintf('Target-partial rates of %d fake APs\n',lm);
%     for j=1:k
%         u=uids(j);
%         i=iids(j);
%         n=8;
%         sum=sum+succ_rate3(lm-1,u,i,umap,rmap,mydb,n);
%     end
%     rate=sum/k;
%     rates_lm_8=[rates_lm_8,rate];
% end
% 
% mydb=fdb;
% rates_lm_16=[];
% for lm=1:35
%     rate=0;
%     sum=0;
%     fprintf('Target-partial rates of %d fake APs\n',lm);
%     for j=1:k
%         u=uids(j);
%         i=iids(j);
%         n=16;
%         sum=sum+succ_rate3(lm-1,u,i,umap,rmap,mydb,n);
%     end
%     rate=sum/k;
%     rates_lm_16=[rates_lm_16,rate];
% end
% 
% mydb=fdb;
% rates_lm_20=[];
% for lm=1:35
%     rate=0;
%     sum=0;
%     fprintf('Target-partial rates of %d fake APs\n',lm);
%     for j=1:k
%         u=uids(j);
%         i=iids(j);
%         n=20;
%         sum=sum+succ_rate3(lm-1,u,i,umap,rmap,mydb,n);
%     end
%     rate=sum/k;
%     rates_lm_20=[rates_lm_20,rate];
% end
% 
% mydb=fdb;
% rates_lm_24=[];
% for lm=1:35
%     rate=0;
%     sum=0;
%     fprintf('Target-partial rates of %d fake APs\n',lm);
%     for j=1:k
%         u=uids(j);
%         i=iids(j);
%         n=24;
%         sum=sum+succ_rate3(lm-1,u,i,umap,rmap,mydb,n);
%     end
%     rate=sum/k;
%     rates_lm_24=[rates_lm_24,rate];
% end
% 
% save lambda_diffk.mat rates_lm_8 rates_lm_16 rates_lm_20 rates_lm_24;

function [succ] = succ_rate3(lm,u,i,umap,rmap,mydb,k)
ru=umap(u,:);
fri=mydb(i,:);
diff = abs(ru-fri);
[rdff,idx]=sort(diff);
ri = rmap(i,:);

%     for ii = 35-k+1:35
%         ru(idx(ii)) = ri(idx(ii));
% %         var = mv*randn(1);
% %         temp=ri(idx(ii))+var;
% %         ru(idx(ii)) = temp;
% %         %var=ru(idx(ii))-temp;
% %         noise = var*var;
% %         dui = dui + noise;
%     end
%ru(idx(35-k+1:35)) = fri(idx(35-k+1:35))*0.95; % cant' precisely control! make it easy! magic number!
for ii = 35-k+1:35
    var = mv*randn(1);
    temp=fri(idx(ii))+var;
    ru(idx(ii)) = temp;
end

tmp = ru;
drop=idx(end-ceil(lm/2)+1:end);
drop=[idx(1:floor(lm/2)),drop];
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
    tdrop = tidx(end-ceil(lm/2)+1:end);
    tdrop = [tidx(1:floor(lm/2)),drop];
    ru(tdrop)=[];
    rj(tdrop)=[];
    if pdist2(ru,rj) < dist
        succ=0;
        return;
    end
end
succ=1;

end
