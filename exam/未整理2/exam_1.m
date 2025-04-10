filename = '附件.xls';
S1=xlsread(filename,'牛奶配送点的数据','A2:D93');
S2=xlsread(filename,'牛奶配送点之间的道路','A2:B141');
clear filename
n=93;
n(1,1)=0;
for i=1:92
    n(i+1,1)=S1(i,4);
end
for i=1:93
    for j=1:93
        dist(i,j)=10000;
    end
end
[a,b]=size(S2);
for k=1:a
    for i=1:93
        for j=1:93
            if i-1==S2(k,1)&&j-1==S2(k,2)
                dist(i,j)=sqrt((S1(i-1,2)-S1(j-1,2))^2+(S1(i-1,3)-S1(j-1,3))^2);
            end
            if i==1&&j>1
                dist(i,j)=sqrt((S1(j-1,2))^2+(S1(j-1,3))^2);
            end
        end
    end
end
dist(24,23)=sqrt((S1(23,2)-S1(13,2))^2+(S1(23,3)-S1(13,3))^2)+sqrt((S1(24,2)-S1(13,2))^2+(S1(24,3)-S1(13,3))^2);
dist(22,23)=sqrt((S1(23,2)-S1(13,2))^2+(S1(23,3)-S1(13,3))^2)+sqrt((S1(22,2)-S1(13,2))^2+(S1(22,3)-S1(13,3))^2);

% 来回里程相同
for i=1:93
    for j=1:93
        if dist(i,j)>dist(j,i)
            dist(i,j)=dist(j,i);
        end
    end
end