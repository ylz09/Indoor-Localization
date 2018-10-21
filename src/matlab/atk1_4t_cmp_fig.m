%% compare the type1~4 attackers of attack 1
% load avg_opt_dist.mat;load avg_atk3.real.mat;
load ./mat/avg_subopt_db_0.mat; % type-1
load ./mat/avg_subopt_db_1.mat; % type-2
load ./mat/avg_atk4_1.real.mat; % type-3
load ./mat/avg_rnd_dist.mat;    % type-4

% load type1.mat;
% load type2.mat;
% load type3.mat;
% load avg_rnd_dist.mat

% So we can say the user data is more representive than the training data
% In someway, it make sense due to more data sample
h = figure;
x=0:35;
% Be careful, type3 -> avg4, type4-avg5;The orignial type3 is discarded
avg20=[1.8444,avg20];avg21=[1.8444,avg21];avg4=[1.8444,avg4];avg5=[1.8444,avg5]; 
plot(x,avg20,'-b^',x,avg21,'-g+',x,avg4,'-mx',x,avg5,'-rd','markersize',8,'LineWidth',2)
xlim([0,25])
ylim([0,23.3])

legend('Type-1','Type-2','Type-3','Type-4','Location','se')
ylabel("Avg. location error (m)")
xlabel("# of fake APs")
set(gca,'fontsize',18)


set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')







