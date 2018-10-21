%%  median under type3 attacker of attack1&attack2
load ./mat/rssMap.mat; % R
load ./mat/userMap.mat;% U
load ./mat/rpc.mat rpc; % coordinates of reference point
load ./mat/upc.mat upc; % coordinates of user      point
load ./mat/distribution.mat
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

%% median under type-1 attack1
universe=zeros(360,35);
avg=zeros(1,35);

for k = 1:2:25
    res=zeros(1,360);
    for i=1:10:360  
        tmp=rss;
        fprintf("atk1-t1-m: User indxe: %d, FakeAp Num: %d\n",i,k);
        ru = U(i,:); 
        xu = upc(i,:); % current user rss and coordinates
        
        %res(i)=optimal_attack_knn(i,k,tmp,ru,rpc,xu);
        %[fid,imax]=def_atk1_type3(i,k,mv,rss,ru,rpc,xu);
        [fid,imax]=optimal_attack_knn(i,k,tmp,ru,rpc,xu);
        ri=rss(imax,:);
        % knn
        %res(i)=knn(fake_rss,tmp,rpc,xu);
        
        % kon: random drop k APs readings
        % first change to worst case
        ru(fid(end-k+1:end))=ri(fid(end-k+1:end));

        idx = medi(ru,tmp);
        res(i) = pdist2(rpc(idx,:),xu);
    end
    avg(k)= mean(res(1:10:360));
    universe(:,k)=res; % k layer
end

universe_a1t1_median=universe;
avg_a1t1_median=avg;
save ./mat/avg_a1t1_median.mat universe_a1t1_median avg_a1t1_median;


%% median under type-3 attack1
universe=zeros(360,35);
avg=zeros(1,35);

for k = 1:2:25
    res=zeros(1,360);
    for i=1:10:360  
        tmp=rss;
        fprintf("atk1-t3-m: User indxe: %d, FakeAp Num: %d\n",i,k);
        ru = U(i,:); 
        xu = upc(i,:); % current user rss and coordinates
        
        %res(i)=optimal_attack_knn(i,k,tmp,ru,rpc,xu);
        [fid,imax]=def_atk1_t3(i,k,mv,rss,ru,rpc,xu);
        ri=rss(imax,:);
        ru(fid(end-k+1:end))=ri(fid(end-k+1:end));

        idx = medi(ru,tmp);
        res(i) = pdist2(rpc(idx,:),xu);
    end
    avg(k)= mean(res(1:10:360));
    universe(:,k)=res; % k layer
end

universe_a1t3_median=universe;
avg_a1t3_median=avg;
save ./mat/avg_a1t3_median.mat universe_a1t3_median avg_a1t3_median;


%% 
function [first] = medi(ru,map)   

dist_vec=zeros(72,2);
for i = 1:72
    ri = map(i,:);
    dui = median((ru-ri).^2);
    dist_vec(i,:)=[dui,i];
%     % dk(ru,rj)
%     if dui < rmin % pdist2, euclidean distance of ru rj
%         rmin = dui;
%         imin = i;
%     end
%     %fprintf('dui: %4.2f, duj; %4.2f\n',sqrt(dui),pdist2(ru,rj));
end

res = sortrows(dist_vec,1);
first= res(1,2);

end







