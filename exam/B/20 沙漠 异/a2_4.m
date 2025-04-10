%起点-村庄-矿山-终点 收益
clc
clear
weather = randsrc(100, 30, [1 2 3; 0.55 0.35 0.1]);
%关卡四
l1=8;%起点到终点距离
l2=5;%起点到村庄距离
l3=5;%起点到矿山距离
l4=2;%村庄到矿山距离
l5=3;%村庄到终点距离
l6=3;%矿山到终点距离 
T1=l1;T2=l2;T3=l3;T4=l4;T5=l5;T6=l6;T61=l6;
resource=[3 9 10;4 9 10];%不同天气不同资源所需量
cz=10000;%初始资金
js=1000;%基础收益
M=1200;%负重
pw=5;
pf=10;
Td=30;%截止时间
S1=0;bw01=0;bw11=0;bf01=0;bf11=0;t=0;T=0;
v=0;
for k=1:100
i=1;
while i<=T2
    if weather(k,i)==3
       T2=T2+1;
       w=resource(1,3);   %水消耗量（箱）
       f=resource(2,3);   %食物消耗量（箱）
    elseif weather(k,i)==2
       w=resource(1,2)*2;   %水消耗量（箱）
       f=resource(2,2)*2;   %食物消耗量（箱）
    else
       w=resource(1,1)*2;   %水消耗量（箱）
       f=resource(2,1)*2;   %食物消耗量（箱）
    end
       w1(i)=w;
       f1(i)=f;
       i=i+1;
end
while i<=T2+T4
    if weather(k,i)==3
       T4=T4+1;
       w=resource(1,3);   %水消耗量（箱）
       f=resource(2,3);   %食物消耗量（箱）
    elseif weather(k,i)==2
       w=resource(1,2)*2;   %水消耗量（箱）
       f=resource(2,2)*2;   %食物消耗量（箱）
    else
       w=resource(1,1)*2;   %水消耗量（箱）
       f=resource(2,1)*2;   %食物消耗量（箱）
    end
       w1(i)=w;
       f1(i)=f;
       i=i+1;
end
a=i;
for j=(Td-l6):-1:a
    for b=a:j
    w1(b)=resource(1,weather(k,b))*3;   %水消耗量（箱）
    f1(b)=resource(2,weather(k,b))*3;   %食物消耗量（箱）
    end
    i=j+1;
        while i<=j+T61&&j+T61<=Td
        if weather(k,i)==3
           T61=T61+1;
           T6=T61;
           w=resource(1,3);   %水消耗量（箱）
           f=resource(2,3);   %食物消耗量（箱）
        elseif weather(k,i)==2
           w=resource(1,2)*2;   %水消耗量（箱）
           f=resource(2,2)*2;   %食物消耗量（箱）
        else
           w=resource(1,1)*2;   %水消耗量（箱）
           f=resource(2,1)*2;   %食物消耗量（箱）
        end
           w1(i)=w;
           f1(i)=f;
           i=i+1;
        end
        T61=l6;
       if sum(w1(T2+1:i-1))*3+sum(f1(T2+1:i-1))*2<=1200
           w1(i:Td)=0;
           f1(i:Td)=0;
           break
       end
end


wz=sum(w1);
fz=sum(f1);
if fix((M-(sum(f1)-sum(f1(1:T2))))/3)>=sum(w1(T2+1:Td))
    bf0=fz;%初始买入食物与总共需要的食物相等
    bf1=0;
    bw0=fix((M-bf0*2)/3);
    bw1=wz-bw0;
else
    bf0=fix((M-sum(w1(T2+1:Td)))/2)+sum(f1(1:T2));
    bf1=fz-bf0;
    bw0=fix((M-bf0*2)/3);
    bw1=wz-bw0;
end
T1=l1;T2=l2;T3=l3;T4=l4;T5=l5;T6=l6;T61=l6;
C=bw0*pw+bf0*pf+bw1*pw*2+bf1*pf*2;%总成本
W=js*(j-a+1);%总收入
S=cz+W-C;%最佳收益
if size(S)==1
S1=S+S1;
bw01=bw0+bw01;
bw11=bw1+bw11;
bf01=bf0+bf01;
bf11=bf1+bf11;
t=j-a+1+t;
T=i-1+T;
v=v+1;
end
end
S1=S1/v;
bw01=bw01/v;bw11=bw11/v;
bf01=bf01/v;bf11=bf11/v;
t=t/v;T=T/v;



