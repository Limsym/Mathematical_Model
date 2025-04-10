%起点-村庄-矿山-村庄-矿山-终点 收益
clc
clear
%关卡二村庄2矿山2
l1=12;%起点到终点距离
l2=9;%起点到村庄距离
l3=9;%起点到矿山距离
l4=1;%村庄到矿山距离
l5=2;%村庄到终点距离
l6=2;%矿山到终点距离

T1=l1;T2=l2;T3=l3;T4=l4;T5=l5;T6=l6;T61=l6;T41=l4;T42=l4;T43=l4;
weather=[2;2;1;3;1;2;3;1;2;2;3;2;1;2;2;2;3;3;2;2;1;1;2;1;3;2;1;1;2;2];%天气情况，1为晴朗，2为高温，3为沙暴
resource=[5 8 10;7 6 10];%不同天气不同资源所需量
cz=10000;%初始资金
js=1000;%基础收益
M=1200;%负重
mw=0;mf=0;
pw=5;
pf=10;
Td=30;%截止时间
i=1;
while i<=T2
    if weather(i,1)==3
       T2=T2+1;
       w=resource(1,3);   %水消耗量（箱）
       f=resource(2,3);   %食物消耗量（箱）
    elseif weather(i,1)==2
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
    if weather(i,1)==3
       T41=T41+1;
       w=resource(1,3);   %水消耗量（箱）
       f=resource(2,3);   %食物消耗量（箱）
    elseif weather(i,1)==2
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
    w1(b)=resource(1,weather(b,1))*3;   %水消耗量（箱）
    f1(b)=resource(2,weather(b,1))*3;   %食物消耗量（箱）
    end
    i=j+1;
        while i<=j+T4
        if weather(i,1)==3
           T4=T4+1;
           T42=T4;
           w=resource(1,3);   %水消耗量（箱）
           f=resource(2,3);   %食物消耗量（箱）
        elseif weather(i,1)==2
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
    if weather(i,1)==3
       T43=T43+1;
       w=resource(1,3);   %水消耗量（箱）
       f=resource(2,3);   %食物消耗量（箱）
    elseif weather(i,1)==2
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
    w1(b)=resource(1,weather(b,1))*3;   %水消耗量（箱）
    f1(b)=resource(2,weather(b,1))*3;   %食物消耗量（箱）
    end
    i=k+1;
        while i<=k+T61
        if weather(i,1)==3
           T61=T61+1;
           T6=T61;
           w=resource(1,3);   %水消耗量（箱）
           f=resource(2,3);   %食物消耗量（箱）
        elseif weather(i,1)==2
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
    bw1=wz-bw0-bw2;
    bw2=sum(w1(j+T42+1:Td));
else
    bf0=fix((M-sum(w1(T2+1:j+T42))*3)/2)+sum(f1(1:T2));
    bf1=0;
    bf2=fz-bf0;
    bw0=fix((M-bf0*2)/3);
    bw1=sum(w1(T2+1:j+T42))-(bw0-sum(w1(1:T2)));
    bw2=wz-bw0-bw1;
end


C=bw0*pw+bf0*pf+bw1*pw*2+bf1*pf*2+bw2*pw*2+bf2*pf*2;%总成本
W=js*(j-a1+1)+js*(k-a2+1);%总收入
S=cz+W-C;%最佳收益
   
    