function [U] = fimport(U, dir, pre, num)

for k = 1 : num
    for i = 1:5
        file_name = sprintf('%s/%s%d-%d.txt',dir,pre,k,i);	%disp(file_name); % a files
        if exist(file_name,'file') ~= 0
            data = importdata(file_name); 
            % implement new mean function
            [m,n]=size(data);
            colm = []; % mean of each column
            allm = []; % mean of all 
            
            for c = 1 : n
                vec = [0];
                for r = 1 : m
                    if data(r,c) ~= 0
                        vec=[vec,data(r,c)];
                    end
                end
                allm=[allm,mean(vec)];            
            end
            U = [U;allm];
        else
            U = [U;zeros(1,53)]; % 53 not good...
        end
    end
end