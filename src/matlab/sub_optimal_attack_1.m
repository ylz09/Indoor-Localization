function [ret] = sub_optimal_attack_1(u,k,mv,R,ru,rpc,xu)
% ru: the user rss vector
% xu: the coordinates of u
xmax = -1;  % the max distance, practical thing we care about
rmax = []; % the max rss, ignore it now
imax = -1; % the max index

tmp = ru;

for i=1:72 % we have 72 rp

    feasible = 1;
    ri = R(i,:);
    ru = tmp;
    diff = abs(ru-ri);
    dui = 0;
    % step1: get the min distance between ru and ri
    [rdff,idx]=sort(diff);
    
    % find the (35-k) minimal pairs for two given rss vector 
    % and cal the L2 norm(euclidean distance)
    for ii = 1:35-k
        dui = dui+rdff(ii)^2;
    end
    
    % step1+: change last k elements of ru the same as ri
    % all the remain k pairs are equal, how to add noise if not optimal?    

    for ii = 35-k+1:35
        ru(idx(ii)) = ri(idx(ii));
%         var = mv*randn(1);
%         temp=ri(idx(ii))+var;
%         ru(idx(ii)) = temp;
%         %var=ru(idx(ii))-temp;
%         noise = var*var;
%         dui = dui + noise;
    end

    % step2: check whether dui is feasible
    %disp('feasible checking...\n')
    for j = 1:72
        if i == j || j==u % skip ri
            continue;
        end
        rj = R(j,:);
        if sqrt(dui) > pdist2(ru,rj) % pdist2, euclidean distance of ru rj
            feasible = 0;
            break;
        end
        %fprintf('dui: %4.2f, duj; %4.2f\n',sqrt(dui),pdist2(ru,rj));
    end
    %fprintf('feasible: %d\n',feasible);
    
    % step3: if ri is feasible, we test whether it's the maximum false
    % measurement we can achieve
    if feasible == 1
        xi = rpc(i,:);
        xui = pdist2(xu,xi); % xu xi is the coordinates of the ru and ri
        %disp(xui)
        if xmax < xui 
            imax = i;
            rmax = ri;
            xmax = xui;
        end
    end        
    
    % step4: special case 
    if dui ==0 %|| k == 35
        imax = 0; xmax = -1;
        for id=1:size(rpc,1)
            if xmax < pdist2(xu,rpc(id,:))
                xmax = pdist2(xu,rpc(id,:));
                imax = id;
            end
        end
    end

end

% if xmax == -1
%     imax=randperm(72,1)
%     xmax = pdist2(xu,rpc(imax,:));
% end

ret = [imax, xmax];
end

    