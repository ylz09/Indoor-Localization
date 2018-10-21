% muti folder stores the rss file
% filename: m-n.rsst, m transmission power; n distance index, should *2.5;
% rsst means test/true rss, another is fake AP rss, for comparison

%pre = 'man';
pre = 'multi';

% I will store all the rss of one transmisson power into a file
% can't use 2d matrix due to the different number of certain distance
% use twin array:
% power: 5 10 15 20 25 30
% dist: 1 .. 9
% read files by transmission power; 6 tp 9 dist;
% into a 6*9 cell matrix
load power_level.mat

% all_power_level = cell(6,9);
% k=0;
% for i=5:5:30
%     k=k+1;
%     for j=1:9
%         file_name = sprintf('%s/%d-%d.rsst',pre,i,j);
%         data = importdata(file_name);
%         all_power_level{k,j} = data;
%     end
% end
%save power_level.mat all_power_level

% draw boxplot with different size by grouping
% e.g.
% c_1=[2,2,3,2];
% c_2=[4,5];
% C = [c_1 c_2];
% grp = [zeros(1,4),ones(1,2)];
% boxplot(C,grp)
% e.g. first cell:all_power_level{1,1}:
%color=['r','k','b','g','m','c'];
color=['k','r','b'];
power=[5,10,15,20,25,30];
xpos=[2,4,6,8,10,12,14,16,18];
%xpos=[3,6,9,12,15,18];

marker = {'-k^','-ro','-bx'};
h=figure
for i=1:3
    %subplot(6,1,i);
%ylim([-70 -40])
%set(gca,'YTick',-70:20:-40)

dist1 = all_power_level{i,1};                                                                                            
dist2 = all_power_level{i,2};
dist3 = all_power_level{i,3};
dist4 = all_power_level{i,4};
dist5 = all_power_level{i,5};
dist6 = all_power_level{i,6};
dist7 = all_power_level{i,7};
dist8 = all_power_level{i,8};
dist9 = all_power_level{i,9};

x=[dist1;dist2;dist3;dist4;dist5;dist6;dist7;dist8;dist9];
g=[2*ones(size(dist1));4*ones(size(dist2));6*ones(size(dist3));8*ones(size(dist4));10*ones(size(dist5));
    12*ones(size(dist6));14*ones(size(dist7));16*ones(size(dist8));18*ones(size(dist9))];

% x=[dist1;dist3;dist4;dist5;dist6;dist8;dist9];
% g=[2*ones(size(dist1));6*ones(size(dist3));8*ones(size(dist4));10*ones(size(dist5));
%     12*ones(size(dist6));16*ones(size(dist8));18*ones(size(dist9));];

boxplot(x,g,'positions', xpos,'symbol','','color',color(i))

% mdist=[mean(dist1),mean(dist2),mean(dist3),mean(dist4),mean(dist5),mean(dist6),mean(dist7),mean(dist8),mean(dist9)];
% mdist=[mean(dist1),mean(dist3),mean(dist4),mean(dist5),mean(dist6),mean(dist8),mean(dist9)];
hold on

mdist=[mean(dist1),mean(dist2),mean(dist3),mean(dist4),mean(dist5),mean(dist6),mean(dist7),mean(dist8),mean(dist9)];
plot(xpos,mdist,marker{i},'LineWidth',1)

ylim([-74,-30])
xlim([1,20])
hold on

end
%hold off
%hLegend = legend(findall(gca,'Tag','Box'), {'1','2','3','4','5','6'});
%legend('power=5','power=10','power=15','power=20','power=25','power=30')
leg=legend('Tx power= 5','Tx power=15','Tx power=30','location','NE')
set(leg,'fontsize',11)
%legend('power=5','power=30')
%legend('show')
 xlabel('Distance(m)','fontsize',18)
 ylabel('RSS(dBm)','fontsize',18)
% title(power(i))
% The way to set the group dimension
% x1 = rand(10,1); x2 = 2*rand(15,1); x3 = randn(30,1);
% x = [x1;x2;x3];
% g = [ones(size(x1)); 2*ones(size(x2)); 3*ones(size(x3))];
% boxplot(x,g)
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')
