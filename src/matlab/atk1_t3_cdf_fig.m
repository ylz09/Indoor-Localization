h = figure;

load avg_opt_dist.mat;
load avg_subopt_db.mat;
% load avg_atk3.mat;    % this mat stores only 72 user test data
% load avg_atk4.mat;    % this mat stores only 72 user test data
load avg_atk3.real.mat;
load avg_atk4.real.mat;
load avg_rnd_dist.mat

%load avg_atk4_1.real.mat;

%same attack, different k e.g. 2 10
% optimal attack
% x=[1:360];
% avg1_diffk1 = universe3(x,2,1);
% avg1_diffk2 = universe3(x,2,2);
% avg1_diffk3 = universe3(x,2,4);
% avg1_diffk4 = universe3(x,2,8);
% avg1_diffk5 = universe3(x,2,16);
% 
% [y1,x1]=ecdf(avg1_diffk1);
% [y2,x2]=ecdf(avg1_diffk2);
% [y3,x3]=ecdf(avg1_diffk3);
% [y4,x4]=ecdf(avg1_diffk4);
% [y5,x5]=ecdf(avg1_diffk5);
% 
% plot(x1,y1,'-k.','MarkerSize',6,'LineWidth',2)
% hold on
% plot(x2,y2,'-r.','MarkerSize',6,'LineWidth',2)
% hold on
% plot(x3,y3,'-b.','MarkerSize',6,'LineWidth',2)
% hold on
% plot(x4,y4,'-g.','MarkerSize',6,'LineWidth',2)
% hold on
% plot(x5,y5,'--','LineWidth',2)
% xlim([5,26])


% % backup cdf method
% cdf2ap=calculateCdf(avg1_diffk1',ceil(max(avg1_diffk1)));
% cdf10ap=calculateCdf(avg1_diffk2',ceil(max(avg1_diffk2)));
% cdf2ap(27)=1;
% cdf10ap(27)=1;
% plot(16:ceil(max(avg1_diffk1)),cdf2ap(17:27),'-k.','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(16:ceil(max(avg1_diffk2)),cdf10ap(17:27),'-b.','MarkerSize',6,'LineWidth',1.5)
% xlim([15,26])

% only knows DB
% x=[1:360];
% avg1_diffk1 = universe4(x,2,1);
% avg1_diffk2 = universe4(x,2,2);
% avg1_diffk3 = universe4(x,2,4);
% avg1_diffk4 = universe4(x,2,8);
% avg1_diffk5 = universe4(x,2,16);
% 
% [y1,x1]=ecdf(avg1_diffk1);
% [y2,x2]=ecdf(avg1_diffk2);
% [y3,x3]=ecdf(avg1_diffk3);
% [y4,x4]=ecdf(avg1_diffk4);
% [y5,x5]=ecdf(avg1_diffk5);
% 
% plot(x1,y1,'-k.','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(x2,y2,'-r.','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(x3,y3,'-b.','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(x4,y4,'-g.','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(x5,y5,'--','LineWidth',1.5)
% xlim([5,26])

% only control AP
% x=[1:360];
% avg1_diffk1 = universe1(x,2,1);
% avg1_diffk2 = universe1(x,2,2);
% avg1_diffk3 = universe1(x,2,4);
% avg1_diffk4 = universe1(x,2,8);
% avg1_diffk5 = universe1(x,2,16);
% 
% [y1,x1]=ecdf(avg1_diffk1);
% [y2,x2]=ecdf(avg1_diffk2);
% [y3,x3]=ecdf(avg1_diffk3);
% [y4,x4]=ecdf(avg1_diffk4);
% [y5,x5]=ecdf(avg1_diffk5);
% 
% plot(x1,y1,'-k.','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(x2,y2,'-r.','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(x3,y3,'-b.','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(x4,y4,'-g.','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(x5,y5,'--','LineWidth',1.5)
% xlim([5,26])

% partial
% x=[1:360];
% avg1_diffk1 = universe2(x,2,1);
% avg1_diffk2 = universe2(x,2,2);
% avg1_diffk3 = universe2(x,2,4);
% avg1_diffk4 = universe2(x,2,8);
% avg1_diffk5 = universe2(x,2,16);
% 
% [y1,x1]=ecdf(avg1_diffk1);
% [y2,x2]=ecdf(avg1_diffk2);
% [y3,x3]=ecdf(avg1_diffk3);
% [y4,x4]=ecdf(avg1_diffk4);
% [y5,x5]=ecdf(avg1_diffk5);
% 
% plot(x1,y1,'-k.','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(x2,y2,'-r.','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(x3,y3,'-b.','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(x4,y4,'-g.','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(x5,y5,'--','LineWidth',1.5)
% xlim([5,26])

% type-3 attack
x=[1:360];

avg1_diffk1 = universe4(x,2,1);
avg1_diffk2 = universe4(x,2,2);
avg1_diffk3 = universe4(x,2,4);
avg1_diffk4 = universe4(x,2,8);
%avg1_diffk5 = universe4(x,2,16);

% avg1_diffk1 = universe5(x,2,1);
% avg1_diffk2 = universe5(x,2,2);
% avg1_diffk3 = universe5(x,2,4);
% avg1_diffk4 = universe5(x,2,8);
% avg1_diffk5 = universe5(x,2,16);

[y1,x1]=ecdf(avg1_diffk1);
[y2,x2]=ecdf(avg1_diffk2);
[y3,x3]=ecdf(avg1_diffk3);
[y4,x4]=ecdf(avg1_diffk4);
[y5,x5]=ecdf(avg1_diffk5);

plot(x1,y1,'--m','LineWidth',2)
hold on
plot(x2,y2,'g:','LineWidth',2)
hold on
plot(x3,y3,'-.b','LineWidth',2)
hold on
plot(x4,y4,'-r','LineWidth',2)
hold on
%plot(x5,y5,'--','LineWidth',2)
xlim([0,26])
grid on
set(gca,'GridLineStyle',':','gridcolor','k');
legend('\it k=1','\it k=2','\it k=4','\it k=8','Location','sw')
xlabel("Error distance (m)")
ylabel("CDF")
set(gca,'fontsize',18)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')