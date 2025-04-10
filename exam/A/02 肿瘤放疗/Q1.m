clear;clc;
data1=xlsread('附件1：某X肿瘤生长数据','a3:b102');
[n,~]=size(data1);
tr=data1(:,1)';
t=1:tr(n);
Vr=data1(:,2)';
V0=Vr(1);
minpc=inf;
for Kt=2398.4:0.1:2500
    for rt=0.14:0.001:0.16
        V=Kt./(1+(Kt-1)*exp(-rt*t));
        if sum((V(2:n)-Vr(2:n)).^2)<minpc
            minpc=sum((V(2:n)-Vr(2:n)).^2);K=Kt;r=rt;VB=V;
        end
    end
end
save('r1','K','r')
% V=K./(1+(K-1)*exp(-r*t));
Q=sum((VB(2:n)-Vr(2:n)).^2);
X=sum(Vr(2:n).^2);
R=1-(Q/X)^(1/2);
figure;plot(tr,Vr,'linewidth',6.5),hold on,plot([0 t],[V0 VB(1:100)],'r','linewidth',2.5);
xlabel('时间（day）');ylabel('肿瘤体积（mm^3）');legend('原始曲线','拟合曲线')
