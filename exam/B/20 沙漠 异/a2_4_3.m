%起点-村庄-矿山-村庄-矿山-终点 收益
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
T1=l1;T2=l2;T3=l3;T4=l4;T5=l5;T6=l6;T61=l6;T41=l4;T42=l4;T43=l4;
resource=[3 9 10;4 9 10];%不同天气不同资源所需量
cz=10000;%初始资金
js=1000;%基础收益
M=1200;%负重
pw=5;
pf=10;
Td=30;%截止时间
S1=0;bw01=0;bw11=0;bw21=0;bf01=0;bf11=0;bf21=0;t=0;T=0;
v=0;
for ii=1:100
i=1;
while i<=T2
    if weather(ii,i)==3
       T2=T2+1;
       w=resource(1,3);   %水消耗量（箱）
       f=resource(2,3);   %食物消耗量（箱）
    elseif weather(ii,i)==2
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
while i<=T2+T41
    if weather(ii,i)==3
       T41=T41+1;
       w=resource(1,3);   %水消耗量（箱）
       f=resource(2,3);   %食物消耗量（箱）
    elseif weather(ii,i)==2
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
a1=i;
for j=(Td-l4-l5-l4):-1:a1
    for b=a1:j
    w1(b)=resource(1,weather(ii,b))*3;   %水消耗量（箱）
    f1(b)=resource(2,weather(ii,b))*3;   %食物消耗量（箱）
    end
    i=j+1;
        while i<=j+T4
        if weather(ii,i)==3
           T4=T4+1;
           T42=T4;
           w=resource(1,3);   %水消耗量（箱）
           f=resource(2,3);   %食物消耗量（箱）
        elseif weather(ii,i)==2
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
        T4=l4;
       if sum(w1(T2+1:i-1))*3+sum(f1(T2+1:i-1))*2<=1200
           w1(i:Td)=0;
           f1(i:Td)=0;
           break
       end
end
while i<=j+T42+T43
    if weather(ii,i)==3
       T43=T43+1;
       w=resource(1,3);   %水消耗量（箱）
       f=resource(2,3);   %食物消耗量（箱）
    elseif weather(ii,i)==2
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

a2=i;
for k=(Td-l6):-1:a2
    for b=a2:k
    w1(b)=resource(1,weather(ii,b))*3;   %水消耗量（箱）
    f1(b)=resource(2,weather(ii,b))*3;   %食物消耗量（箱）
    end
    i=k+1;
        while i<=k+T61&&k+T61<=Td
        if weather(ii,i)==3
           T61=T61+1;
           T6=T61;
           w=resource(1,3);   %水消耗量（箱）
           f=resource(2,3);   %食物消耗量（箱）
        elseif weather(ii,i)==2
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
       if sum(w1(j+T42+1:i-1))*3+sum(f1(j+T42+1:i-1))*2<=1200
           w1(i:Td)=0;
           f1(i:Td)=0;
           break
       end
end

wz=sum(w1);
fz=sum(f1);
if fix((M-fz*2)/3)>=sum(w1(T2+1:j+T42))
    bf0=fz;
    bf1=0;
    bf2=0;
    bw0=fix((M-bf0*2)/3);
    bw2=sum(w1(j+T42+1:Td));
    bw1=wz-bw0-bw2;
else
    bf0=fix((M-sum(w1(T2+1:j+T42))*3)/2)+sum(f1(1:T2));
    bf1=0;
    bf2=fz-bf0;
    bw0=fix((M-bf0*2)/3);
    bw1=sum(w1(T2+1:j+T42))-(bw0-sum(w1(1:T2)));
    bw2=wz-bw0-bw1;
end


C=bw0*pw+bf0*pf+bw1*pw*2+bf1*pf*2+bw2*pw*2+bf2*pf*2;%总成本
% W=js*(j-a1+1)+js*(k-a2+1);%总收入
 W=js*(j-a1+1-5)+js*(k-a2+1-4)+0.5*9*js;%总收入
S=cz+W-C;%最佳收益
T1=l1;T2=l2;T3=l3;T4=l4;T5=l5;T6=l6;T61=l6; T41=l4;T42=l4;T43=l4; 
if size(S)==1
S1=S+S1;
bw01=bw0+bw01;
bw11=bw1+bw11;
bw21=bw2+bw21;
bf01=bf0+bf01;
bf11=bf1+bf11;
bf21=bf2+bf21;
t=j-a1+1+k-a2+1+t;
T=i-1+T;
v=v+1;
end
end
S1=S1/v;
bw01=bw01/v;bw11=bw11/v;bw21=bw21/v;
bf01=bf01/v;bf11=bf11/v;bf21=bf21/v;
t=t/v;T=T/v;



