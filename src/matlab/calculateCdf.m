%my new version cdf function
%just changed the variable name, much readable
%the ecdf seems better in most cases
function [cdf]=calculateCdf(input_vec,maxv)
val_cnt=zeros(1,maxv); % store the number of each value appears
cdf=zeros(1,maxv); % the cumulative frequency
%[m,n]=size(input_vec);
m=size(input_vec,2);

for i=1:m
    if input_vec(i)==0
        val_cnt(1)=val_cnt(1)+1;
    end
    for k=2:maxv-1
        if input_vec(i)<=(k-1) && input_vec(i)>(k-2) % k-2 <= x <=k-1, k=2
            val_cnt(k)=val_cnt(k)+1;
            break;
        end
    end
    if input_vec(i)>(maxv-1)
        val_cnt(maxv-1)=val_cnt(maxv-1)+1;
    end
end
cdf(1)=val_cnt(1)./(m);
for i=2:maxv
    cdf(i)=cdf(i-1)+val_cnt(i)./(m);
end