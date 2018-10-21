%%
% predictLocation_weight is same with the predictLocation_weight_cnk
% Input are:
%   a 1*54 rss vector
%   76*53*2 distribution matrix; as a prameter don't need load every call

% Output are the mode of the predicted location; maxp here is non-sense
%%
function [TF] = predictLocation_weight(rssvector,distribution, kap,v)
%   nm: the num of the landmark, avoid l becuase 1
%   na: the num of the AP
%   np: mu and sigma, p means parameter
[nm,na,np] = size (distribution);
%%
predictLoc = -1;
maxp = 0;
k = v; % AP has k votes for one RSS reading, if k=1 it's same with the predictLocation function.
all_votes=zeros(1,0); % all the votes with duplicate due to the weight. If the first location will duplicate k times.
%%
for j = 1 : kap % if we use c(n,k) then just sort and change na to k
    % change to multiple votes
    
    %This is not good, 1 sigma 0 is ok to ignore; 2 uniform distribution is
    % treated as normal distribution, not good!
    % change it to for loop later on! 
    % Just 2 case, if sigma =0, ignore (we can change 0 to -1, same NaN result)
    % elseif  (need to distingush norm and uniform distribution), not easy!
    
    norm = normpdf(rssvector(j),distribution(:,j,1),distribution(:,j,2)); 
    % sigma=0,then the pdf is NaN. sort algorithm take NaN as the biggest number.
    % maybe NaN = 1/60 is better.
    norm(isnan(norm)) = -inf; 
    [sorted_pdfs,index] = sort(norm,'descend');  
    
    % k minimum
%     tail = find(sorted_pdfs<0, 1); 
%     if size(tail,1) ~= 0
%         kind = index(tail-k:tail-1);
%     else
%         kind = index(end-k+1:end);
%     end
   
    
    %k maximum
    kind = index(1:k); % k_ind is biggest k votes
    
    %k random
    %kind = randperm(nm, k);

    % expend each vote by its weight, which is the reverse index.
    % e.g. k,...2,1
    votes = zeros(1,0);
    %temp = [];
    for i = 1:k
        temp = [];
        for ii= 1:(k-i+1)
            temp(ii)=kind(i);
        end
        votes = [votes,temp];
    end
    all_votes = [all_votes,votes]; %vector expandes in-place
end
%%
predictLoc = mode(all_votes);
TF = predictLoc; %disp(TF)
