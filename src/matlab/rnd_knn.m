load 'rssMap.mat'; % R
load 'userMap.mat';% U
load rpc.mat rpc; % coordinates of reference point
load upc.mat upc; % coordinates of user      point

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

res=zeros(1,360); 
map=R(:,:,1);

for i=1:360
%     fprintf("cnk: User indxe: %d, k: %d\n",i,k-1);
%     tmp=rss;
    ru = U(i,:);
    xu = upc(i,:); % current user rss and coordinates    
    res(i)=knn(ru,map,rpc,xu);
end

mean(res)

% knn, k=3
function [dist] = knn(ru,map,rpc,xu)

% rmin = 10000000;
% imin = 0;

% Not sure whether need feasible check
dist_vec=zeros(72,2);
for i = 1:72
    ri = map(i,:);
    dui = pdist2(ru,ri);
    dist_vec(i,:)=[dui,i];
%     % dk(ru,rj)
%     if dui < rmin % pdist2, euclidean distance of ru rj
%         rmin = dui;
%         imin = i;
%     end
%     %fprintf('dui: %4.2f, duj; %4.2f\n',sqrt(dui),pdist2(ru,rj));
end

res = sortrows(dist_vec,1);
first = res(1,2);
second = res(2,2);
third = res(3,2);
%coord=mean([rpc(first),rpc(second),rpc(third)])
x = mean([rpc(first,1),rpc(second,1),rpc(third,1)]);
y = mean([rpc(first,2),rpc(second,2),rpc(third,2)]);
dist=pdist2([x,y],xu);

% return the predicted distance
%xmin = pdist2(rpc(imin,:),xu);
end