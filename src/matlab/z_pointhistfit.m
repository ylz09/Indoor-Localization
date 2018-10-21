
for k=1:53
    h=zeros(1,1);
    s=1;
    for i=1:size(tp,2)
        if tp(k,i) ~= 0
            h(s) = tp(k,i);
            s=s+1;
        end
    end
    
    if s > 10
        figure
        histfit(h)
    end
end