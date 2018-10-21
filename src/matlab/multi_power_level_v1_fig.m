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
color=['m','b','r'];
power=[5,10,15,20,25,30];
xpos=[2,4,6,8,10,12,14,16,18];
%xpos=[3,6,9,12,15,18];

marker = {'-m^','-b*','-rs'};
h=figure;
a=0.05;
for i=1:3
    dist1 = all_power_level{i,1};                                                                                         
    dist2 = all_power_level{i,2};
    dist3 = all_power_level{i,3};
    dist4 = all_power_level{i,4};
    dist5 = all_power_level{i,5};
    dist6 = all_power_level{i,6};
    dist7 = all_power_level{i,7};
    dist8 = all_power_level{i,8};
    dist9 = all_power_level{i,9};

%     x=[dist1;dist2;dist3;dist4;dist5;dist6;dist7;dist8;dist9];
%     g=[2*ones(size(dist1));4*ones(size(dist2));6*ones(size(dist3));8*ones(size(dist4));10*ones(size(dist5));
%         12*ones(size(dist6));14*ones(size(dist7));16*ones(size(dist8));18*ones(size(dist9))];

    s_dist1=sort(dist1);
    s_dist2=sort(dist2);
    s_dist3=sort(dist3);
    s_dist4=sort(dist4);
    s_dist5=sort(dist5);
    s_dist6=sort(dist6);
    s_dist7=sort(dist7);
    s_dist8=sort(dist8);
    s_dist9=sort(dist9);
    
    x_l(i,1)=s_dist1(floor(size(dist1,1)*a/2));
    x_l(i,2)=s_dist2(floor(size(dist2,1)*a/2));
    x_l(i,3)=s_dist3(floor(size(dist3,1)*a/2));
    x_l(i,4)=s_dist4(floor(size(dist4,1)*a/2));
    x_l(i,5)=s_dist5(floor(size(dist5,1)*a/2));
    x_l(i,6)=s_dist6(floor(size(dist6,1)*a/2));
    x_l(i,7)=s_dist7(floor(size(dist7,1)*a/2));
    x_l(i,8)=s_dist8(floor(size(dist8,1)*a/2));
    x_l(i,9)=s_dist9(floor(size(dist9,1)*a/2));
    
    
    x_h(i,1)=s_dist1(floor(size(dist1,1)*(1-a/2)));
    x_h(i,2)=s_dist2(floor(size(dist2,1)*(1-a/2)));
    x_h(i,3)=s_dist3(floor(size(dist3,1)*(1-a/2)));
    x_h(i,4)=s_dist4(floor(size(dist4,1)*(1-a/2)));
    x_h(i,5)=s_dist5(floor(size(dist5,1)*(1-a/2)));
    x_h(i,6)=s_dist6(floor(size(dist6,1)*(1-a/2)));
    x_h(i,7)=s_dist7(floor(size(dist7,1)*(1-a/2)));
    x_h(i,8)=s_dist8(floor(size(dist8,1)*(1-a/2)));
    x_h(i,9)=s_dist9(floor(size(dist9,1)*(1-a/2)));
    
    
    mdist=[mean(dist1),mean(dist2),mean(dist3),mean(dist4),mean(dist5),mean(dist6),mean(dist7),mean(dist8),mean(dist9)];
    plot(xpos,mdist,marker{i},'LineWidth',1.3)
    hold on
end

for i=1:3
    for j=1:9
        line([2*j 2*j],[x_l(i,j) x_h(i,j)],'color',color(i),'LineWidth',0.5,'LineStyle',':');
        hold on
        line([2*j-0.1 2*j+0.1],[x_l(i,j) x_l(i,j)],'color',color(i));
        hold on
        line([2*j-0.1 2*j+0.1],[x_h(i,j) x_h(i,j)],'color',color(i));
        hold on
    end
end

axis([2 18 -75 -30]);

leg=legend('Tx power=5','Tx power=15','Tx power=30','location','NE');
set(leg,'fontsize',12)
set(gca,'fontsize',18)
xlabel('Distance (m)','fontsize',18)
ylabel('RSS (dBm)','fontsize',18)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')