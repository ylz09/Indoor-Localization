close all
clear
clc
load NoAttack.mat
load Jamming.mat
% load cnk_no_atk.mat
% load cnk_atk.mat
% load jamKNN.mat
load cnk_jam.mat
load cnn_jam.mat
% AveErr_Atk_Horus=cnn_atk';
load jamMedian.mat

load cnk_fak.mat
load cnn_fak.mat

load cnn.mat
load cnk.mat

load cnk_fakerss.mat
load cnn_fakerss.mat

% %median
% MaxErr_median=max(ErrDis_median);
% cdf_median= calculateCdf(ErrDis_median,ceil(MaxErr_median));
% 
% MaxErr_Jam_median=max(Err_Jam_median);
% cdf_Jam_median= calculateCdf(Err_Jam_median,ceil(MaxErr_Jam_median));
% 
% plot(0:ceil(MaxErr_median)-1,cdf_median,'-g','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(0:ceil(MaxErr_Jam_median)-1,cdf_Jam_median,'-.g','MarkerSize',6,'LineWidth',1.5)
% hold on

% knn
MaxErr_KNN=max(ErrDis_KNN);
cdf_KNN= calculateCdf(ErrDis_KNN,ceil(MaxErr_KNN));
MaxErr_Jam_KNN=max(Err_Jam_KNN);
cdf_Jam_KNN= calculateCdf(Err_Jam_KNN,ceil(MaxErr_Jam_KNN));
plot(0:ceil(MaxErr_KNN)-1,cdf_KNN,'-b','MarkerSize',6,'LineWidth',1.5)
hold on
plot(0:ceil(MaxErr_Jam_KNN)-1,cdf_Jam_KNN,'-.b','MarkerSize',6,'LineWidth',1.5)
hold on

% cnn
% MaxErr_Horus=max(ErrDis_Horus);
% cdf_Horus= calculateCdf(ErrDis_Horus,ceil(MaxErr_Horus));
% MaxErr_atk_Horus=max(AveErr_Atk_Horus);
% cdf_atk_Horus= calculateCdf(AveErr_Atk_Horus,ceil(MaxErr_atk_Horus));
% 
% plot(0:ceil(MaxErr_Horus)-1,cdf_Horus,'-g','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(0:ceil(MaxErr_atk_Horus)-1,cdf_atk_Horus,'-.g','MarkerSize',6,'LineWidth',1.5)
% hold on

% %cnk
% MaxErr_cnk=max(cnk_no_atk);
% cdf_cnk= calculateCdf(cnk_no_atk,ceil(MaxErr_cnk));
% MaxErr_atk_cnk=max(cnk_atk);
% cdf_atk_cnk= calculateCdf(cnk_atk',ceil(MaxErr_atk_cnk));
% 
% 
% plot(0:ceil(MaxErr_cnk)-1,cdf_cnk,'-r+','MarkerSize',6,'LineWidth',1.5)
% hold on
% plot(0:ceil(MaxErr_atk_cnk)-1,cdf_atk_cnk,'-.r+','MarkerSize',6,'LineWidth',1.5)
% hold on

% cnn & cnk fake
MaxErr_fak_cnk=max(cnk_fak);
cdf_fak_cnk= calculateCdf(cnk_fak',ceil(MaxErr_fak_cnk));
MaxErr_fak_cnn=max(cnn_fak);
cdf_fak_cnn= calculateCdf(cnn_fak',ceil(MaxErr_fak_cnn));


plot(0:ceil(MaxErr_fak_cnk)-1,cdf_fak_cnk,'-r+','MarkerSize',6,'LineWidth',1.5)
hold on
plot(0:ceil(MaxErr_fak_cnn)-1,cdf_fak_cnn,'-.r+','MarkerSize',6,'LineWidth',1.5)
hold on

% cnn & cnk no fake?
MaxErr_cnk=max(cnk);
cdf_cnk= calculateCdf(cnk,ceil(MaxErr_cnk));
MaxErr_cnn=max(cnn);
cdf_cnn= calculateCdf(cnn',ceil(MaxErr_fak_cnn));

plot(0:ceil(MaxErr_cnk)-1,cdf_cnk,'-k+','MarkerSize',6,'LineWidth',1.5)
hold on
plot(0:ceil(MaxErr_cnn),cdf_cnn,'-.k+','MarkerSize',6,'LineWidth',1.5)
hold on

% cnn & cnk fake rss
MaxErr_cnk_fakerss=max(cnk_fakerss);
cdf_cnk_fakerss= calculateCdf(cnk_fakerss',ceil(MaxErr_cnk_fakerss));
MaxErr_cnn_fakerss=max(cnn_fakerss);
cdf_cnn_fakerss= calculateCdf(cnn_fakerss',ceil(MaxErr_cnn_fakerss));

plot(0:ceil(MaxErr_cnk_fakerss)-1,cdf_cnk_fakerss,'-g+','MarkerSize',6,'LineWidth',1.5)
hold on
plot(0:ceil(MaxErr_cnn_fakerss)-1,cdf_cnn_fakerss,'-.g+','MarkerSize',6,'LineWidth',1.5)
hold on

%legend('Median','Median-Atk','KNN','KNN-Atk','CNK-Atk','CNN-Atk','CNK','CNN')
legend('KNN','KNN-Atk','CNK-Atk','CNN-Atk','CNK','CNN','CNK_FRSS','CNN_FRSS','location','best')
% legend('KNN','Horus','AtkKNN','AtkHorus','cnkNoAtk','CnkAtk');
ylabel('CDF','fontsize',20)
xlabel('Average estimated distance','fontsize',20)
set(gca,'fontsize',18)
axis([0 18 0 1])

% figure
%  [x,f]=ecdf(mle_cnn_errdist);
% plot(f,x,'r')