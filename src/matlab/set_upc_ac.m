function [upc] = set_upc_ac(rpc,upc,j,d,s,t)

for i = s : 5 : t
	j = j + 1;
	x = rpc(j,1);
	y = rpc(j,2);
	upc(i+0,:) = [x-d, y];
	upc(i+1,:) = [x+d, y];
	upc(i+2,:) = [x  , y-d];
	upc(i+3,:) = [x-d, y-d];
	upc(i+4,:) = [x+d, y-d];
end