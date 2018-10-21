% zb: means zuo biao
% ii=1:18
% jj=1:18
% [x,y]=meshgrid(ii,jj)
% figure
% scatter(x(:),y(:),'.')
% for k=1:numel(x)
%       text(x(k),y(k),['(' num2str(x(k)) ',' num2str(y(k)-0.5) ')'])
% end

clear;
%function [] = set_coords(n)
h = figure;
n=72;
%rpc = zeros(2,0);
rpc = [];
x = 17.84;
y = 17.84;
for i = 1 : n
	if i <= 18 			    % k1=18
		rpc = [rpc;i-1,0];
        plot (i-1,0, 'k.', 'MarkerSize', 15)
        hold on;
        textString = sprintf('(%d, %d)', i-1, 0);
        text(i-1-0.5, 0-1.5, textString, 'FontSize', 6);
	elseif i <= 36		    % k2 = 36
		rpc = [rpc;x,i-19]; % x fixed value = 17.84
        plot (x,i-19, 'k.', 'MarkerSize', 15)
        hold on;
        textString = sprintf('(%0.2f, %d)', x, i-19);
        text(x+0.2,i-19+0.2, textString, 'FontSize', 7);
	elseif i <= 54		    % k3 = 64
        
		rpc = [rpc;x-(i-37),y];  % y fixed value = 17.84
        plot (x-(i-37),y,'k.', 'MarkerSize', 15)
        hold on;
        if mod(i,2) == 0
            textString = sprintf('(%.1f, %.1f)', x-(i-37), y);
            text(x-(i-37)-0.7,y+1, textString, 'FontSize', 7);
        end
	else
		rpc = [rpc;0, y-(i-55)]; % total 18*4 = 72 reference points
        plot (0,y-(i-55), 'k.', 'MarkerSize', 15)
        hold on;
        textString = sprintf('(%d, %0.2f)', 0, y-(i-55));
        text(0-2.6,y-(i-55), textString, 'FontSize', 7);
	end
end
grid on;
%set(gcf, 'units','normalized','outerposition',[0 0 30 10]);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')

% for i=15:55
%   for j=2:9
%     plot (i,j, 'b.', 'MarkerSize', 20)
% 	hold on;
%     textString = sprintf('(%d, %d)', i, j);
%     text(i-0.3, j+0.1, textString, 'FontSize', 7);
%   end
% end
% grid on;
% % Enlarge figure to full screen.
% set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
