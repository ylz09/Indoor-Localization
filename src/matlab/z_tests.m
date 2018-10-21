clear;clc;
load rssMap.mat
load sigleMap.mat

rss=[];
for i = 1:76
    %rss=zeros(1,1);
    rss(i,:)=test('rssdata',i,R);
end

cc=[];
for i = 1:76
    %cc=zeros(1,1);
    cc(i,:)=test('cc',i,S);
end

%histogram 不同颜色的画法：
hist(rss,76)
hold on
hist(cc,76)
hist = findobj(gca, 'Type','patch');
set(hist (1), 'FaceColor','r', 'EdgeColor','w')
set(hist (2), 'FaceColor','b', 'EdgeColor','w')
legend('all','single')
title('Test result')
xlabel('landmark index') % x-axis label
ylabel('number of landmarks matched') % y-axis label
