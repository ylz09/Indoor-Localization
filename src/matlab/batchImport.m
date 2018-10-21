%% script is a little more convinent than function
F=[];

F=batchImport1('map','a',F);
F=batchImport1('map','b',F);
F=batchImport1('map','c',F);
F=batchImport1('map','d',F);

F = filterBadap(F);

R=F;
save rssMap.mat R;
disp(size(F));

%% inner function
function [F] = batchImport1(dir,pre,F)
hop = (pre-'a')*18;
for k = 1 : 18
    file_name = sprintf('%s/%s%d.txt',dir,pre,k); %disp(a_file_name);
    LandmarkMatrix = importdata(file_name); F = calPdf(LandmarkMatrix, F, hop+k);
end
end

function [F] = filterBadap(F)
load stable_ap.mat ap_set;
all_ap=(1:53);
bad_ap=setdiff(all_ap, ap_set);
F(:,bad_ap,:)=[];
end
%---------------------------------------------------------------------------------------------------------------------------
% old version
% function [F] = batchImport(dir,F)
% 
% index = 0;
% 
% for k = 1 : 18
%     a_file_name = sprintf('%s/a%d.txt',dir,k); %disp(a_file_name);
%     b_file_name = sprintf('%s/b%d.txt',dir,k); %disp(b_file_name);
%     LandmarkMatrix = importdata(a_file_name); F = calPdf(LandmarkMatrix, F, k);
%     LandmarkMatrix = importdata(b_file_name); F = calPdf(LandmarkMatrix, F, k+18); 
%     index = index +2;
% end
% 
% 
% for k = 1 : 20
%     c_file_name = sprintf('%s/c%d.txt',dir,k);
%     d_file_name = sprintf('%s/d%d.txt',dir,k);
%     LandmarkMatrix = importdata(c_file_name); F = calPdf(LandmarkMatrix, F, k+36); 
%     LandmarkMatrix = importdata(d_file_name); F = calPdf(LandmarkMatrix, F, k+56); 
%     index = index +2;
% end
% 
% R=F;
% save rssMap.mat R;
% 
% % S=F;
% % save sigleMap.mat S;
% 
% d = size(F);
% %disp(index)
% disp(d);
    

