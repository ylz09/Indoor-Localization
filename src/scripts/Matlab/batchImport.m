function [F] = batchImport(dir,F)

index = 1;

for k = 1 : 18
    a_file_name = sprintf('%s/a-%d.txt',dir,k); %disp(a_file_name);
    b_file_name = sprintf('%s/b-%d.txt',dir,k);
    LandmarkMatrix = importdata(a_file_name); F = calPdf(LandmarkMatrix, F, index); index = index +1;
    LandmarkMatrix = importdata(b_file_name); F = calPdf(LandmarkMatrix, F, index); index = index +1;
    
end

%Handle the m landmark which is stairway
LandmarkMatrix = importdata('rssdata/a-m.txt'); F = calPdf(LandmarkMatrix, F, index); index = index +1;
LandmarkMatrix = importdata('rssdata/b-m.txt'); F = calPdf(LandmarkMatrix, F, index); index = index +1;

for k = 1 : 20
    c_file_name = sprintf('%s/c-%d.txt',dir,k);
    d_file_name = sprintf('%s/d-%d.txt',dir,k);
    LandmarkMatrix = importdata(c_file_name); F = calPdf(LandmarkMatrix, F, index); index = index +1;
    LandmarkMatrix = importdata(d_file_name); F = calPdf(LandmarkMatrix, F, index); index = index +1;
end
save distribution.mat F
d = size(F);
disp(d);
    

