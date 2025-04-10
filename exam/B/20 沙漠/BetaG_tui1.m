function [N,Pay,R,AT,report]=BetaGo(path,DT)          % departure time
load('B01','c','dig','dist','m','M','p','R0','stay','T','W','walk','whe')
a=path(1);b=path(2);
S = dist(a,b);         % 最佳预期旅行时间
s = 0;
for i=1:30
    if i >= DT && whe(i) ~= 3
        s = s+1;
        if s == S;
            ET=i;    % Elapsed Time
            break
        end
    end
end
AT = DT + ET;                                       % Arrived Time
for i=1:2
    for j=DT+1:AT
        if whe(j)==3
            fixwalk = 1/2;
        else fixwalk = 1;
        end
        ncs(i,j) = walk*fixwalk*c(i,whe(j));        % num comsuption
    end
end
% 统计消耗、最大负重及必要开支
for i=1:2
    N(i,1) = sum(ncs(i,:));
    Load(i) = N(i,1)*m(i);
    pay(i,1) = -N(i,1)*p(i);
end
Load(3) = sum(Load);
if Load(3)<W
    overload=0;
else overload=1;
end
BT=DT+1;            % 购买时间
for i=DT+1:AT
    if i==BT;
        Pay(i)=sum(pay);
    else Pay(i)=0;
    end
    if i==1
        R(i)=R0+Pay(i);
    else R(i)=R(i-1)+Pay(i);
    end
end
report=overload;
end