function [cdf]=calculateCdf(ErrDis,MaxErrF)
ErrFrequency=zeros(1,MaxErrF);
cdf=zeros(1,MaxErrF);
[m,n]=size(ErrDis);

for i=1:m
    if ErrDis(i)==0
        ErrFrequency(1)=ErrFrequency(1)+1;
    end
    for k=2:MaxErrF-1
        if ErrDis(i)<=(k-1) && ErrDis(i)>(k-2)
            ErrFrequency(k)=ErrFrequency(k)+1;
            break;
        end
    end
    if ErrDis(i)>(MaxErrF-1)
        ErrFrequency(MaxErrF-1)=ErrFrequency(MaxErrF-1)+1;
    end
end
cdf(1)=ErrFrequency(1)./(m);
for i=2:MaxErrF
    cdf(i)=cdf(i-1)+ErrFrequency(i)./(m);
end
    