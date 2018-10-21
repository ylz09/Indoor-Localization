
function [res] = test_log(U,M,kap)  %kap mean cnk k unused ap

load rpc.mat rpc;
load upc.mat upc;
%%
U(:,kap)=[];
M(:,kap,:)=[];

[x,y] = size(U);
disp(size(U))

res = zeros(x,4);
for i = 1 : x
    matrix = U(i, :);
    tmp = predictLocation_log(matrix,M);
    rp = rpc(tmp(1),:);
    %up = rpc(i,:); % for self test
    up = upc(i,:);
    d = pdist([rp;up]);
    % if d < 3m, then we say is matched. 
    tag=0;
    if d < 3
        tag = 1;
    end
    res(i,:)=[i,tmp(1),d,tag];
    

end
