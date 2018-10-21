%function [res] = test_log(dir,no,M) % Tnput including files
%function [res] = test(U,M)  %Input is just a mean matrix
function [res] = test(U, M, k, f)  % test is same as { weightcnk_test }

% modify the user data

load rpc.mat rpc;
load upc.mat upc;
%u = U(:,:,1);   % for map 3d self test
u=U;
if f == 0
    fake_map = u;
else
    fake_map = u; 
    fake_map(:,end-f:end) = -90; 
end

[x,y] = size(u);
%match used the log method
% if no <19
%     p = 'a';
% elseif no < 37
%     p = 'b';
%     no=no-18;
% elseif no < 57
%     p = 'c';
%     no=no-36;
% else
%     p = 'd';
%     no=no-56;
% end

%%
% This part test all the original input of the training data
% This method doesn't make sense

% landmark_file = sprintf('%s/%s%d.txt',dir,p,no);
% %disp(landmark_file)
% matrix = importdata(landmark_file);
% [m,n] = size (matrix);
%%
% This part test the mean rss value of each landmark
% The mean come from the rss map learned before, which F/C

[x,y] = size(u);
% matrix = F(no, :, 1);
% m=1;

%%
res = zeros(x,4);
for i = 1 : x
    matrix = fake_map(i, :);
    %d0 = 0; d1 = 0; d2 = 0; d3 = 0; d4 = 0;
    tmp = predictLocation_weight(matrix,M,k);
    %tmp = predictLocation(matrix,M);
    
%     %res(i) = tmp(1);
%     if tmp(1) == i
%         d0 = d0+1;
%     elseif min(abs(x-tmp(1)+i),abs(tmp(1)-i)) <= 1 % max(abs(tmp(1)+m-no),abs(tmp(1)-no))
%         d1 = d1 +1;
%     elseif min(abs(x-tmp(1)+i),abs(tmp(1)-i)) <= 2
%         d2 = d2 +1;
%     elseif min(abs(x-tmp(1)+i),abs(tmp(1)-i)) <= 3
%         d3 = d3 +1;
%     else
%         d4 = d4+1;
%     end
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
%     
%     %res(i)=horzcat(tmp(1),[d0,d1,d2,d3,d4,x,(d0+d1+d2+d3)/x]);
%     res(i,:)=[tmp(1),d0,d1,d2,d3,d4,x,(d0+d1+d2+d3)];
end
