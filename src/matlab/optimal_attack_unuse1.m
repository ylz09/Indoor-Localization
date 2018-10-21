% The attacker knows exactly the database and can precisely contron the AP
% Input: u: index of user data; k: number of AP I can control
% Output: the maximum deviation paras: rp index, rp rss(by choice), distance

function [ret] = optimal_attack(u,k,R,ru,rpc,xu)
% ru: the user rss vector
% xu: the coordinates of u
xmax = 0;  % the max distance, practical thing we care about
rmax = []; % the max rss, ignore it now
imax = -1; % the max index
tempu = sort(ru);

for i=1:72 % we have 72 rp

    feasible = 1;
    ri = R(i,:);
    ru = tempu;
    ri = sort(ri);
    dui = 0;
    % step1: get the min distance between ru and ri
    ru1 = ru; ri1 = ri; % back up ru and ri
    
    idxu=java.util.HashSet;
    idxi=java.util.HashSet;
    for si=1:35
        idxu.add(si);
        idxi.add(si);
    end
    %fprintf('Is r%d feasible?\n',i);
    for j=1:(35-k) % find the (35-k) minimal pairs for two given rss vector
        x=1;y=1;
        min = 10000; minx = 0; miny=0;
        while x <= size(ru1,2) && y <= size(ri1,2) %after while loop, will find 1 pair
            if ru1(x) ==1
                x=x+1;continue
            end
            if ri1(y) ==1
                y=y+1;continue
            end
            
            if abs(ru1(x) - ri1(y)) < min % update the minimal pair
                min = abs(ru1(x) - ri1(y));
                minx = x; miny=y;
            end
            if ru1(x) < ri1(y)
                x = x+1;
            else
                y = y+1;
            end
        end
        ru1(minx)=(1);ri1(miny)=(1); %delete the used pair!
        idxu.remove(minx);idxi.remove(miny); %delete the index 
        dui = dui + min*min; 
    end
    
    % step1+: change last k elements of ru the same as ri
    % all the remain k pairs are equal, how to add noise if not optimal?    
    it1 = idxu.iterator(); %crazy java code!
    it2 = idxi.iterator();
    while it1.hasNext() && it2.hasNext()
        ru(it1.next()) = ri(it2.next());
    end    
%     for ii=35-k+1:35
%         ru(ii) = ri(ii);
%     end
    
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
sqrt(dui);
ret = [imax, xmax];
end

    