%%
% matlab sort is a very stupid algorithm
% if the matrix is 2d, then it will totally change the matrix if you apply
% sort directly
% [sorted, inde] = sort(arr,'descend'); only this way to keep original
% index
% Or like this method, which needs serval transpose. Not very
% straightforward

clc;
%all_data = importdata('all_data_without_label.dat');
all_data = importdata('all.dat');
ap_data = transpose(all_data);

[r,c] = size(ap_data);
not_null = 0;
ap_not_null_cnt = zeros(2,r);
ap_not_null_rate = zeros(2,r);

for i = 1: r % r aps
	not_null = 0;
    
    for j = 1: c % c samples of rss
		if ap_data(i,j) ~= 0
			not_null = not_null + 1;
		end
    end
    
	ap_not_null_cnt(:,i) = [not_null,i]; % first row is ap index; second row is !null count
	ap_not_null_rate(:,i) = [not_null/c,i];
end
ap_not_null_rate = ap_not_null_rate';
reverse_ap_notnull_rate = sortrows(ap_not_null_rate,1);
%old_rate = reverse_ap_notnull_rate';
new_rate = reverse_ap_notnull_rate';

%% keep stable ap whose not null rate is at least 60%
% the list is sorted
% 1  2 8 12 13 14 16 20 21 22 23 24 25 26 29 30 31 32 33 34 37 38 50 51 52 53
ap_set=zeros(1,0);k=1;
for i =1 : size(new_rate,2)
	if new_rate(1,i)>= 0.5
		ap_set(k) = new_rate(2,i);
		k = k + 1;
	end
end
ap_set=sort(ap_set);
save stable_ap.mat ap_set;
