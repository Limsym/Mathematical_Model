%关卡5的第一种情况：两人都从起点直接到终点
clc
clear
s1=10000;s2=200;P1=5;P2=10;deadline=10;
A=[1 2 1 1 1 1 2 2 2 2];Q=[3 4;9 9];n=2;s=0;
k=[1 2 3];%停留时取k=1，行走取k=2，挖矿取k=3
cost1=k(1,2)*(Q(A(1,1),1)+Q(A(1,2),1)+Q(A(1,3),1))+2*n*k(1,2)*Q(A(1,4),1);%玩家总耗水量
cost2=k(1,2)*(Q(A(1,1),2)+Q(A(1,2),2)+Q(A(1,3),2))+2*n*k(1,2)*Q(A(1,4),2);%玩家总耗食物量
cost0=cost1*P1+cost2*P2;%在起点处至少的资金花费
shengyuzijin=s1-cost0;



