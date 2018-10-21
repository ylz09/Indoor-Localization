pre = 'three';

low = [];
mid = [];
high = [];
barrier = [];

min=inf;

bd = []; %barrier with different distance
dd = []; %different transmission power with different distance
lev1=[];lev2=[];lev3=[];

for i = 1 : 20
    tmp = [];
    file_name = sprintf('%s/%d.txt',pre,i);
    data = importdata(file_name);
    barrier(i) = mean(data);
    bd(:,i) = data(1:58);
    
    L_file_name = sprintf('%s/L%d.txt',pre,i);
    L_data = importdata(L_file_name);
    low(i) = mean(L_data);
    tmp = [tmp,L_data'];
    lev1(:,i) = tmp(1:50);
    
    m_file_name = sprintf('%s/m%d.txt',pre,i);
    m_data = importdata(m_file_name);
    mid(i) = mean(m_data);
    tmp = [tmp,m_data'];
    lev2(:,i) = tmp(1:50);
    
    h_file_name = sprintf('%s/h%d.txt',pre,i);
    h_data = importdata(h_file_name);
    high(i) = mean(h_data);
    tmp = [tmp,h_data'];
    lev3(:,i) = tmp(1:50);
    
    if size(tmp,2) < min
        min = size(tmp,2);
    end
    
    dd(:,i) = tmp(1:172)';
    
end

save ./mat/powerLevel.mat low mid high barrier

