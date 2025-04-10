function [pi,t_wait]=t2pi(Minute,Num_Car,Time_left)
[dot]=size(Minute,2);
vfa=9/2;
gamma=0.1;
%% tw=[NumCar/vfa];
for i=1:dot
    sumleft=0;
   for j=i:dot
       sumleft=sumleft+Time_left(j);
        if sumleft>=Num_Car(i)
            t_wait(i)=j-i+1;  % min
            break
        elseif j==dot && sumleft<Num_Car(i)
            for k=1:dot
                sumleft=sumleft+Time_left(k);
                if sumleft>=Time_left(i)
                    t_wait(i)=j-i+k+1;
                    break
                end
            end
        end
   end
end
%%
dist=29*(1+0.05*(-2));     % m
s(1)=dist;              % m
s(2)=dist;
t_work(1)=38;           % min
t_all=t_work(1)+t_wait;
workhours=12;
pipy=98238*(1+0.05*1);
pipm=pipy/12/30/workhours/60;
C0=2;
for i=1:dot
    [pi0(1,i),R(1,i),C(1,i)]=s2pi(s(1));
    Rm=t_wait(i)*pipm;
    pi(1,i)=pi0(1)-Rm;     % gamma=0.1;
    v=s(1)/t_work(1);
    t_kong=dist/v;
    t_work(2)=t_all(i)-t_kong;
    fucm=7.1;               % fuel_consumption
    proi=7.03;              % oil pricing
    Co=s(2)*fucm/100*proi;
    Ct=20;
    Cq=s2pi(s(1))*gamma;
    C(2)=Ct+Co+C0+Cq;
    R(2)=pipm*t_work(2);
    pi(2,i)=R(2)-C(2);
end
%%
paint=0;
if paint==1
    figure;grid on
    plot(Minute/60,t_wait/60,'LineWidth',2);hold on;grid on%
    legend('决策A的等待时间')
    xlabel('进入蓄车池时间/小时');ylabel('队列等待时间/小时');paint=0;
end
% paint=0;
% if paint==1
%     figure;grid on
%     scatter(h,t_wait/60,'fill');hold on
%     legend('决策A的等待时间') % ,'新增出租车需求量'
%     xlabel('进入蓄车池时间/小时');ylabel('队列等待时间/小时');paint=0;
% end
end