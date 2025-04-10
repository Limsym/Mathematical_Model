function [AT,ncs,dN,dC,report]=BetaGo(path,DT)          % departure time
% 求解 DT 时刻出发，所需时间、资源
load('B01','C0','c','dig','dist','m','M','p','stay','T','W','walk','whe')
a = fix(path/10) ; b = mod(path,10);
S = dist(a,b);          % 最佳预期旅行时间
s = 0 ; ET = 0;
for i = DT : 30         % 第 i 天末！
    ET = ET + 1;        % （又）经过了 1 天
    if i >= DT && whe(i) ~= 3
        s = s + 1;      % 第 i 天操作后的累计旅程
        if s == S
            back = 1;	% 抵达目的地
            break
        end
    end
    if i == 30 && s < S
        back = 0;
    end
end
AT = DT + ET - 1 ;                                       % Arrived Time
for i=1:2
    for j=DT:AT
        if whe(j)==3
            fixwalk = 1/2;
        else fixwalk = 1;
        end
        ncs(i,j) = -walk*fixwalk*c(i,whe(j));        % num comsuption
    end
end
% 统计消耗、最大负重及必要开支
for i=1:2
    dN(i,1) = sum(ncs(i,:));
    Load(i) = dN(i,1)*m(i);
    pay(i,1) = dN(i,1)*p(i);
end
dN=dN';
dC=sum(pay);
Load(3) = sum(Load);
if Load(3)<W
    overload=1;             % 可行载重
else overload=0;
end
BT=DT+1;                    % 购买时间（待修改）
C=zeros(1,AT);dC=C;
for i=DT+1:AT
    if i==BT;
        dC(DT)=sum(pay);
    else dC(i)=0;
    end
    if i==1
        C(i)=C0+dC(i);
    else
        C(i)=C(i-1)+dC(i);
    end
end
report=[back overload];
end