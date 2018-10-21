s=1;
k=3;
h=zeros(1,1);
for i=1:size(mt,2)
	if mt(k,i) ~= -95
		h(s) = mt(k,i);
		s=s+1;
	end
	
end
hist(h)
figure

[mu,sig]=normfit(mt(k,:));
norm=normpdf(mt(k,:),mu,sig);
plot(mt(k,:),norm,'r.')
