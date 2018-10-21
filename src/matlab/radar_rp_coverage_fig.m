h = figure;

load ./mat/radar_cover_test.mat

x=1:432;
y=cnt; %y=cnt;
yy1 = smooth(x,y,0.15,'loess');

%plot(x,y,'r.',x,yy1,'-k', 'LineWidth',2)
plot(x,y,'b:','LineWidth',3)%,'markersize',3
% xlim([1,432])
% ylim([1,72])

axis([1 432 1 72]);
set(gca,'fontsize',18,'XTick',[0:50:400],'YTick',[0:10:70]);
xlabel('# of test locations','fontsize',18);
ylabel('# of inferred reference locations','fontsize',18)
%legend('Radar','Radar-Trend','location','nw')

 
% store full screen figure
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0');
