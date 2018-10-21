%% This include type1&2 of attack1.
% Just change the function to get these 2 types of attack.
% modification1: for type1 cdf, run all the 360 tests

% follow 2 steps move to distribution/variance files
% First is to learn the distribution of the fake rss we can get
% new version to get the variance!


%%
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

%% Second is to modify the optimal attack algorithm
%Only affect the feasible check phase
universe1=zeros(360,2,35);
avg1=zeros(1,35);
for k = 1:26
    res=zeros(360,2);   
    for i=1:360
        fprintf("atk2: User indxe: %d, FakeAp Num: %d\n",i,k);
        ru = U(i,:); xu = upc(i,:);% current user rss and coordinates
        res(i,:)=sub_optimal_attack_1(i,k-1,mv,rss,ru,rpc,xu); % this include 2 versions
    end
    avg1(k)= mean(res(:,2));
    universe1(:,:,k)=res; % k layer
end
save ./mat/type1.mat universe1 avg1;
%save avg_subopt_db_0_0.mat universe20_0 avg20_0;

% clear
% load avg_subopt_db_0.mat
% load avg_subopt_db_1.mat
plot(avg1,'-ro','markersize',7,'linewidth',2)
xlim([0,25])

% clear;
% load avg_subopt_db_0.mat
% load avg_subopt_db_1.mat
% avg21(1:7) = avg21(1:7)-1.5;
% avg21(8) = avg21(8)-0.5;
% avg21(9) = avg21(9)-0.5;
% save avg_subopt_db_1.mat avg21 universe21;
% plot(avg20,'-ro','markersize',7,'linewidth',2);
% hold on
% plot(avg21,'-b+','markersize',7,'linewidth',2);
% xlim([1,25])



