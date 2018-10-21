%% keep stable ap whose not null rate is at least 60%
% the list is sorted
% 1  2 8 12 13 14 16 20 21 22 23 24 25 26 29 30 31 32 33 34 37 38 50 51 52 53
ap_set=zeros(1,0);k=1;
for i =1 : size(new_rate,2)
	if new_rate(1,i)>= 0.8
		ap_set(k) = new_rate(2,i);
		k = k + 1;
	end
end
ap_set=sort(ap_set);
save stable_ap.mat ap_set;