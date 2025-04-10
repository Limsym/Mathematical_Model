%% 1
clear;clc;tic;load('r2_1');r=0.0835753;K=1381.78096;
data3_1=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',1);
D=0.5;
dt=0.00001;
[n1,~]=size(data3_1);
tr1=data3_1(:,1)';
Vr1=data3_1(:,2)';
V(1)=Vr1(1);
days=max(data3_1(:,1));
dot=days/dt+1;
time=0.004;
minpc=inf;
index=1;in=1;
for t=0:dt:days
    if mod(t,1)<=time
        dV(index)=(r*V(index)*(1-V(index)/K)-(A*D+B*D^2)*V(index))*dt;
    else
        dV(index)=r*V(index)*(1-V(index)/K)*dt;
    end
    if abs(t-tr1(in))<=10^(-5)
        VB(in)=V(index);in=in+1;
    end
    V(index+1)=V(index)+dV(index);
    index=index+1;
end
% for i=0:
% pc=V
% end
V(index)=[];
n=size(Vr1,2);
Q=sum((VB(2:n)-Vr1(2:n)).^2);
X=sum(Vr1(2:n).^2);
R=1-(Q/X)^(1/2);
tn=(0:dt:days);
figure;plot(tr1,Vr1);hold on;plot(tn,V);
xlabel('时间（day）');ylabel('肿瘤体积（mm^3）');legend('0.5 Gy 原始曲线','0.5 Gy 拟合曲线')
axis([0 26 700 1400])
%% 2
clear;clc;tic;r=0.0813253;K=1381.78096;load('r2_1')
data3_2=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',2);
dt=0.00001;
D=1;
[n1,~]=size(data3_2);
tr1=data3_2(:,1)';
tr2=tr1;
Vr1=data3_2(:,2)';
V(1)=Vr1(1);
Vr2=Vr1;
days=max(data3_2(:,1));
time=0.004;
dot=days/dt+1;
index=1;in=1;
n=size(Vr2,2);
for t=0:dt:days
    if mod(t,1)<=time
        dV(index)=(r*V(index)*(1-V(index)/K)-(A*D+B*D^2)*V(index))*dt;
    else
        dV(index)=r*V(index)*(1-V(index)/K)*dt;
    end
    if abs(t-tr2(in))<=10^(-5) && in<=n
        VB(in)=V(index);
        if in<n
            in=in+1;
        end
    end
    V(index+1)=V(index)+dV(index);
    index=index+1;
end
V(index)=[];
Q=sum((VB(2:n)-Vr2(2:n)).^2);
X=sum(Vr2(2:n).^2);
R=1-(Q/X)^(1/2);
tn=(0:dt:days);
hold on;plot(tr1,Vr1);hold on;plot(tn,V,'.');
xlabel('时间（day）');ylabel('肿瘤体积（mm^3）');legend('0.5 Gy 原始曲线','0.5 Gy 拟合曲线','1 Gy 原始曲线','1 Gy 拟合曲线');toc
%% 3
clear;clc;tic;load('r2_1');r=0.0813253;K=1381.78096;
data3_4=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',3);
D=2;
dt=0.00001;
[n1,~]=size(data3_4);
tr1=data3_4(:,1)';
Vr1=data3_4(:,2)';
V(1)=Vr1(1);
days=max(data3_4(:,1));
time=0.004;
dot=days/dt+1;
index=1;
for t=0:dt:days
    if mod(t,1)<=time
        dV(index)=(r*V(index)*(1-V(index)/K)-(A*D+B*D^2)*V(index))*dt;
    else
        dV(index)=r*V(index)*(1-V(index)/K)*dt;
    end
    V(index+1)=V(index)+dV(index);
    index=index+1;
end
V(index)=[];
tn=(0:dt:days);
figure;plot(tr1,Vr1);hold on;plot(tn,V);
xlabel('时间（day）');ylabel('肿瘤体积（mm^3）');legend('2 Gy 原始曲线','2 Gy 拟合曲线');toc
%% 4
clear;clc;tic;load('r2_1');r=0.0813253;K=1381.78096;
data3_3=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',4);
dt=0.00001;
D=3;
[n1,~]=size(data3_3);
tr1=data3_3(:,1)';
Vr1=data3_3(:,2)';
V(1)=Vr1(1);
days=max(data3_3(:,1));
time=0.004;
dot=days/dt+1;
index=1;
for t=0:dt:days
    if mod(t,1)<=time
        dV(index)=(r*V(index)*(1-V(index)/K)-(A*D+B*D^2)*V(index))*dt;
    else
        dV(index)=r*V(index)*(1-V(index)/K)*dt;
    end
    V(index+1)=V(index)+dV(index);
    index=index+1;
end
V(index)=[];
tn=(0:dt:days);
hold on;plot(tr1,Vr1);hold on;plot(tn,V);
xlabel('时间（day）');ylabel('肿瘤体积（mm^3）');legend('2 Gy 原始曲线','2 Gy 拟合曲线','3 Gy 原始曲线','3 Gy 拟合曲线');tic
%% 5----2.5 Gy
clear;clc;load('r2_1')
V(1)=1400;
D=2.5;
days=15;
time=0.004;
dt=0.001;
dot=days/dt+1;
index=1;
r=0.0835753;K=1381.78096;
in=1;
for t=0:dt:days
    if mod(t,1)<time-10^(-7)
        dV(index)=-(A*D+B*D^2)*V(index)*dt;
    else dV(index)=r*V(index)*(1-V(index)/K)*dt;
    end
    V(index+1)=V(index)+dV(index);
    if mod(t,1)==0 || mod(t+dt/10^3-time,1)<=10^(-5)
        record(in,:)=[t V(index)];
        in=in+1;
    end
    index=index+1;
end
V(index)=[];
tn=(0:dt:days);
figure;plot(tn,V);legend('2.5Gy 放疗前后肿瘤数据变化')
%
% for i=1:15
%
% end
% toc
%% 5.1
clear;clc;load('r2_1')
V(1)=1400;
D=2.2560;
days=35;
time=0.004;
dt=0.0001;
dot=days/dt+1;
index=1;
r=0.0835753;K=1381.78096;
for t=0:dt:days
    if mod(t,1)<=time
        dV(index)=(r*V(index)*(1-V(index)/K)-(A*D+B*D^2)*V(index))*dt;
    else dV(index)=r*V(index)*(1-V(index)/K)*dt;
    end
    V(index+1)=V(index)+dV(index);
    index=index+1;
end
V(index)=[];
tn=(0:dt:days);
figure;plot(tn,V);hold on
plot([0 35],[0.4 0.4],'r');legend('2.2560Gy 放疗前后肿瘤数据变化','V=0.4');
xlabel('时间（day）');ylabel('肿瘤体积（mm^3）');
axis([33.75 34.25,0.3 0.5]);
min(V)
%%
axis([28.5 29.5,0.2 0.6]);
%% 5.2
clear;clc;load('r2_1')
V(1)=1400;
days=35;
time=0.004;
dt=0.001;
dot=days/dt+1;
r=0.0835753;K=1381.78096;
xuhao=1;
for D=0:0.0001:2.5;
    index=1;
    for t=0:dt:days
        if mod(t,1)<=time
            dV(index)=-(A*D+B*D^2)*V(index)*dt;
        else dV(index)=r*V(index)*(1-V(index)/K)*dt;
        end
        V(index+1)=V(index)+dV(index);
        index=index+1;
    end
    V(index)=[];
    Vmin(xuhao)=V(35001);
    xuhao=xuhao+1;
end
tn=(0:dt:days);
figure;
x=[2.0 2.5];
figure;plot(0:0.0001:2.5,Vmin,'r');hold on;plot([0 2.5],[65 65],'r');
xlabel('放射强度 D（Py）');ylabel('放疗期末肿瘤体积 minV（mm^3）');
legend('','V=65')
%% 5.2
