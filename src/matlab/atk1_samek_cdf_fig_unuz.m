h = figure;

load ./mat/avg_opt_dist.mat;
load ./mat/avg_subopt_db_0.mat;
load ./mat/avg_subopt_db_1.mat;
% load avg_atk3.mat;    % this mat stores only 72 user test data
% load avg_atk4.mat;    % this mat stores only 72 user test data
load ./mat/avg_atk3.real.mat;
load ./mat/avg_atk4_1.real.mat;
load ./mat/avg_rnd_dist.mat;

x=[1:10:360];
% avg1_diffk1 = universe3(x,2,1);
% avg1_diffk2 = universe4(x,2,1);
% avg1_diffk3 = universe1(x,2,1);
% avg1_diffk4 = universe2(x,2,1);
% avg1_diffk5 = universe5(x,2,1);

% avg1_diffk1 = universe3(x,2,2);
% avg1_diffk2 = universe4(x,2,2);
% avg1_diffk3 = universe1(x,2,2);
% avg1_diffk4 = universe2(x,2,2);
% avg1_diffk5 = universe5(x,2,2);

% avg1_diffk1 = universe3(x,2,4);
% avg1_diffk2 = universe4(x,2,4);
% avg1_diffk3 = universe1(x,2,4);
% avg1_diffk4 = universe2(x,2,4);
% avg1_diffk5 = universe5(x,2,4);

avg1_diffk1 = universe20(x,2,4);
avg1_diffk2 = universe21(x,2,4);
%avg1_diffk3 = universe1(x,2,4);
avg1_diffk4 = universe4(x,2,4);
avg1_diffk5 = universe5(x,2,4);


[y1,x1]=ecdf(avg1_diffk1);
[y2,x2]=ecdf(avg1_diffk2);
%[y3,x3]=ecdf(avg1_diffk3);
[y4,x4]=ecdf(avg1_diffk4);
[y5,x5]=ecdf(avg1_diffk5);

plot(x2,y2,'-m','LineWidth',2)
hold on
plot(x1,y1,'g:','LineWidth',2) % squre
hold on

% plot(x3,y3,'-b.','MarkerSize',3,'LineWidth',1)
% hold on
plot(x4,y4,'--r','LineWidth',2)
hold on
plot(x5,y5,'-.b','LineWidth',2)
xlim([0,26])

grid on
%grid minor
%set(gca,GridStyle,'XTick',[0:5:50],'YTick',[0:0.1:1],'GridLineStyle',':','gridcolor','k');
set(gca,'GridLineStyle',':','gridcolor','k');

%title("2 AP");
xlabel("Maximum error distance(m)")
ylabel("CDF")
set(gca,'fontsize',18)
leg=legend('Type 1','Type 2','Type 3','Type 4','Location','nw')
leg.FontSize=13;

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')



