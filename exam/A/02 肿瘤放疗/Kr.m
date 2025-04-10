%% 1
clear;clc
load('r2_1');
D=[0.5 1 2 3];
data3_1=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',1);
data3_2=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',2);
data3_3=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',3);
data3_4=xlsread('附件3：分次放疗不同分割剂量肿瘤数据',4);
[n(1),~]=size(data3_1);
[n(2),~]=size(data3_2);
[n(3),~]=size(data3_3);
[n(4),~]=size(data3_4);
day(1)=max(data3_1(:,1));
day(2)=max(data3_2(:,1));
day(3)=max(data3_3(:,1));
day(4)=max(data3_4(:,1));
tr1=data3_1(:,1)';
tr2=data3_2(:,1)';
tr3=data3_3(:,1)';
tr4=data3_4(:,1)';
Vr1=data3_1(:,2)';
Vr2=data3_2(:,2)';
Vr3=data3_3(:,2)';
Vr4=data3_4(:,2)';
%% 2
dt=0.001;
minPC=inf;
time=0.004;
for r=0:0.001:0.010
    for K=1350:10:1500
        clear pc
        for group=1:4
            Vp=ones(1)*1400;
            for dot=2:2:(day(group))*2+1
                if group==1 Vp(dot)=Vr1(dot);Ve=Vp(dot);
                elseif group==2 Vp(dot)=Vr2(dot);Ve=Vp(dot);
                elseif group==3 Vp(dot)=Vr3(dot);Ve=Vp(dot);
                elseif group==4 Vp(dot)=Vr4(dot);Ve=Vp(dot);
                end
                for te=1:(1-time)/dt
                    dVe=r*Ve*(1-Ve/K)*dt;
                    Ve=Ve+dVe;
                end
                if dot+1<=day(group)*2+1
                    Vp(dot+1)=Ve;
                end
            end
            [~,ng]=size(Vp);
            if group==1 pc(group)=sum(Vp(2:ng)-Vr1(2:ng)).^2;
            elseif group==2 pc(group)=sum(Vp(2:ng)-Vr2(2:ng)).^2;
            elseif group==3 pc(group)=sum(Vp(2:ng)-Vr3(2:ng)).^2;
            elseif group==4 pc(group)=sum(Vp(2:ng)-Vr4(2:ng)).^2;end
        end
        PC=sum(pc);if PC<minPC minPC=PC;Best_K=K;Best_r=r;end
    end
end
%% 3
for group=1:4
    clear pc
    for dot=2:2:day(group)*2+1
        Vp=ones(1)*1400;
        if group==1 Vp(dot)=Vr1(dot);Ve=Vp(dot);
        elseif group==2 Vp(dot)=Vr2(dot);Ve=Vp(dot);
        elseif group==3 Vp(dot)=Vr3(dot);Ve=Vp(dot);
        elseif group==4 Vp(dot)=Vr4(dot);Ve=Vp(dot);
        end
        for te=1:(1-time)/dt
            dVe=Best_r*Ve*(1-Ve/Best_K)*dt;
            Ve=Ve+dVe;
        end
        if dot+1<=day(group)*2+1
            Vp(dot+1)=Ve;
        end
    end
     plot(1:day(group)*2+1,Vp)
end
xlabel('时间（day）');ylabel('肿瘤体积（mm^3）');% legend('3 Gy 原始曲线','3 Gy 拟合曲线')