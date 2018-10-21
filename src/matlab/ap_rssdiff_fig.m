load ./mat/rssMap.mat; % R
load ./mat/userMap.mat;% U

r=R(:,:,1);
u=[];
for i=1:5:360
u=[u;mean(U(i:i+4,:))];
end

ur=abs(r-u);
diff=ur(:)';
size(diff)

% drow the CDF figure, similar with others 
h = figure;

CDF = calculateCdf(diff,ceil(max(diff)));
%plot(0:ceil(max(dv)-1),CDF) %original
%plot(0:ceil(max(dv)-1),CDF,'-r+','MarkerSize',6,'LineWidth',1.5)
CDF=[0,CDF];
plot(0:ceil(max(diff)),CDF,'-b','LineWidth',2.5)
xlim([0,50])
set(gca,'fontsize',15)

% ax = gca
% ax.GridLineStyle = '-'
% ax.GridColor = 'k'
% ax.GridAlpha = 0

xlabel('Avg. RSS difference of AP (dB)','FontSize',18)
ylabel('CDF','FontSize',18)
grid on
%grid minor
set(gca,'XTick',[0:5:50],'YTick',[0:0.1:1],'GridLineStyle',':','gridcolor','k','GridAlpha',0.15);

%set(gca,'YTickMode','manual','YTick',[-16384,0,16384])
%set(gca,'XTickMode','manual','XTick',[-21846,-10922,0,10922,21846])

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')