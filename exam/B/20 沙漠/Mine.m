function [dN,day1]=Mine(day0,ETM,dig,whe)
% day0 表示 抵达矿场的翌日
% day0=11;          ETM=9=stay_time;    dig=7;
load('B01','c')
rest=ETM-dig;
day1=day0+ETM-1;    % 留在矿场的最后一日
% day1=DT=19;       path=32;
storm=0;hot=0;
for i=day0:day1
    if whe(i)==3
        storm=storm+1;
    elseif whe(i)==2
        hot=hot+1;
    end
end
for i=1:2
    for j=day0:day1
        ncs(i,j) = - c(i,whe(j))*3;        % 如果每天都采挖矿，每天的消耗量
    end
    if rest <= storm
        dN(i) = sum(ncs(i,:)) + c(i,3)*2*rest;
    elseif rest > storm && rest <= storm+hot
        dN(i) = sum(ncs(i,:)) + c(i,3)*2*storm + c(i,2)*2*(rest-storm);
    else dN(i) = sum(ncs(i,:)) + c(i,3)*2*storm + c(i,2)*2*hot - c(i,1)*2*(rest-storm-hot);
    end
end