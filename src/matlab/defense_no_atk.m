h = figure;
load ./mat/cnk_no_attack.mat

rnd_median;
plot(mean(all_cnk),'LineWidth',1.5)
hold on
medi(1:35)=2.8;
plot(medi,'LineWidth',1.5)
hold on

xlabel('Number of APs dropped')
ylabel('Average error distance (m)')
%legend('k-out-of-n accuracy')

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')
