clear;clc;
load('C1_Q1','N','minu','nc');dot=1440;
Time_left=N(2,:);Minute=minu;Num_Car=nc;h=Minute/60;
[pii,t_wait]=t2pi(minu,nc,Time_left);
paint=0;t_waith=t_wait/60;
%% t_w - t_planA
paint=0;
if paint==1
    figure
    plot(h,t_waith,'LineWidth',2);hold on;grid on
    legend('决策A的等待时间')
    xlabel('进入蓄车池时间/小时');ylabel('队列等待时间/小时');paint=0;
end
%% pi_A,pi_B - t
paint=0;
if paint==1
    figure;grid on
    plot(h,pii(1,:),'r','LineWidth',2);hold on
    plot(h,pii(2,:),'b','LineWidth',2);hold on
    legend('决策A的收益','决策B的收益')
    xlabel('进入蓄车池时间/小时');ylabel('收益/元');paint=0;
end
%%
[pii,t_wait]=t2pi(minu,nc,Time_left);
paint=1;
if paint==1
    figure;grid on
    plot(h,pii(1,:),'r','LineWidth',2);hold on
    plot(h,pii(2,:),'b','LineWidth',2);hold on
    legend('决策A的收益','决策B的收益')
    xlabel('进入蓄车池时间/小时');ylabel('收益/元');paint=0;
end
count=0;
for i=1:dot
    if pii(1,i)>pii(2,i)
        count=count+1;
    end
end
C(1)=count;
%% 2
[pii,t_wait]=t2pi(minu,nc,Time_left);
paint=1;
if paint==1
    figure;grid on
    plot(h,pii(1,:),'r','LineWidth',2);hold on
    plot(h,pii(2,:),'b','LineWidth',2);hold on
    legend('决策A的收益','决策B的收益')
    xlabel('进入蓄车池时间/小时');ylabel('收益/元');paint=0;
end
count=0;
for i=1:dot
    if pii(1,i)>pii(2,i)
        count=count+1;
    end
end
C(2)=count;
%% 3
[pii,t_wait]=t2pi(minu,nc,Time_left);
paint=1;
if paint==1
    figure;grid on
    plot(h,pii(1,:),'r','LineWidth',2);hold on
    plot(h,pii(2,:),'b','LineWidth',2);hold on
    legend('决策A的收益','决策B的收益')
    xlabel('进入蓄车池时间/小时');ylabel('收益/元');paint=0;
end
count=0;
for i=1:dot
    if pii(1,i)>pii(2,i)
        count=count+1;
    end
end
C(3)=count;
%% 4
[pii,t_wait]=t2pi(minu,nc,Time_left);
paint=1;
if paint==1
    figure;grid on
    plot(h,pii(1,:),'r','LineWidth',2);hold on
    plot(h,pii(2,:),'b','LineWidth',2);hold on
    legend('决策A的收益','决策B的收益')
    xlabel('进入蓄车池时间/小时');ylabel('收益/元');paint=0;
end
count=0;
for i=1:dot
    if pii(1,i)>pii(2,i)
        count=count+1;
    end
end
C(4)=count;
%% 5
[pii,t_wait]=t2pi(minu,nc,Time_left);
paint=1;
if paint==1
    figure;grid on
    plot(h,pii(1,:),'r','LineWidth',2);hold on
    plot(h,pii(2,:),'b','LineWidth',2);hold on
    legend('决策A的收益','决策B的收益')
    xlabel('进入蓄车池时间/小时');ylabel('收益/元');paint=0;
end
count=0;
for i=1:dot
    if pii(1,i)>pii(2,i)
        count=count+1;
    end
end
C(5)=count;
D(1,:)=C(1,:)/60;
%% 2.1
[pii,t_wait]=t2pi(minu,nc,Time_left);
paint=1;
if paint==1
    figure;grid on
    plot(h,pii(1,:),'r','LineWidth',2);hold on
    plot(h,pii(2,:),'b','LineWidth',2);hold on
    legend('决策A的收益','决策B的收益')
    xlabel('进入蓄车池时间/小时');ylabel('收益/元');paint=0;
end
count=0;
for i=1:dot
    if pii(1,i)>pii(2,i)
        count=count+1;
    end
end
C(2,1)=count;
%% 2.2
[pii,t_wait]=t2pi(minu,nc,Time_left);
paint=1;
if paint==1
    figure;grid on
    plot(h,pii(1,:),'r','LineWidth',2);hold on
    plot(h,pii(2,:),'b','LineWidth',2);hold on
    legend('决策A的收益','决策B的收益')
    xlabel('进入蓄车池时间/小时');ylabel('收益/元');paint=0;
end
count=0;
for i=1:dot
    if pii(1,i)>pii(2,i)
        count=count+1;
    end
end
C(2,2)=count;
%% 2.3
C(2,1)=count;
[pii,t_wait]=t2pi(minu,nc,Time_left);
paint=1;
if paint==1
    figure;grid on
    plot(h,pii(1,:),'r','LineWidth',2);hold on
    plot(h,pii(2,:),'b','LineWidth',2);hold on
    legend('决策A的收益','决策B的收益')
    xlabel('进入蓄车池时间/小时');ylabel('收益/元');paint=0;
end
count=0;
for i=1:dot
    if pii(1,i)>pii(2,i)
        count=count+1;
    end
end
C(2,3)=count;
%% 2.4
C(2,1)=count;
[pii,t_wait]=t2pi(minu,nc,Time_left);
paint=1;
if paint==1
    figure;grid on
    plot(h,pii(1,:),'r','LineWidth',2);hold on
    plot(h,pii(2,:),'b','LineWidth',2);hold on
    legend('决策A的收益','决策B的收益')
    xlabel('进入蓄车池时间/小时');ylabel('收益/元');paint=0;
end
count=0;
for i=1:dot
    if pii(1,i)>pii(2,i)
        count=count+1;
    end
end
C(2,4)=count;
%% 2.5
C(2,1)=count;
[pii,t_wait]=t2pi(minu,nc,Time_left);
paint=1;
if paint==1
    figure;grid on
    plot(h,pii(1,:),'r','LineWidth',2);hold on
    plot(h,pii(2,:),'b','LineWidth',2);hold on
    legend('决策A的收益','决策B的收益')
    xlabel('进入蓄车池时间/小时');ylabel('收益/元');paint=0;
end
count=0;
for i=1:dot
    if pii(1,i)>pii(2,i)
        count=count+1;
    end
end
C(2,5)=count;
D(2,:)=C(2,:)/60;
for i=1:5
    D(:,i+5)=(D(:,i)-D(:,3))./D(:,3);
end