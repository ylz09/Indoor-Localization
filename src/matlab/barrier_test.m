%need to execute HML.m first
HML
h = figure;

boxplot(bd(:,2:2:20))
ylim([-90 -50])

%set(gca,'fontsize',18,'YTick',-90:6:-30)
xlabel('Distance(m)','fontsize',18)
ylabel('RSS(dBm)','fontsize',18)

%title('RSS range with barrier')

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')