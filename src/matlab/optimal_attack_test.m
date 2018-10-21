%% atk1: type1, optimal atk
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
universe_cnk=zeros(360,2,35);
avg_cnk=zeros(1,35);

for k = 1:35
    res=zeros(360,2);
    for i=1:360  
        tmp=rss;
        fprintf("atk1: User indxe: %d, FakeAp Num: %d\n",i,k);
        ru = U(i,:); 
        xu = upc(i,:); % current user rss and coordinates
        
        % random drop k APs readings, k=5
        drop_ap = randperm(35,5);
        ru(drop_ap) = 10; % randomly generate K fake RSS btw
        tmp(:,drop_ap) = 10;
        res(i,:)=optimal_attack_2(i,k,tmp,ru,rpc,xu);
    end
    avg_cnk(k)= mean(res(:,2));
    universe_cnk(:,:,k)=res; % k layer
end
universe_rnd5=universe_cnk;
avg_rnd5=avg_cnk;

save avg_opt_dist_rnd5.mat universe_rnd5 avg_rnd5;
%% set the figure properties
plot(avg_cnk,'-b*','MarkerSize',6,'LineWidth',1)
axis([1 35 0 26]) %same as xlim & ylim
grid on
% xlim([1 35])
% ylim([0 25])
xlabel('Number of APs under control')
ylabel('Average maximum error distance of 360 test points(m)')

%% routine, just for figure output format
%set(gca,'XTick',[1:2:35])
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')