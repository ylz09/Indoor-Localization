h=figure;
load ./mat/target_trk.mat
x=0:29;
plot(x,rates3_0,'-bo','linewidth',2,'markersize',8)
hold on
plot(x,rates3_8,'-r+','linewidth',2,'markersize',8)
hold on
plot(x,rates3_16,'-g>','linewidth',2,'markersize',8)
hold on
plot(x,rates3_26,'-cx','linewidth',2,'markersize',8)
hold on
plot(x,rates3_30,'-kd','linewidth',2,'markersize',8)
hold on
plot(x,rates3_34,'-m*','linewidth',2,'markersize',8)
xlim([0,25])
xlabel("# of fake APs")
ylabel("Success ratio")
legend('\lambda=0','\lambda=8','\lambda=16','\lambda=26','\lambda=30','\lambda=34','location','best')
set(gca,'fontsize',18)
%set(gca,'fontsize',18,'xtick',0:2:24)


set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')