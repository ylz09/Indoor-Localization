load ./mat/lambda_diffk.mat
%load ./mat/bit_vec_aps.mat    %save bit_vec_aps.mat svec1 svec2 svec3 svec4 svec5;
load ./mat/succ_ratio_ks.mat  % save succ_ratio_ks.mat rates3_0 rates3_8 rates3_16 rates3_24 rates3_34;
load ./mat/paris_ks.mat       % save paris_ks.mat iids uids; 
load ./mat/bit_vec_aps_1k.mat    %save bit_vec_aps.mat svec1 svec2 svec3 svec4 svec5;
% h=figure;
% x=0:34
% plot(x,rates_lm_8,'-bo','linewidth',2,'markersize',8)
% hold on
% plot(x,rates_lm_16,'-r+','linewidth',2,'markersize',8)
% hold on
% %plot(x,rates_lm_20,'-g>','linewidth',2,'markersize',8)
% % hold on
% plot(x,rates_lm_24,'-cx','linewidth',2,'markersize',8)
% hold on
% % plot(x,rates3_30,'-kd','linewidth',2,'markersize',8)
% % hold on
% % plot(x,rates3_34,'-m*','linewidth',2,'markersize',8)
% xlim([0,34])
% ylim([0,1])
% xlabel("\lambda")
% ylabel("Success ratio")
% legend('k=8','k=16','k=24','location','best')
% set(gca,'fontsize',18)
% %set(gca,'fontsize',18,'xtick',0:2:24)

%%  Draw the success ratio under attack2 type-2, using bit-vector to get the fake ap needed!
h=figure;
x=0:29;
k=1000;
plot(x,sum(svec1)/k,'-b>','linewidth',2) % 1 lambda=0
hold on
plot(x,sum(svec2)/k,'-ro','linewidth',2) % 2 lambda=8
hold on
plot(x,sum(svec3)/k,'-g+','linewidth',2) % 3 lambda=16
hold on
plot(x,sum(svec4)/k,'-cx','linewidth',2) % 4 lambda=24
hold on
plot(x,sum(svec5)/k,'-md','linewidth',2) % 5 lambda=34, same as median
legend('\lambda=0','\lambda=8','\lambda=16','\lambda=24','\lambda=34','location','best')
xlim([0,25])
ylim([0,1])
xlabel('# of fake APs')
ylabel('Success ratio')
set(gca,'fontsize',18)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')

%% %%  Draw the success ratio under attack2 type-2, using orignal method, but find the best number between [0,k]  to attack!
h=figure;
x=0:29;
plot(x,rates3_0,'-b>','linewidth',2)
hold on
plot(x,rates3_8,'-ro','linewidth',2)
hold on
plot(x,rates3_16,'-g+','linewidth',2)
hold on
plot(x,rates3_24,'-cx','linewidth',2)
hold on
plot(x,rates3_34,'-md','linewidth',2)
legend('\lambda=0','\lambda=8','\lambda=16','\lambda=24','\lambda=34','location','nw')
xlim([0,25])
ylim([0,1])
xlabel('# of fake APs')
ylabel('Success ratio')
set(gca,'fontsize',18)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')