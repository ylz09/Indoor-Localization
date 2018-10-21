% %need to execute HML.m first
% close all
% clear
% clc
% load powerLevel.mat
% h = figure;
% 
% for i=2:2:20
%     BD(:,i/2)=bd(:,i);
% end
% 
% boxplot(BD)
% axis([0 11 -90 -55]);
% set(gca,'YTick',-90:5:-55,'Xticklabels',2:2:20,'fontsize',15)
% xlabel('Distance(m)','fontsize',15)
% ylabel('RSS(dBm)','fontsize',15)
% %title('RSS range with barrier')
% 
% set(h,'Units','Inches');
% pos = get(h,'Position');
% set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(h,'filename','-dpdf','-r0')

%need to execute HML.m first
% close all
% clear
% clc
% load powerLevel.mat
HML
h = figure;
a=0.05;
for i=2:2:20
    BD(:,i/2)=bd(:,i);
end
mea=mean(BD);
plot(2:2:18,mea(1:9),'b-o','LineWidth',1.5);
for j=1:9
    s_bd(:,j)=sort(BD(:,j));
    x_l(j)=s_bd(floor(size(bd,1)*a/2),j);
    x_h(j)=s_bd(floor(size(bd,1)*(1-a/2)),j);
end

for j=1:9
    
        line([2*j 2*j],[x_l(j) x_h(j)],'LineWidth',1.3,'LineStyle',':','color','b');%
        hold on
        line([2*j-0.3 2*j+0.3],[x_l(j) x_l(j)],'color','b');
        hold on
        line([2*j-0.3 2*j+0.3],[x_h(j) x_h(j)],'color','b');
        hold on

end

axis([2 18 -90 -55]);
% set(gca,'YTick',-90:5:-55,'Xticklabels',0:2:22,'fontsize',15)
xlabel('Distance (m)','fontsize',18)
ylabel('RSS (dBm)','fontsize',18)
%title('RSS range with barrier')
set(gca,'fontsize',18)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')