function [p1,t1,minS]=dtbt2(p0,t0,l)
% p0=ps{k};
% t0=ts{k};
p0=p0(:,1:4);
t0=t0(:,1:4);
load('epass');taxi=importdata('taxi.txt');
n=size(p0,1);
m=size(t0,1);
if min([n m])==0 || sum(sum(p0))==0 || sum(sum(t0))==0
    p1=[p0 zeros(n,1)];t1=[t0 zeros(m,1)];minS=0;
    return
end
if isempty(p0)==1 || isempty(t0)==1
    p1=[p0 zeros(n,1)];t1=[t0 zeros(m,1)];minS=0;
    return
end
for i=1:n
    for j=1:m
        S1(i,j)=l2s(pass(p0(i,1),1:2),taxi(t0(j,1),1:2));
    end
end
P=zeros(n,1);
T=zeros(m,1);
minS=zeros(n,1);
for i=1:n                   % 乘客 i
    [~,id]=sort(S1(i,:),2);  	% 对 S 的每行以降序排列
    for j=1:m               % 较优选择 j
        if l==1;s=13.14;else s=10/60*40;end
        if T(id(j))==0 && S1(i,id(j))<=s;
            T(id(j),1)=i;	% 车 id(j) 搭载 乘客 i
            P(i,1)=id(j);	% 乘客 i 乘坐 id(j) 车
            minS(i,1)=S1(i,id(j));
            break
        end
    end
    if sum(T)==m;
        break
    end
end
p1=[p0,P];
t1=[t0,T];

end