% Fig. 9 probability and distribution
h=figure;
load ./mat/power_level.mat % all_power_level = cell(6,9), first 3

half1=[];
for i=1:3
    for j=1:9
        half1 = [half1;all_power_level{i,j}];
    end
end
% Second half: come from the HML.M, need to read file again
half2 = [];
for i = 1 : 20
    
    file_name = sprintf('three/%d.txt',i);
    data = importdata(file_name);
    half2 = [half2;data];
end

%all data to fit the distribution:
all = [half1;half2];
%normplot(all)
%histogram(all)
histogram(all,'Normalization','probability')
hold on
[mu,sigma]=normfit(all);
norm = normpdf([-90:0.5:-20],mu,sigma/1.3);
plot([-90:0.5:-20],norm,'k','LineWidth',2)
ylim([0,0.1])
xlim([-90,-20])
legend('statistical probability','normfit PDF')

xlabel("RSS range (dBm)",'fontsize',15)
ylabel("RSS Probablity of all test samples",'fontsize',15)
set(gca,'fontsize',15)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')

%% First is to learn the distribution of the fake rss we can get

% First half: The test data for different power and distance can be extracted from
% multi_power_level.m in load power_level.mat
% load power_level.mat % all_power_level = cell(6,9), first 3
% half1=[];
% for i=1:3
%     for j=1:9
%         half1 = [half1;all_power_level{i,j}];
%     end
% end% 
% % Second half: come from the HML.M, need to read file again
% half2 = [];
% for i = 1 : 20     
%     file_name = sprintf('three/%d.txt',i);
%     data = importdata(file_name);
%     half2 = [half2;data];
% end
% %all data to fit the distribution:
% all = [half1;half2];
% %normplot(all)
% %histogram(all)
% %histogram(all,'Normalization','probability')
% [mu,sigma]=normfit(all);
% % norm = normpdf(all,mu,sigma);
% % plot(all,norm)

%% new version to get the variance!
% load power_level.mat % all_power_level = cell(6,9), first 3
% var=zeros(1,27);
% muarr=zeros(1,27);
% k=1;
% for i=1:3
%     for j=1:9
%         [x,y] = normfit(all_power_level{i,j});
%         var(k)=y;
%         muarr(k) = x;
%         k=k+1;
%     end
% end
% mv=mean(var);
% mu=mean(muarr);
