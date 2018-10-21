% save target_k_cdf.mat dist1 dist2 dist3 dist4;
% dist: 35*70 matrix

%load target_k_cdf.mat % the first version
load ./mat/target_cdf_v2.mat
%% Average deviation
%plot(x,avg20,'-b^',x,avg21,'-g+',x,avg4,'-mx',x,avg5,'-rs','markersize',8,'LineWidth',2)
h = figure;
x=[0:34];
plot(x,mean(dist1,2),'-b>',x,mean(dist2,2),'-g+',x,mean(dist3,2),'-mo',x,mean(dist4,2),'-rd','markersize',8,'LineWidth',2)
xlim([0,25])
ylim([0,15])
legend('Type-1','Type-2','Type-3','Type-4','Location','sw')
ylabel('Avg. deviation (m)')
xlabel('# of fake APs')
% xticks([0:5:25])
% xticklabels([0:5:25])

set(gca,'fontsize',18)
%set(gca,'fontsize',18,'XTick',[0:2:25])
%set(gca,'XTick',[1:2:35])

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')

%% given k=10 - CDF 
h = figure;
x=[1:1000];
avg1_diffk1 = dist1(8,x);
avg1_diffk2 = dist2(8,x);
avg1_diffk3 = dist3(8,x);
avg1_diffk4 = dist4(8,x);

[y1,x1]=ecdf(avg1_diffk1);
[y2,x2]=ecdf(avg1_diffk2);
[y3,x3]=ecdf(avg1_diffk3);
[y4,x4]=ecdf(avg1_diffk4);

plot(x1,y1,'-b.','LineWidth',2)
hold on
plot(x2,y2,'-.g','LineWidth',2)
hold on
plot(x3,y3,'m:','LineWidth',2)
hold on
plot(x4,y4,'--r','LineWidth',2)

xlim([0,27])
grid on
set(gca,'GridLineStyle',':','gridcolor','k');
%set(gca,'GridLineStyle',':','gridcolor','k','xtick',1:5:26);

% set(gca,'GridLineStyle',':','gridcolor','k','xtick',1:5:27);
% label={'0','5','10','15','20','25'};
% set(gca,'xticklabel',label);

legend('Type-1','Type-2','Type-3','Type-4','Location','se')
xlabel('Attack 2 deviation (m)')
ylabel('CDF')
set(gca,'fontsize',18)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')