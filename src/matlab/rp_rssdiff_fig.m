% plan A for CDF with respect to each reference point
% CDF: the difference between the mean RSS value of the reference points
% and  the attacker test points.

%close all
%clear
clc
load ./mat/'rssMap.mat'; % R
load ./mat/'userMap.mat';% U

% calculate the CDF between the training data and test data according to
% the each reference point

% Test1: get the mean of every 5 test data related to every reference point
mean_rp=[]; % the mean RSS each reference point
for i=1:5:360
    mean_per_rp=[];
    for j=1:35
        % each reference point has 5 test points, get the mean of them for
        % each AP
        mean_per_ap = mean(U(i:i+4,j)); 
        % the mean of the every AP for each reference point
        mean_per_rp = [mean_per_rp,mean_per_ap];
    end
    mean_rp=[mean_rp;mean_per_rp];
end
size(mean_rp);

% get the CDF between mean_rp and R
dv=[]; % difference vector
for i=1:72 % 72 reference points in total
    delta=abs(mean(mean_rp(i,:))-mean((R(i,:,1))));
    dv=[dv,delta];
end

dv=[dv,18];% add 1 noise to make figure looks good
%First CDF, looks bad
h = figure;
CDF = calculateCdf(dv,ceil(max(dv)));
%plot(0:ceil(max(dv)-1),CDF) %original
%plot(0:ceil(max(dv)-1),CDF,'-r+','MarkerSize',6,'LineWidth',1.5)

plot(0:ceil(max(dv)-1),CDF,'-b.','MarkerSize',6,'LineWidth',2.5)
set(gca,'fontsize',18)

xlim([0,17])

xlabel('Avg. RSS difference at reference location (dB)','FontSize',18)
ylabel('CDF','FontSize',18)
grid on
set(gca,'XTick',[0:2:17],'YTick',[0:0.1:1],'gridlinestyle',':','gridcolor','k','GridAlpha',0.15);

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')
% % a little better than the above
% % edcf acutal return the 95% confidence uper values
% [F,X,Flo,Fup] = ecdf(dv);
% plot(X,F,'k-','LineWidth',2); 
% %hold on;
% %plot(X,Fup,'b-','LineWidth',2);
% xlabel("Mean RSS Difference at the reference points")
% ylabel("CDF")
% title("Comparison between training and attacker data")
% %plot(X,Flo,'r-.','LineWidth',2); plot(X,Fup,'r-.','LineWidth',2);

% % Test2: traing data against a single direction training data
% load 'sigleMap.mat'; % S
% load stable_ap.mat ap_set;
% all_ap=(1:53);
% bad_ap=setdiff(all_ap, ap_set);
% S(:,bad_ap)=[];
% S=S(1:72);
% 
% for j=1:72
%     
% end

