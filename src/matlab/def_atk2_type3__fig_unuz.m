clear;
load ./mat/def_a1t3_suc_rate.mat
load ./mat/target_suc_rate1.13.mat

h=figure;
x=0:29;
plot(x,rates3,'-b^','linewidth',2,'markersize',8)
hold on
% plot(x,rates4,'-cx','linewidth',2,'markersize',8)
% hold on
% plot(rates3_2,'-ko','linewidth',2,'markersize',8)
% hold on
% plot(rates3_4,'-g>','linewidth',2,'markersize',8)
% hold on
y=0:34;
plot(y,rates3_8,'-md','linewidth',2,'markersize',8)
hold on
%rates3_16(1:9)=0.025;
plot(y,rates3_16,'-cx','linewidth',2,'markersize',8)
hold on
% rates3_24(1:13) = rates3_16(1:13)- (0.05:-0.004:0);
% rates3_24(13) = 0.10;
% rates3_24(1:7)=0;

%rates3_24(1:13) = 0.01;rates3_24(14)=0.05;
plot(y,rates3_24,'-go','linewidth',2,'markersize',8)
hold on
plot(y,rates3_34,'-c*','linewidth',2,'markersize',8)
hold on
plot(y,rates3_m,'-r+','linewidth',2,'markersize',8)

xlim([0,25])
ylim([0,0.5])
%legend('Type 3','Type 4','k=2','k=4','k=8','Median','location','nw')
%legend('Type-3, \lambda=0','Type-4, \lambda=0','Type-3, \lambda=8','Median','location','nw')
legend('Type-3, \lambda=0','Type-3, \lambda=8','Type-3, \lambda=16','Type-3, \lambda=24','Median','location','nw')
set(gca,'fontsize',18)
xlabel('# of fake APs','fontsize',18)
ylabel('Success ratio','fontsize',18)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')