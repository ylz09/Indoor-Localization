% random k out of n algorith without attack
function [xmin] = rnd_cnk(ru,map,rpc,xu)

rmin = 10000000;
imin = 0;
xmin = 100;
% Not sure whether need feasible check

for i = 1:72
    ri = map(i,:);
    dui = pdist2(ru,ri);

    % dk(ru,rj)
    xui = pdist2(rpc(i,:),xu);
    if dui < rmin && xui < xmin% pdist2, euclidean distance of ru rj
        rmin = dui;
        imin = i;
        xmin = xui;
    end
    %fprintf('dui: %4.2f, duj; %4.2f\n',sqrt(dui),pdist2(ru,rj));
end

% return the predicted distance
%xmin = pdist2(rpc(imin,:),xu);