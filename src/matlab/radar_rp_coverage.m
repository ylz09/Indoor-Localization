load ./mat/rssMap.mat; % R
load ./mat/userMap.mat;% U

map = R(:,:,1);
[m,n]=size(map);

U=[U;map];
U=sortrows(U,1);
u=size(U,1);

cnt=[];
    
for p=1:u
    res=[];
    for i=1:p
        ru=U(i,:);
        min = 10000000;
        loc=0;
        for j=1:m
            rj=map(j,:);
            dist = pdist2(ru,rj);
            if dist < min
                min=dist;
                loc=j;
            end
        end
        res=[res,loc];
    end
    cnt(p)=size(unique(res),2);
end

save ./mat/radar_cover_test.mat cnt;


