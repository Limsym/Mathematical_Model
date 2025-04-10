function [res1 Vres]=d2V1(Gy)
% Gy=x_best;
week=5;
D=50;
Gy(week)=D/week-sum(Gy(1:4));
% xdc=max([max(Gy)-mean(Gy)/mean(Gy) -(min(Gy)-mean(Gy))/mean(Gy)]);
load('r2_1');r=0.0835753;K=1381.78096;
V(1)=4/3*pi*(2*5/2)^3;
good=4/3*pi*(5/2)^3;
delta=mean([0.36 0.2 0.5]);
dt=1/1000;
time=4/1000;
days=week*7;
% op=[1 0];
%%
index=1;in=1;inv=1;
for w=1:5
    for t=(w-1)*7:dt:w*7-dt                                                 % 第 w 周内的时间 
        if mod(t,1)<time-10^(-7) && ...                                           	% 处于[x,x+time)
                ( fix(mod(t+1,7))==1 || fix(mod(t+1,7))==2 || ... 
                fix(mod(t+1,7))==3 || fix(mod(t+1,7))==4 || fix(mod(t+1,7))==5 )
            t1(index)=1;
        else t1(index)=0;
        end
        if t1(index)==1
            dV(index)=(-(A*Gy(w)+B*Gy(w)^2)*V(index))*dt;                  	% r*V(index)*(1-V(index)/K)
        else dV(index)=r*V(index)*(1-V(index)/K)*dt;
        end
        V(index+1)=V(index)+dV(index);
        if ( mod(t,1)==0 || mod(t+dt/10^3-time,1)<=10^(-5) ) && ( fix(mod(t+1,7))==1 || ...
                fix(mod(t+1,7))==2 || fix(mod(t+1,7))==3 || fix(mod(t+1,7))==4 || fix(mod(t+1,7))==5 )
            Vres(in,1)=w;
            Vres(in,2)=fix(mod(t+1,7));
            Vres(in,3)=t;
            Vres(in,4)=V(index);
            in=in+1;
        end
        if abs(t-(7*(w-1)+4+time))<10^(-5)
            Vmin=V(index);
            V_every(inv)=V(index);
            inv=inv+1;
        end
        index=index+1;
    end     % ;index=index-1;V(index)=[];
end
res1=[Gy;V_every;[Vmin 0 0 0 0]];
% figure;
hold on;plot(0:dt:days,V,'LineWidth',4);
set(gca,'XTick',0:7:days);
xlabel('时间 t (d)');ylabel('肿瘤体积 V（mm^3）');
% legend('D=[]');title('总剂量50Gy、疗程5周下的最佳放疗方案')