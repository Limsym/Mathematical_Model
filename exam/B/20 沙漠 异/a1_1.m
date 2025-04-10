%起点直接到终点收益
clc
clear
l1=12;%起点到终点距离
weather=[2;2;1;3;1;2;3;1;2;2;3;2;1;2;2;2;3;3;2;2;1;1;2;1;3;2;1;1;2;2];%天气情况，1为晴朗，2为高温，3为沙暴
resource=[5 8 10;7 6 10];%不同天气不同资源所需量
cz=10000;%初始资金
M=1200;%负重
mw=0;mf=0;
pw=5;
pf=10;
i=1;
while i<=l1
    if weather(i,1)==3
       l1=l1+1;
       w=resource(1,3);   %水消耗量（箱）
       f=resource(2,3);   %食物消耗量（箱）
    elseif weather(i,1)==2
       w=resource(1,2)*2;   %水消耗量（箱）
       f=resource(2,2)*2;   %食物消耗量（箱）
    else
       w=resource(1,1)*2;   %水消耗量（箱）
       f=resource(2,1)*2;   %食物消耗量（箱）
    end
       w1(i)=w;%水总质量
       f1(i)=f;%食物总质量
       i=i+1;
end  
c=sum(w1)*pw+sum(f1)*pf;%总成本
S=cz-c;






