load ./mat/target_rnd.mat;
h=figure;
plot(rates,'-b^','linewidth',2,'markersize',8)
hold on
plot(rnd,'-rx','linewidth',2,'markersize',8)

xlim([1,35])
legend('Target attack','Random attack','location','nw')
xlabel('# of evil APs','fontsize',18)
ylabel('Successful rate','fontsize',18)
set(gca,'fontsize',18)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')