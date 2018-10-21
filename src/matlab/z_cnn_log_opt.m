%%
function [TF] = cnn_log_opt(rssvector, distribution,opt,fap)

[nm,na,np] = size (distribution);

predictLoc = -1;
maxp = -inf;

for i = 1 : nm
    jp = 0; % joint probability density    
    sorted_pdfs = zeros(1,0);

     %%
    norm=[];
    k=1;
    for j = 1 : size(rssvector,2)
        if rssvector(j) ~= 0
            norm(k)= normpdf(rssvector(j),distribution(i,j,1),distribution(i,j,2));
            k=k+1;
        elseif distribution(i,j,1) ~= 0  %if didn't receive,then mean it's very small, -120
            norm(k)= normpdf(-120,distribution(i,j,1),distribution(i,j,2));
            k=k+1;
        end
    end
    %norm= normpdf(rssvector,distribution(i,:,1),distribution(i,:,2));
    norm(isnan(norm)) = -inf;
    [sorted_pdfs,index] = sort(norm,'descend');
    %optimal attack, set the best k match pdfs to -inf. Here e.g. k = 3
    k = 3;
    sorted_pdfs(1:k) = -inf;
    
    if size(sorted_pdfs,2) < opt
        opt = size(sorted_pdfs,2); % for robust
    end

    valid = 0;
    for p = 1 : opt
        if sorted_pdfs(p) ~= -inf 
            jp = jp +log10(sorted_pdfs(p));
            valid = valid +1;
        end
    end
    jp = jp/valid;
	%disp([i,jp])
    if jp > maxp
        maxp = jp;
        predictLoc = i;
    end
end

%%
TF = [predictLoc,maxp];
