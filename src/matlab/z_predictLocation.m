%%
% Input are:
%   a 1*54 rss vector; the last element is the predefined label;
%   80*53*2 distribution matrix; as a prameter don't need load every call

% Output are the mode of the predicted location; maxp here is non-sense
%%
function [TF] = predictLocation(rssvector,distribution)
%   obsolete, can use predictionLoacation_weight and set k=1
%   nm: the num of the landmark, avoid l becuase 1
%   na: the num of the AP
%   np: mu and sigma, p means parameter
[nm,na,np] = size (distribution);
%len = size (rssvector,2);

predictLoc = -1;
maxp = 0;
k = 1; % candidate has k options

all_votes=zeros(1,0);
    
for j = 1 : na % if we use c(n,k) then just sort and change na to k
    % single vote
    [maxp,index] = max(normpdf(rssvector(j),distribution(:,j,1),distribution(:,j,2)));                
    all_votes = [all_votes,index];
end

all_votes;
predictLoc = mode(all_votes);

TF = [predictLoc];
%disp(TF)
            

