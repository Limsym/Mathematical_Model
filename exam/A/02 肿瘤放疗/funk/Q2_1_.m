clear;clc;load('r1');tic
D=[20 30];
data2_1=xlsread('附件2：单次放疗不同剂量肿瘤数据',1,'a3:b131');
data2_2=xlsread('附件2：单次放疗不同剂量肿瘤数据',2,'a3:b118');%118
[n1,~]=size(data2_1);
[n2,~]=size(data2_2);
Vr1=data2_1(:,2)';
V1(1)=Vr1(1);
Vr2=data2_2(:,2)';
V2(1)=Vr2(1);
tr1=data2_1(:,1)';
for i=1:n1-1
    dt1(i)=tr1(i+1)-tr1(i);
end
tr2=data2_2(:,1)';
for i=1:n2-1
    dt2(i)=tr2(i+1)-tr2(i);
end
minpc=inf;
for alpha=20:0.01:24
    for beta=3:0.01:4
          for r=0:0.0001:0.0003
            for i=1:n1-1
                dV1(i)=(r*V1(i)*(1-V1(i)/K)-(alpha*D(1)+beta*D(1)^2))*V1(i)*dt1(i);
                V1(i+1)=V1(i)+dV1(i);
            end
            for i=1:n2-1
                dV2(i)=(r*V2(i)*(1-V2(i)/K)-(alpha*D(2)+beta*D(2)^2))*V2(i)*dt2(i);
                V2(i+1)=V2(i)+dV2(i);
            end
            pc=[sum((V1-Vr1).^2) sum((V2-Vr2).^2)];
%             pc=[abs((V1-Vr1)) abs((V2-Vr2))];
            if sum(pc)<minpc
                minpc=sum(pc);A=alpha;B=beta;Rr=r;C=Rr;
             end
        end
    end
end
sure=0;if sure==1 save('r2','A','B');end
sure=1;if sure==1 save('r2_1','A','B','C');end
for i=1:n1-1
    dV1(i)=(Rr*V1(i)*(1-V1(i)/K)-(A*D(1)+B*D(1)^2))*V1(i)*dt1(i);
    V1(i+1)=V1(i)+dV1(i);
end
for i=1:n2-1
    dV2(i)=(Rr*V2(i)*(1-V2(i)/K)-(A*D(2)+B*D(2)^2))*V2(i)*dt2(i);
    V2(i+1)=V2(i)+dV2(i);
end
Q=[sum((V1-Vr1).^2) sum((V2-Vr2).^2)];
X=[sum(Vr1.^2) sum(Vr2.^2)];
R=1-sqrt(Q./X);
figure;plot(tr1,Vr1,'linewidth',6.5),hold on,plot([tr1],[V1(1:n1)],'r','linewidth',2.5);
plot(tr2,Vr2,'linewidth',6.5),hold on,plot([tr2],[V2(1:n2)],'r','linewidth',2.5);
xlabel('时间（day）');ylabel('肿瘤体积（mm^3）');legend('20Gy原始曲线','20Gy拟合曲线','30Gy原始曲线','30Gy拟合曲线');
lambda=A/B;
toc