% Similar with reference point RSS difference test
% The goal is to show how similar between the attack AP and traning AP RSS

% Load data
%close all
%clear
clc
load ./mat/rssMap.mat; % R
load ./mat/userMap.mat;% U

% 35 AP in total
% get the mean of 72 reference points
m_ap_rp=[];
for i=1:35
    m_ap_tmp=mean(R(:,i,1)); % no need the loop for each reference point
    m_ap_rp=[m_ap_rp,m_ap_tmp];
end

% 360 test points simulating the attacker behavior
% map 360 test point(tp) to reference point(rp) first
% no need the above map, just mean of all of them
m_ap_tp=[];
for i=1:35    
    m_ap_tmp=mean(U(:,i)); % mean the 360 test points of certain AP
    m_ap_tp=[m_ap_tp,m_ap_tmp];
end

diff=abs(m_ap_rp-m_ap_tp);

% drow the CDF figure, similar with others 
h = figure;
CDF = calculateCdf(diff,ceil(max(diff)));
%plot(0:ceil(max(dv)-1),CDF) %original
%plot(0:ceil(max(dv)-1),CDF,'-r+','MarkerSize',6,'LineWidth',1.5)
plot(0:ceil(max(diff)-1),CDF,'-k+','MarkerSize',6,'LineWidth',1.5)
xlabel("Mean RSS Diff of each AP")
ylabel("CDF")


set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')

% % 
% hold on
% % Comparison between the RP and AP diff of mean RSS
% CDF = calculateCdf(dv,ceil(max(dv)));
% %plot(0:ceil(max(dv)-1),CDF) %original
% %plot(0:ceil(max(dv)-1),CDF,'-r+','MarkerSize',6,'LineWidth',1.5)
% plot(0:ceil(max(dv)-1),CDF,'-bo','MarkerSize',6,'LineWidth',1.5)
% xlabel("Mean RSS Difference at the reference points")
% ylabel("CDF")
% title("Comparison between training and attacker data")
% 
% set(h,'Units','Inches');
% pos = get(h,'Position');
% set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(h,'filename','-dpdf','-r0')