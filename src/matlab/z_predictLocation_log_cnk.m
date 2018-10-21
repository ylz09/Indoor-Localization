%%
function [TF] = predictLocation_log_cnk(rssvector, distribution,opt,fap)
% nm: number of landmarks; na: number of APs; np: 2, mean & sigma
[nm,na,np] = size (distribution);

predictLoc = -1;
maxp = -inf;

for i = 1 : nm
    jp = 0; % joint probability density    
    sorted_pdfs = zeros(1,0);

    %% for fake ap pdf
    % fap should be take out from the rssvector, because they should not be
    % sorted. They should remain the position after sort.
    fapsize = size(fap,2);
    if fapsize ~= 0
        for t = 1 : size(fap,2)
            if fap(t) > size(rssvector,2) % if fake ap is not in the vector, then just delete
                fap(t:end) = [];
                break;
            end
        end
        fap_pdf = normpdf(rssvector(fap),distribution(i,fap,1),distribution(i,fap,2)); % store then insert to the original position
        rssvector(fap) = []; % delete from the rssvector
    end
    
    %%
    norm=[];
    k=1;
%     for j = 1 : size(rssvector,2)
%         if rssvector(j) ~= 0
%             norm(k)= normpdf(rssvector(j),distribution(i,j,1),distribution(i,j,2));
%             k=k+1;
%             %norm = [norm, normpdf(rssvector(j),distribution(i,j,1),distribution(i,j,2))];
%         elseif distribution(i,j,1) ~= 0  %if didn't receive,then mean it's very small, -120
%             norm(k)= normpdf(-120,distribution(i,j,1),distribution(i,j,2));
%             k=k+1;
%         end
%     end
    norm= normpdf(rssvector,distribution(i,:,1),distribution(i,:,2));
    norm(isnan(norm)) = -inf;
    [sorted_pdfs,index] = sort(norm,'descend');
  
    %% for fake ap pdf
    % here need change the sorted_pdfs to insert the fake aps pdf
    if fapsize ~= 0
        cnt = size(sorted_pdfs,2) + size(fap_pdf,2);
        pdfs = zeros(1,cnt)-1;
        % recover the fake ap pdf position
        for ii = 1 : size(fap,2)
            pdfs(fap(ii)) = fap_pdf(ii);
        end
        %insert the sorted pdf in order
        c=1;
        for ii = 1 : cnt
            if pdfs(ii) ~= -1
                pdfs(ii) =  sorted_pdfs(c);
                c = c + 1;
            end
        end
        sorted_pdfs = pdfs;
    end
    
    %%
    if size(sorted_pdfs,2) < opt
        opt = size(sorted_pdfs,2); % for robust
    end

    valid = 0;
    for p = 1 : opt
        if sorted_pdfs(p) ~= -inf 
            %mu = distribution(i,index(p),1);
            %si = distribution(i,index(p),2);
            %peak = normpdf(mu,mu,si);
            %pdf = sorted_pdfs(p);
            %jp = jp +log10((peak+pdf)/abs(mu-rssvector(index(p)))); % distribution(i,index(p),2) abs(mu-rssvector(p))
            %jp = jp +log10((peak+pdf))*(100000*abs(mu-rssvector(index(p))));
            jp = jp +log10(sorted_pdfs(p));
            valid = valid +1;
            %elseif distribution(i,j,2) == 0
            %jp = jp + log10(1/60); % 60 is the estimated number of samples, not accuracy
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



