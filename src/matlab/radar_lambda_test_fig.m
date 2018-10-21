load ./mat/lambda_dist.mat;
%% Draw the average error distance of radar method
x=1:2:35;
v0=mean(dist3(1,:));   %lamda=0 , just no truncation
v34=mean(dist3(35,:)); %lamda=34, median method
m0=zeros(1,35);
m34=zeros(1,35);
m0 (:)= v0;
m34(:)=v34;

h=figure;
x=1:2:35;
x=x-1; % x needs start from 0
plot(x,mean(dist3(1:2:35,:),2),'-b^','linewidth',2,'markersize',8);
hold on
plot(x,m0(1:2:35),'-g+','linewidth',2,'markersize',8)
hold on
plot(x,m34(1:2:35),'-rd','linewidth',2,'markersize',8)
xlim([0,34])
ylim([0,5])
xlabel('\lambda')
ylabel('Avg. location error (m)')
legend('TDFM','Radar','Median','location','se')
set(gca,'fontsize',18)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')

%% Draw the median error distance of radar method

v0=median(dist3(1,:));
v34=median(dist3(35,:));
m0=zeros(1,35);
m34=zeros(1,35);

m0 (:)= v0;
m34(:)=v34;
h=figure;
x=1:2:35;
x=x-1;
plot(x,median(dist3(1:2:35,:),2),'-b^','linewidth',2,'markersize',8);
hold on
plot(x,m0(1:2:35),'-g+','linewidth',2,'markersize',8)
hold on
plot(x,m34(1:2:35),'-rd','linewidth',2,'markersize',8)
xlim([0,34])
ylim([0,5])
xlabel('\lambda')
ylabel('Median error distance (m)')
legend('\lambda Truncation','No Truncation','Median','location','se')
set(gca,'fontsize',18)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')