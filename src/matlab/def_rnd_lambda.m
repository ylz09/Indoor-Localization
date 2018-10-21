%% Baseline attack
% ru are randomly falsified by the attacker
% this ru is sent to the fingerprint database
% we just need show the error distance is very small comparing the others


% load and clean the database
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


%% For all the test data

rnd_lambda_k16=zeros(1,35);
for lambda = 1:15
    res=zeros(360,2);     
    for i=1:10:360        
        fprintf("rnd-drop: User indxe: %d, lambda: %d\n",i,lambda);
        ru = U(i,:); xu = upc(i,:); % current user rss and coordinates
        k=4;
        res(i,:)=random_attack(i,lambda-1,k,rss,ru,rpc,xu);
    end
    rnd_lambda_k16(lambda)= mean(res(1:10:360,2));
    %universe6(:,:,lambda)=res; % k layer
end
%save avg_rnd_drop.mat universe6 rnd_lambda;
save rnd_lambda_k16.mat rnd_lambda_k16;

rnd_lambda_k8=zeros(1,35);
for lambda = 1:15
    res=zeros(360,2);     
    for i=1:10:360 
        fprintf("rnd-drop: User indxe: %d, lambda: %d\n",i,lambda);
        ru = U(i,:); xu = upc(i,:); % current user rss and coordinates
        k=8;
        res(i,:)=random_attack(i,lambda-1,k,rss,ru,rpc,xu);
    end
    rnd_lambda_k8(lambda)= mean(res(1:10:360,2));
    %universe6(:,:,lambda)=res; % k layer
end
%save avg_rnd_drop.mat universe6 rnd_lambda;
save rnd_lambda_k8.mat rnd_lambda_k8;

function [ret] = random_attack(u,lambda,k,R,ru,rpc,xu)
% ru: the user rss vector
% xu: the coordinates of u
xmin = 0;  % the max distance, practical thing we care about
rmin = intmax('int64'); % the max rss, ignore it now
imin = -1; % the max index

% step1: randomly change k AP's RSS value
fake_ap = randperm(35,k);
ru(fake_ap) = -randperm(90,k); % randomly generate K fake RSS btw
% do it!!!!!!!!!!!!!!!!!!!!
if k <= lambda  % here means lambda is 8
    ru(fake_ap)=[];
    ru(1:lambda-k)=[];
    R(:,fake_ap)=[];
    R(:,1:lambda-k)=[];
else
    ru(fake_ap(end-lambda+1:end))=[];
    R(:,fake_ap(end-lambda+1:end))=[];
end
%step2: find the nearest RSS in the database
for i=1:72 % we have 72 rp

    ri = R(i,:);  
    xi = rpc(i,:);
    dui = pdist2(ru,ri);
    if rmin > dui
        rmin = dui;
        imin = i;        
        xmin = pdist2(xu,xi); % xu xi is the coordinates of the ru and ri
        %fprintf('dui: %4.2f, duj; %4.2f\n',sqrt(dui),pdist2(ru,rj));
    end
    %fprintf('feasible: %d\n',feasible);
        
    % special case 
    if dui ==0 %|| k == 35
        imin = 0; xmin = -1;
        for id=1:size(rpc,1)
            if xmin < pdist2(xu,rpc(id,:))
                xmin = pdist2(xu,rpc(id,:));
                imin = id;
            end
        end
    end

end
ret = [imin, xmin];
end

    




