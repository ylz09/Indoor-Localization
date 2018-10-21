%function [] = set_coords(n)
n=72;
%rpc = zeros(2,0);
rpc = [];
x = 17.84;
y = 17.84;
for i = 1 : n
	if i <= 18 			    % k1=18
		rpc = [rpc;i-1,0];
	elseif i <= 36		    % k2 = 36
		rpc = [rpc;x,i-19]; % x fixed value = 17.84
	elseif i <= 54		    % k3 = 64
		rpc = [rpc;x-(i-37),y];  % y fixed value = 17.84
	else
		rpc = [rpc;0, y-(i-55)]; % total 18*4 = 72 reference points
	end
end

save ./mat/rpc.mat rpc %reference points cocrdinate
% fuction [upc] = set_upc_ac(rpc,upc,j,d,s,t)
% fuction [upc] = set_upc_bd(rpc,upc,j,d,s,t)
upc=[];
upc = set_upc_ac1(rpc,	upc,	0,      0.3,	1,      90);
upc = set_upc_ac1(rpc,	upc,	36,     -0.3,	181,    270);

upc = set_upc_bd1(rpc,   upc,    18,     0.3,    91,     180);
upc = set_upc_bd1(rpc,   upc,    54,     -0.3,   271,    360);
save ./mat/upc.mat upc %user points cocrdinate

function [upc] = set_upc_ac1(rpc,upc,j,d,s,t)
for i = s : 5 : t
    j = j + 1;
    x = rpc(j,1);
    y = rpc(j,2);
    upc(i+0,:) = [x-d, y];
    upc(i+1,:) = [x+d, y];
    upc(i+2,:) = [x-d, y-d];
    upc(i+3,:) = [x  , y-d];
    upc(i+4,:) = [x+d, y-d];
end
end

function [upc] = set_upc_bd1(rpc,upc,j,d,s,t)
for i = s:5:t
	j = j + 1;
	x = rpc(j,1);
	y = rpc(j,2);
	upc(i+0,:) = [x, y-d ];
	upc(i+1,:) = [x, y+d ];
	upc(i+2,:) = [x+d,y-d];
	upc(i+3,:) = [x+d, y];
	upc(i+4,:) = [x+d, y+d];
end
end

