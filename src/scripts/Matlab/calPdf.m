function [F] = calPdf(LocationMatrix,F,index)
%INPUT:
    %LocationMatrix is a two dimension matrix
    %m rows:    each row is an RSS vector of all APs
    %n columns: all the collected samples corresponding to an AP
%OUTPUT:
    %1d(index):	index of the landmarks
    %2d(j):     index of Ap
    %3d:        mean and std

[m, n] = size(LocationMatrix);

for j = 1:n %for each column, AP
    temp = zeros(1,1);
    k = 1;
    for i = 1:m %for each row, repeated times
        if LocationMatrix(i,j) ~= 0
            temp(k) = LocationMatrix(i,j);
            k = k+1;
        end
    end
    [F(index,j,1), F(index,j,2)] = normfit(temp);
end
