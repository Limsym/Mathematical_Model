function [dN]=Mine(day1,ET1,dig)
% ET1=10;
load('B1','whe')
% dig=8;
rest=ET1-dig;
% day1=11;
day2=day1+ET1;
DT=day2;
% ET=day2-day1+1;
% path=32;
% [AT,ncs,dN,dC,report]=BetaGo(path,DT)
storm=0;hot=0;
for i=day1:day2
    if whe(i)==3
        storm=storm+1;
    elseif whe(i)==2
        hot=hot+1;
    end
end
for i=1:2
    for j=day1:day2
        ncs(i,j) = - c(i,whe(j))*3;        % num comsuption
    end
    if rest <= storm
        dN(i) = sum(ncs(i,:)) + c(i,3)*2*rest;
    elseif rest > storm && rest <= storm+hot
        dN(i) = sum(ncs(i,:)) + c(i,3)*2*storm + c(i,2)*2*(rest-storm);
    else dN(i) = sum(ncs(i,:)) + c(i,3)*2*storm + c(i,2)*2*hot - c(i,1)*2*(rest-storm-hot);
    end
end