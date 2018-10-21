function [location] = weight_cnk(rssvector,distribution)

[nm,na,np] = size (distribution);
predictLoc = -1;
maxp = 0;
k = 20

pdf_mat = zeros(2,0);

for j = 1 : na % na is number of ap
    normpdf(rssvector(j),distribution(:,j,1),distribution(:,j,2)); 
    norm(isnan(norm)) = -inf; 
    [sorted_pdfs,index] = sort(norm,'descend');