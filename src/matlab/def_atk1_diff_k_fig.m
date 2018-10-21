h = figure;
load ./mat/lambda_k.mat %save lambda_k.mat avg_k4 avg_k8 avg_k16;
load ./mat/rnd_lambda_k4.mat %save rnd_lambda_k4.mat rnd_lambda_k4;
load ./mat/rnd_lambda_k8.mat
load ./mat/rnd_lambda_k16.mat

x=0:34;
medi4(1:35)=3.7289;
medi8(1:35)=5.1273;

plot(x,avg_k4,'-b^','MarkerSize',8,'LineWidth',2)
hold on
plot(x,avg_k8,'-mx','MarkerSize',8,'LineWidth',2)
hold on
% plot(x,avg_k16,'-mx','MarkerSize',8,'LineWidth',2)
% hold on
plot(x,rnd_lambda_k4,'-kd','MarkerSize',8,'LineWidth',2)
hold on
plot(x,rnd_lambda_k8,'-go','MarkerSize',8,'LineWidth',2)
hold on
% plot(x,rnd_lambda_k16,'-go','MarkerSize',8,'LineWidth',2)
% hold on
plot(x,medi4,'-r>','MarkerSize',8,'LineWidth',2)
hold on
plot(x,medi8,'-r+','MarkerSize',8,'LineWidth',2)
xlim([0,14])
ylim([0 22])
xlabel('\lambda')
ylabel('Avg. location error (m)')
legend('Type-3,\it k=4','Type-3,\it k=8','Type-4,\it k=4','Type-4,\it k=8','Median,\it k=4', 'Median,\it k=8')
%legend('type3, \it k=8','type3, \it k=16','type4, \it k=8','type4, \it k=16','median, \it k=4', 'median, \it k=8')
set(gca,'fontsize',18,'xtick',[0:2:14])
%legend('\it k=4','\it k=8','\it k=16')


set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')