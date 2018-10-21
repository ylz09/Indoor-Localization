h = figure;

fake = importdata('twin/test.dat');
true = importdata('twin/udel.dat');

subplot(2,1,1)
boxplot(fake(:,2),fake(:,1))
set(gca,'fontsize',15)

xlabel('Fine grained power levels','fontsize',18)
ylabel('RSS (dBm)','fontsize',18)
title('Evil twin','fontsize',15)

subplot(2,1,2)
boxplot(true(:,2),true(:,1))
set(gca,'XTick',[],'fontsize',15)
xlabel('Power level is constant (20dBm)','fontsize',18)
ylabel('RSS (dBm)','fontsize',18)
title('Good twin','fontsize',15)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')

