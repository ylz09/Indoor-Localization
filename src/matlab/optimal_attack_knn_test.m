%% atk1: type1 with defense by drop 2/4/8 fake APs
h = figure;

%clc
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

% %% get the maximum error distance without cnk
% universe1=zeros(360,2,35);
% avg1=zeros(1,35);
% 
% for k = 1:35
%     res=zeros(360,2);     
%     for i=1:360        
%         fprintf("atk1: User indxe: %d, FakeAp Num: %d\n",i,k);
%         ru = U(i,:); xu = upc(i,:); % current user rss and coordinates
%         res(i,:)=optimal_attack(i,k,rss,ru,rpc,xu);
%     end
%     avg1(k)= mean(res(:,2));
%     universe1(:,:,k)=res; % k layer
% end
% %save avg_opt_dist.mat universe1 avg1;

%% get the maximum error distance with cnk
universe=zeros(360,35);
avg=zeros(1,35);

for k = 1:2:25
    res=zeros(1,360);
    for i=1:10:360  
        tmp=rss;
        fprintf("atk1: User indxe: %d, FakeAp Num: %d\n",i,k);
        ru = U(i,:); 
        xu = upc(i,:); % current user rss and coordinates
        
        %res(i)=optimal_attack_knn(i,k,tmp,ru,rpc,xu);
        [fid,imax]=optimal_attack_knn(i,k,rss,ru,rpc,xu);
        ri=rss(imax,:);
        % knn
        %res(i)=knn(fake_rss,tmp,rpc,xu);
        
        % kon: random drop k APs readings
        % first change to worst case
        ru(fid(end-k+1:end))=ri(fid(end-k+1:end));
        
        % second: drop strategy:
        % drop best 2 and worst 2
        xx=2;
        drop_ap=fid(end-xx-1:end);
        drop_ap=[drop_ap,fid(1:xx)];
        ru(drop_ap) = []; % randomly generate K fake RSS btw
        tmp(:,drop_ap) = [];
        idx = rnd_cnk(ru,tmp);
        res(i) = pdist2(rpc(idx,:),xu);
    end
    avg(k)= mean(res(1:10:360));
    universe(:,k)=res; % k layer
end

universe_minmax2=universe;
avg_minmax2=avg;
save avg_opt_dist_minmax2.mat universe_minmax2 avg_minmax2;

%save avg_opt_dist_knn.mat universe_knn avg_knn;

%% get the maximum error distance with cnk
universe=zeros(360,35);
avg=zeros(1,35);

for k = 1:2:25
    res=zeros(1,360);
    for i=1:10:360  
        tmp=rss;
        fprintf("atk2: User indxe: %d, FakeAp Num: %d\n",i,k);
        ru = U(i,:); 
        xu = upc(i,:); % current user rss and coordinates
        
        %res(i)=optimal_attack_knn(i,k,tmp,ru,rpc,xu);
        [fid,imax]=optimal_attack_knn(i,k,rss,ru,rpc,xu);
        ri=rss(imax,:);
        % knn
        %res(i)=knn(fake_rss,tmp,rpc,xu);
        
        % kon: random drop k APs readings
        % first change to worst case
        ru(fid(end-k+1:end))=ri(fid(end-k+1:end));
        
        % second: drop strategy:
        % drop best 4 and worst 4
        xx=4;
        drop_ap=fid(end-xx-1:end);
        drop_ap=[drop_ap,fid(1:xx)];
        ru(drop_ap) = []; % randomly generate K fake RSS btw
        tmp(:,drop_ap) = [];
        idx = rnd_cnk(ru,tmp);
        res(i) = pdist2(rpc(idx,:),xu);
    end
    avg(k)= mean(res(1:10:360));
    universe(:,k)=res; % k layer
end

universe_minmax4=universe;
avg_minmax4=avg;
save avg_opt_dist_minmax4.mat universe_minmax4 avg_minmax4;

%% get the maximum error distance with cnk
universe=zeros(360,35);
avg=zeros(1,35);

for k = 1:2:25
    res=zeros(1,360);
    for i=1:10:360  
        tmp=rss;
        fprintf("atk3: User indxe: %d, FakeAp Num: %d\n",i,k);
        ru = U(i,:); 
        xu = upc(i,:); % current user rss and coordinates
        
        %res(i)=optimal_attack_knn(i,k,tmp,ru,rpc,xu);
        [fid,imax]=optimal_attack_knn(i,k,rss,ru,rpc,xu);
        ri=rss(imax,:);
        % knn
        %res(i)=knn(fake_rss,tmp,rpc,xu);
        
        % kon: random drop k APs readings
        % first change to worst case
        ru(fid(end-k+1:end))=ri(fid(end-k+1:end));
        
        % second: drop strategy:
        % drop best 8 and worst 8
        xx=8;
        drop_ap=fid(end-xx-1:end);
        drop_ap=[drop_ap,fid(1:xx)];
        ru(drop_ap) = []; % randomly generate K fake RSS btw
        tmp(:,drop_ap) = [];
        idx = rnd_cnk(ru,tmp);
        res(i) = pdist2(rpc(idx,:),xu);
    end
    avg(k)= mean(res(1:10:360));
    universe(:,k)=res; % k layer
end

universe_minmax8=universe;
avg_minmax8=avg;
save avg_opt_dist_minmax8.mat universe_minmax8 avg_minmax8;

%% set the figure properties
plot(avg,'-b*','MarkerSize',6,'LineWidth',1)
axis([1 35 0 26]) %same as xlim & ylim
grid on
% xlim([1 35])
% ylim([0 25])
xlabel('Number of APs under control')
ylabel('Average maximum error distance of 360 test points(m)')

%set(gca,'XTick',[1:2:35])
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')

%% affiliated functions
function [dist] = knn(ru,u,map,rpc,xu)
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

% random k out of n algorith without attack
function [xmin] = rnd_cnk(ru,map)
rmin = 10000000;
imin = 0;
% Not sure whether need feasible check
for i = 1:72
    ri = map(i,:);
    dui = pdist2(ru,ri);
    
    % dk(ru,rj)
    if dui < rmin % pdist2, euclidean distance of ru rj
        rmin = dui;
        imin = i;
    end
    %fprintf('dui: %4.2f, duj; %4.2f\n',sqrt(dui),pdist2(ru,rj));
end
% return the predicted index
xmin = imin;
end


