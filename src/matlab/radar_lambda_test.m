%% header, preprocessing
% Used to draw figure: lambda_test_fig
% Output: For the radar method with different 2-side k
%           get the average error distance & median error distance

clear
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
    mean_per_rp = R(i,:,1)*1.13; % A simplified way to learn db, it's better than average of user rss
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

%% Show how the error distance change with 2-side k
umap=U;
rmap=rss;
% k = 360;
% uids = randperm(360,k); % 100 random number in [1..360]
% iids = randperm(72,k);
% load pairs.mat

num=360; % user test locations
dist3=zeros(35,num);
for k=1:2:35 % each side drop k rss readings
    fprintf('Radar under lambda: %d test\n',k);
    klog=zeros(1,num);
    for j=1:num
        xu=upc(j,:);
        klog(j)=radar_lambda(k-1,j,umap,rmap,xu,rpc);
    end
    dist3(k,:)=klog;
end

save ./mat/lambda_dist.mat;
radar_lambda_test_fig

function [xmin] = radar_lambda(lm,u,umap,rmap,xu,rpc)
xmin=50;
tmp=umap(u,:);
min = 10000000;

for j=1:72 % 72 reference points in rmap
    rj=rmap(j,:);
    ru=tmp;
    
    diff = abs(ru-rj); 
    [rdff,idx]=sort(diff);
    drop=idx(end-(lm/2)+1:end);
    drop=[idx(1:(lm/2)),drop];
    ru(drop)=[];
    rj(drop)=[];
    
    d = pdist2(ru,rj);
    if d < min
        imin= rpc(j,:);
        xmin=pdist2(imin,xu) ;
        min=pdist2(ru,rj); % do not forget this!
    end
end

end







