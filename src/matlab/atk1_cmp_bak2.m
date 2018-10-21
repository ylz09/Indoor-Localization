load avg_opt_dist.mat;
load avg_subopt_db.mat;
% load avg_atk3.mat;    % this mat stores only 72 user test data
% load avg_atk4.mat;    % this mat stores only 72 user test data
h = figure;
load avg_atk3.real.mat;
load avg_atk4.real.mat;
load avg_rnd_dist.mat


% This is really a joke
% Real is more fake than fake!
% So we can say the user data is more representive than the training data
% In someway, it make sense due to more data sample

% avg1 = squeeze(mean(universe1(3:5:360,2,:)));
% avg2 = squeeze(mean(universe2(3:5:360,2,:)));
% avg3 = squeeze(mean(universe3(3:5:360,2,:)));
% avg4 = squeeze(mean(universe4(3:5:360,2,:)));

% % Fig. 9 probability and distribution
% load power_level.mat % all_power_level = cell(6,9), first 3
% half1=[];
% for i=1:3
%     for j=1:9
%         half1 = [half1;all_power_level{i,j}];
%     end
% end
% % Second half: come from the HML.M, need to read file again
% half2 = [];
% for i = 1 : 20
%     
%     file_name = sprintf('three/%d.txt',i);
%     data = importdata(file_name);
%     half2 = [half2;data];
% end
% %all data to fit the distribution:
% all = [half1;half2];
% %normplot(all)
% %histogram(all)
% histogram(all,'Normalization','probability')
% hold on
% [mu,sigma]=normfit(all);
% norm = normpdf([-90:0.5:-20],mu,sigma/1.3);
% plot([-90:0.5:-20],norm,'k','LineWidth',2)
% ylim([0,0.1])
% legend('statistical probability','normfit PDF')
% xlabel("RSS range")
% ylabel("Probablity with 10530 attack test samples")

% %overall comparison, no baseline
% %subplot(2,1,1);
% x=[1:35];
% avg1 = squeeze(mean(universe3(:,2,:)));
% avg2 = squeeze(mean(universe4(:,2,:)));
% avg3 = squeeze(mean(universe1(:,2,:)));
% avg4 = squeeze(mean(universe2(:,2,:)));
% plot(x,avg1,'-+',x,avg2,':',x,avg3,'-x',x,avg4,'-.','LineWidth',1.5)
% ylim([19.5,22.7])
% legend('optimal attack','attacker knows DB','attacker controls AP','partial attack','Location','best')
% ylabel("Average error distance(m)")
% xlabel("Number of evil AP")

%overall comparison, including baseline
%subplot(2,1,1);
% x=[1:35];
% avg1 = squeeze(mean(universe3(:,2,:)));
% avg2 = squeeze(mean(universe4(:,2,:)));
% avg3 = squeeze(mean(universe1(:,2,:)));
% avg4 = squeeze(mean(universe2(:,2,:)));
% plot(x,avg1,'-+',x,avg2,'-o',x,avg3,'-x',x,avg4,'-.',x,avg5,'-s','markersize',4,'LineWidth',1)
% ylim([2.9,22.8])
% legend('optimal attack','attacker knows DB','attacker controls AP','partial attack','random attack','Location','best')
% ylabel("Average error distance(m)")
% xlabel("Number of evil AP")

% subplot(2,1,2); 
% plot(x,avg5,'LineWidth',1.5)
% ylim([1,22.7])
% legend('random attack')
% xlabel("Number of evil AP")
% ylabel("Average error distance(m)")

% %same attack, different k e.g. 2 10
% % optimal attack
% x=[1:360];
% avg1_diffk1 = universe3(x,2,2);
% avg1_diffk2 = universe3(x,2,10);
% plot(x,avg1_diffk1,x,avg1_diffk2,'LineWidth',1.5)
% %plot(x,avg2_diffk1,':',x,avg2_diffk2,'+','LineWidth',1.5)
% xlim([0,360])
% legend('k=2','k=10')
% xlabel("Index of test points")
% ylabel("Error distance under optimal attack (m)")

% % attacker only knows the DB
% x=[1:360];
% avg2_diffk1 = universe4(x,2,2);
% avg2_diffk2 = universe4(x,2,10);
% plot(x,avg2_diffk1,x,avg2_diffk2,'LineWidth',1.5)
% %plot(x,avg2_diffk1,':',x,avg2_diffk2,'+','LineWidth',1.5)
% xlim([0,360])
% legend('k=2','k=10')
% xlabel("Index of test points")
% ylabel("Error distance with attacker only know DB (m)")

% % attacker only can control the AP
% x=[1:360];
% avg3_diffk1 = universe1(:,2,2);
% avg3_diffk2 = universe1(:,2,10);
% plot(x,avg3_diffk1,x,avg3_diffk2,'LineWidth',1.5)
% %plot(x,avg2_diffk1,':',x,avg2_diffk2,'+','LineWidth',1.5)
% xlim([0,360])
% legend('k=2','k=10')
% xlabel("Index of test points")
% ylabel("Error distance with attacker only control AP (m)")

% % attacker know paritial DB & partial control the AP
% x=[1:360];
% avg4_diffk1 = universe2(:,2,2);
% avg4_diffk2 = universe2(:,2,5);
% plot(x,avg4_diffk1,x,avg4_diffk2,'LineWidth',1.5)
% %plot(x,avg2_diffk1,':',x,avg2_diffk2,'+','LineWidth',1.5)
% xlim([0,360])
% legend('k=2','k=10')
% xlabel("Index of test points")
% ylabel("Error distance with attacker know partial DB&AP (m)")

%%same k, but different type of attacks
x=[1:10:360];
avg1_k = universe3(1:10:360,2,1);
avg2_k = universe4(1:10:360,2,1);
avg3_k = universe1(1:10:360,2,1);
avg4_k = universe2(1:10:360,2,1);
plot(x,avg1_k,'-o',x,avg2_k,'-+',x,avg3_k,'-.',x,avg4_k,'--','LineWidth',1.2)
xlim([0,360])
legend('optimal attack','know db','control ap','partial attack')
xlabel("Index of test points with e.g. 3 evil APs")
ylabel("Error distance under attack (m)")

% same test point, but different number of evil AP
% x=[1:35];
% avg1 = squeeze(universe3(143,2,:));
% avg2 = squeeze(universe4(143,2,:));
% avg3 = squeeze(universe1(143,2,:));
% avg4 = squeeze(universe2(143,2,:));
% %plot(x,avg1,x,avg2,x,avg3,x,avg4,'LineWidth',1.2)
% plot(x,avg1,'-o',x,avg2,'-+',x,avg3,'-.',x,avg4,'--','LineWidth',1.2)
% legend('optimal attack','know db','control ap','partial attack')
% xlabel("Number of evil APs at same location")
% ylabel("Error distance under attack (m)")

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')







