clear;clc;
load ./mat/userMap.mat;
load ./mat/rssMap.mat;

mu=R(:,:,1);
%T=U;
T=[U;mu];
U=[U;mu];

for p=1:432
U=T(1:p,:);
[m,n]=size(U);

for i=1:m %ith user
    for j=1:size(mu,1) % check each reference point in database
        tmp=0;
        for k=1:35
            if U(i,k)==0 && mu(j,k)~=0 %user 0,not received
                U(i,k)=-120;
            end
%             if U(i,k)~=0 && mu(j,k)==0 %mu 0 ignore
%                 U(i,k)=0;
%             end
            %temp(j,k)=(mu(j,k)-U(i,k))^2;
            tmp = tmp+(mu(j,k)-U(i,k))^2;
        end
        %Dis(i,j)=median(temp(j,:));
        Dis(i,j)=sqrt(tmp);
        
%         Dis(i,j)=median(((mu(j,:)-U(i,:)).^2));
        %distance between user i and reference point j.
    end
end
cnt_t=[];
for i=1:m %ith user
    [tempDis,index]=sort(Dis(i,:)); 
    %cnt_t(i)=index(1);
    cnt_t = [cnt_t,index(1:10)];
end

cnt_m(p)=size(unique(cnt_t),2);
end

h = figure;
x=1:432;

z=cnt_m; %y=cnt;
zz1 = smooth(x,z,0.15,'loess');


plot(x,z,'g.',x,zz1,'k-', 'LineWidth',2)
%set(gca,'YLim',[0 50])
xlabel('Number of attacker test locations');
ylabel('Number of revealed reference points')
legend('Median','Median-Trend')

% store full screen figure
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'filename','-dpdf','-r0')