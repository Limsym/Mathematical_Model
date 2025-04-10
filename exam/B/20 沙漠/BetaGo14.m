function [N,Pay,R,ad,report]=BetaGo14(path,td)   % tiem of departure
load('B01','c','dig','dist','m','M','p','R0','stay','T','W','walk','whe')
pd = dist(1,4);
for i=1:pd
    if whe(i) == 3
        bad(i) = 1;
    else bad(i) = 0;
    end
end
pd = pd + sum(bad);  % fix pd
for i=1:2
    for j=1:pd
        if bad(j)==1
            fixwalk = 1/2;
        else fixwalk = 1;
        end
        ncs(i,j) = walk*fixwalk*c(i,whe(j));   % num comsuption
    end
end
% 统计消耗、最大负重及必要开支
for i=1:2
    N(i,1) = sum(ncs(i,:));
    maxload(i) = N(i,1)*m(i);
    pay(i,1) = -N(i,1)*p(i);
end
maxload(3) = sum(maxload);
if maxload(3)<W
    overload=0
else overload=1;
end
buyd=td+1;
for i=1:pd
    if i==buyd;
        Pay(i)=sum(pay);
    else Pay(i)=0;
    end
    if i==1
        R(i)=R0+Pay(i);
    else R(i)=R(i-1)+Pay(i);
    end
end
ad=td+pd;                 % Arrived Day
report=overload;