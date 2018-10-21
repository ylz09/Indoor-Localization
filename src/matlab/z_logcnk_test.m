%%
function [res]= logcnk_test(U, M, k,opt, f, fap)
% k? k out of 35 APs
% opt? inner optimization number of APs, always range from 1 to 35
% f% 
% fap? fake AP vector
load rpc.mat rpc;
load upc.mat upc;

if f ~= 0
    U(:,end-f:end) = -90; 
end
if k ~= 35 % only keep the first k APs, because there's no relations of the order, it's same as randomly chosen
    M(:,k+1:end,:) = [];
    U(:,k+1:end)= [];
end

[x,y] = size(U);
res = zeros(x,4);
for i = 1 : x
    matrix = U(i, :);
    tag = 0;
    %tmp = predictLocation_weight(matrix,M,k,v);
    [tmp] = predictLocation_log_cnk(matrix,M,opt,fap);
    %[tmp] = cnn_log_opt(matrix,M,opt,fap);

    %% this is part is using the real distance
    rp = rpc(tmp(1),:);
    %up = rpc(i,:); % for self test
    up = upc(i,:);
    d = pdist([rp;up]);
    % if d < 3m, then we say is matched. 
    if d < 3
        tag = 1;
    end
    res(i,:)=[i,tmp(1),d,tag];
    %res(i)=horzcat(tmp(1),[d0,d1,d2,d3,d4,x,(d0+d1+d2+d3)/x]);
    %res(i,:)=[tmp(1),d0,d1,d2,d3,d4,x,(d0+d1+d2+d3)];
end

