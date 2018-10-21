%% header, preprocessing
h = figure;
%clc
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
%% defense: x: attacked AP number y: error distance
