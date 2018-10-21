h = figure;
load ./mat/avg_opt_dist.mat 
load ./mat/avg_subopt_db_0.mat;
load ./mat/avg_subopt_db_1.mat;
load ./mat/avg_atk4_1.real.mat
load ./mat/avg_opt_dist_medi.mat
load ./mat/avg_opt_dist_knn.mat
load ./mat/avg_opt_dist_cn5.mat
load ./mat/avg_opt_dist_rnd5.mat
load ./mat/avg_opt_dist_minmax2.mat
load ./mat/avg_opt_dist_minmax4.mat
load ./mat/avg_opt_dist_minmax8.mat

load ./mat/avg_rnd_dist.mat
load ./mat/avg_rnd_drop.mat %save avg_rnd_drop.mat universe6 avg6;

load ./mat/avg_a1t3_dist_minmax2.mat
load ./mat/avg_a1t3_dist_minmax4.mat
load ./mat/avg_a1t3_dist_minmax8.mat

load ./mat/avg_a1t1_dist_minmax2.mat
load ./mat/avg_a1t1_dist_minmax4.mat
load ./mat/avg_a1t1_dist_minmax8.mat

% new median
load ./mat/avg_a1t1_median.mat %universe_a1t1_median avg_a1t1_median;
load ./mat/avg_a1t3_median.mat


%k^ ro c* bs
% plot(x,avg_cn5(1:2:25),'-ro','MarkerSize',6,'LineWidth',1.2)
% hold on
% plot(x,avg_rnd5(1:5:35),'-kd','MarkerSize',6,'LineWidth',1.5)
% hold on

x=0:2:25;

% attack1 type1 comparison
% plot(x,avg20(1:2:25),'-b^','MarkerSize',8,'LineWidth',2)
% hold on
% plot(x,avg5(1:2:25),'-cd','MarkerSize',8,'LineWidth',2)
% hold on
% plot(x,avg_a1t1_minmax2(1:2:25),'-ko','MarkerSize',8,'LineWidth',2)
% hold on
% plot(x,avg_a1t1_minmax4(1:2:25),'-g>','MarkerSize',8,'LineWidth',2)
% hold on
% plot(x,avg_a1t1_minmax8(1:2:25),'-ms','MarkerSize',8,'LineWidth',2)
% hold on
% plot(x,avg_a1t1_median(1:2:25),'-r+','MarkerSize',8,'LineWidth',2)
% xlabel('# of evil APs','fontsize',18)
% ylabel('Average error distance (m)','fontsize',18)
% xlim([0 25])
% ylim([0 23])
% leg=legend('Type-3','Type-4','\it k=2','\it k=4','\it k=8','Median','Location','SE')
% leg.FontSize=14;
% set(gca,'FontSize',18)

% % attack1 type3 comparison
% plot(x,avg4(1:2:25),'-b^','MarkerSize',8,'LineWidth',2)
% hold on
% plot(x,avg5(1:2:25),'-cd','MarkerSize',8,'LineWidth',2)
% hold on
% plot(x,avg_a1t3_minmax2(1:2:25),'-ko','MarkerSize',8,'LineWidth',2)
% hold on
% plot(x,avg_a1t3_minmax4(1:2:25),'-g>','MarkerSize',8,'LineWidth',2)
% hold on
% plot(x,avg_a1t3_minmax8(1:2:25),'-ms','MarkerSize',8,'LineWidth',2)
% hold on
% plot(x,avg_a1t3_median(1:2:25),'-r+','MarkerSize',8,'LineWidth',2)
% axis([1 25 0 23]) %same as xlim & ylim
% %grid on
% % xlim([1 35])
% % ylim([0 25])
% xlabel('# of fake APs','fontsize',18)
% ylabel('Average error distance (m)','fontsize',18)
% leg=legend('Type 3','Type 4','k=2','k=4','k=8','Median','Location','SE')
% leg.FontSize=14;
% set(gca,'FontSize',18)

% plot(x,avg_a1t3_minmax2(1:2:25),'-ko','MarkerSize',8,'LineWidth',2)
% hold on
% plot(x,avg_a1t3_minmax4(1:2:25),'-g>','MarkerSize',8,'LineWidth',2)

% type3 lmda=0
avg4=[1.8444,avg4];avg5=[1.8444,avg5];
plot(x,avg4(1:2:25),'-b^','MarkerSize',8,'LineWidth',2)
hold on
% type4 lmda=0 (random attack)
plot(x,avg5(1:2:25),'-kd','MarkerSize',8,'LineWidth',2)
hold on
% type3 lmda=8
avg_a1t3_minmax8 = [2.1,0,avg_a1t3_minmax8];
plot(x,avg_a1t3_minmax8(1:2:25),'-mx','MarkerSize',8,'LineWidth',2)
hold on
% type4 lmda=8 (random attack)
avg6 = [2.1,0,avg6];
plot(x,avg6(1:2:25),'-go','MarkerSize',8,'LineWidth',2)
hold on
% median
avg_a1t3_median=[2.8,0,avg_a1t3_median]
plot(x,avg_a1t3_median(1:2:25),'-r+','MarkerSize',8,'LineWidth',2)

axis([0 25 0 23]) %same as xlim & ylim
%grid on
% xlim([1 35])
% ylim([0 25])
xlabel('# of fake APs','fontsize',18)
ylabel('Avg. location error (m)','fontsize',18)
leg=legend('Type-3, \lambda=0','Type-4, \lambda=0','Type-3, \lambda=8','Type-4, \lambda=8','Median','Location','SE')
leg.FontSize=14;
set(gca,'FontSize',18)

%% routine, just for figure output format
%set(gca,'XTick',[1:2:35])
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')