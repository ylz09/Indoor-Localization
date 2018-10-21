
clear;
load ./mat/target_rnd.mat;

% load target_suc_rate.mat;
% load target_suc_rate1.15.mat
% load target_suc_rate1.2.mat

%load target_suc_rate1.13.mat %figure in the paper
%load target_suc_mu.mat
%load target_suc_rate_v2.mat
%load target_suc_rate_v2_1.mat
%load target_suc_rate_v1k.mat
load ./mat/target_suc_rate_v2_1k.mat

h=figure;
x=0:29;
plot(x,rates,'-b>','linewidth',2,'markersize',8)
hold on

plot(x,rates2,'-g+','linewidth',2,'markersize',8)
hold on

% load target_suc_rate.mat;
% plot(x,rates3,'-mx','linewidth',2,'markersize',8)
% hold on

%load target_suc_rate1.13.mat
plot(x,rates3,'-co','linewidth',2,'markersize',8)
hold on

% load target_suc_rate1.15.mat
% plot(x,rates3,'-b>','linewidth',2,'markersize',8)
% hold on
% 
% load target_suc_rate1.2.mat
% plot(x,rates3,'-ko','linewidth',2,'markersize',8)
% hold on

%plot(rnd,'-rx','linewidth',2,'markersize',8)
plot(x,rates4,'-rd','linewidth',2,'markersize',8)

 xlim([0,25])
% xticks([0:25])
% xticklabels([0:25])
legend('Type-1','Type-2','Type-3','Type-4','location','best')
%legend('Type-1','Type-2','Type-3-2avg','Type-3-6avg','Type-3-5avg','Type-3-1rss','Type-4','location','best')
set(gca,'fontsize',18)
xlabel('# of fake APs','fontsize',18)
ylabel('Success ratio','fontsize',18)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')