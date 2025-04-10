%% 单次剂量 20
clear;clc;load('data')
data2_2=xlsread('附件2：单次放疗不同剂量肿瘤数据',1,'a3:b131');
[n,~]=size(data2_2);
tr=data2_2(:,1)';
tmax=max(tr);
Vr=data2_2(:,2)';
V0=Vr(1);
minpc=inf;
for a=-2100:1/100:-2050
    for b=7.4:1/10000:7.5
        V=exp(a*tr+b);
        for i=1/10000:1/10000:tmax
            dot=10^4*i;
            dV1=r*V(dot)*(1-V(dot)/K)-
        end
        if sum((V-Vr).^2)<minpc
            minpc=sum((V-Vr).^2);A=a;B=b;
        end
    end
end
V=exp(A*tr+B);
Q=sum((V-Vr).^2);
X=sum(Vr.^2);
R=1-(Q/X)^(1/2);
figure;plot(tr,Vr,'linewidth',6.5),hold on,plot([tr],[V0 V(1:n-1)],'r','linewidth',2.5);
xlabel('时间（day）');ylabel('肿瘤体积（mm^3）');legend('原始曲线','拟合曲线')
%% 单次剂量 30
clear;clc;load('data')
data2_2=xlsread('附件2：单次放疗不同剂量肿瘤数据',2,'a3:b118');
[n,~]=size(data2_2);
tr=data2_2(:,1)';
Vr=data2_2(:,2)';
V0=Vr(1);
minpc=inf;
for a=-4400:1/100:-3950
    for b=7.3:1/1000:7.9
        y=a*tr+b;
        V=exp(y);
        if sum((V-Vr).^2)<minpc
            minpc=sum((V-Vr).^2);A=a;B=b;
        end
    end
end
V=exp(A*tr+B);
Q=sum((V-Vr).^2);
X=sum(Vr.^2);
R=1-(Q/X)^(1/2);
figure;plot(tr,Vr,'linewidth',6.5),hold on,plot([tr],[V0 V(1:n-1)],'r','linewidth',2.5);
xlabel('时间（day）');ylabel('肿瘤体积（mm^3）');legend('原始曲线','拟合曲线')