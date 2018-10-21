function [U] = importUser(dir,U)
%t=[];t=importUser('userdata',t);
U = fimport(U, dir, 'a', 18);
U = fimport(U, dir, 'b', 18);
U = fimport(U, dir, 'c', 18);
U = fimport(U, dir, 'd', 18);

%function [F] = filterBadap(F)
load stable_ap.mat ap_set;
all_ap=(1:53);
bad_ap=setdiff(all_ap, ap_set);
U(:,bad_ap)=[];
%end
save userMap.mat U;

d = size(U);
%disp(index)
disp(d);
    

