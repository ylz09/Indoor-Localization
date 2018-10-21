%%
function [TF] = predictLocation_log(rssvector,distribution)

[nm,na,np] = size (distribution);

predictLoc = -1;
maxp = -inf;

%attack
%rssvector(17:20)=-100;

for i = 1 : nm
    jp = 0; % joint probability density
    for j = 1 : na % if we use c(n,k) then just sort and change na to k
        if distribution(i,j,2) ~= 0 && rssvector(j) ~= 0 %-95 means null
            jp = jp + log10(normpdf(rssvector(j),distribution(i,j,1),distribution(i,j,2)));
        elseif rssvector(j) == 0 % which is very small, say -120
            jp = jp + log10(normpdf(-120,distribution(i,j,1),distribution(i,j,2)));
        end
    end

    if jp > maxp
        maxp = jp;
        predictLoc = i;
    end
end

%%
TF = [predictLoc,maxp];
%disp(TF)            

