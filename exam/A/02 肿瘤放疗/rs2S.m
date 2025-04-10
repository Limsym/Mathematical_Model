% function [R]=rs2S(x);
%% 1
r=x(1);K=x(2);
load('r2_1');
data3_1=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',1);
data3_2=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',2);
data3_3=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',3);
data3_4=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',4);
D=[0.5 1 2 3];
[n1,~]=size(data3_1);
tr1=data3_1(:,1)';
Vr1=data3_1(:,2)';
day=max(data3_1(:,1));
time=0.004;
minpc=inf;
for dot=1:day*2
    for
        V(dot)=Vr1(dot*2-1);
        dV=r*V(index)*(1-V(index)/K% for i=0:
        V=;
    end
end
pc(1)=V
%% 2
clear;clc;tic;load('r2_1');load('r1');
data3_2=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',2);
dt=0.001;
D=1;
[n1,~]=size(data3_2);
tr1=data3_2(:,1)';
Vr1=data3_2(:,2)';
V(1)=Vr1(1);
day=max(data3_2(:,1));
time=0.004;
dot=day/dt+1;
index=1;
r=0.1;
for t=0:dt:day
    if mod(t,1)<=time
        dV(index)=(r*V(index)*(1-V(index)/K)-(A*D+B*D^2)*V(index))*dt;
    else
        dV(index)=r*V(index)*(1-V(index)/K)*dt;
    end
    V(index+1)=V(index)+dV(index);
    index=index+1;
end
V(index)=[];
tn=(0:dt:day);
figure;plot(tr1,Vr1);hold on;plot(tn,V);
xlabel('时间（day）');ylabel('肿瘤体积（mm^3）');legend('1 Gy 原始曲线','1 Gy 拟合曲线')
%% 3
clear;clc;tic;load('r2_1');load('r1');
data3_4=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',3);
D=2;
dt=0.001;
[n1,~]=size(data3_4);
tr1=data3_4(:,1)';
Vr1=data3_4(:,2)';
V(1)=Vr1(1);
day=max(data3_4(:,1));
time=0.004;
dot=day/dt+1;
index=1;
r=0.1;
for t=0:dt:day
    if mod(t,1)<=time
        dV(index)=(r*V(index)*(1-V(index)/K)-(A*D+B*D^2)*V(index))*dt;
    else
        dV(index)=r*V(index)*(1-V(index)/K)*dt;
    end
    V(index+1)=V(index)+dV(index);
    index=index+1;
end
V(index)=[];
tn=(0:dt:day);
figure;plot(tr1,Vr1);hold on;plot(tn,V);
xlabel('时间（day）');ylabel('肿瘤体积（mm^3）');legend('2 Gy 原始曲线','2 Gy 拟合曲线');toc
%% 4
clear;clc;tic;load('r1');load('r2_1');
data3_3=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',4);
dt=0.004;
D=3;
[n1,~]=size(data3_3);
tr1=data3_3(:,1)';
Vr1=data3_3(:,2)';
V(1)=Vr1(1);
day=max(data3_3(:,1));
time=0.004;
dt=0.0001;
dot=day/dt+1;
index=1;
r=0.1;
for t=0:dt:day
    if mod(t,1)<=time
        dV(index)=(r*V(index)*(1-V(index)/K)-(A*D+B*D^2)*V(index))*dt;
    else
        dV(index)=r*V(index)*(1-V(index)/K)*dt;
    end
    V(index+1)=V(index)+dV(index);
    index=index+1;
end
V(index)=[];
tn=(0:dt:day);
figure;plot(tr1,Vr1);hold on;plot(tn,V);
xlabel('时间（day）');ylabel('肿瘤体积（mm^3）');legend('3 Gy 原始曲线','3 Gy 拟合曲线');tic