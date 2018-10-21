% rnd_cnk test
clear;
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
rss = R(:,:,1); % only need mean don't need sigma,save space!

all_cnk=zeros(360,35);
avg_cnk=zeros(35);

for k = 1:35
    res=zeros(1,360);     
    for i=1:360        
        fprintf("cnk: User indxe: %d, k: %d\n",i,k-1);
        tmp=rss;
        ru = U(i,:); 
        xu = upc(i,:); % current user rss and coordinates
        
        % random drop k APs readings
        drop_ap = randperm(35,k-1);
        ru(drop_ap) = []; % randomly generate K fake RSS btw
        tmp(:,drop_ap) = [];
        res(i)=rnd_cnk(ru,tmp,rpc,xu);
    end
    avg_cnk(k)= mean(res);
    all_cnk(:,k)=res; % k layer
end

%save cnk_no_attack.mat all_cnk avg_cnk;
plot(avg_cnk,'LineWidth',2)
xlabel('The number of randomly dropped APs')
ylabel('Average error distance (m)')

% h = figure;
% plot(mean(all_cnk),'LineWidth',2)
% hold on
% xlabel('Number of APs dropped')
% ylabel('Average error distance (m)')
% legend('k-out-of-n accuracy')
% 
% set(h,'Units','Inches');
% pos = get(h,'Position');
% set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(h,'filename','-dpdf','-r0')





