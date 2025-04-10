function [res1 Vres]=d2V3(Gy)
% Gy=x_best;
week=3;
load('r2_1');r=0.0835753;K=1381.78096;
V(1)=4/3*pi*(2*10/2)^3;
good=4/3*pi*(5/2)^3;
delta=mean([0.36 0.2 0.5]);
dt=0.001;
time=0.004;
days=week*7;
%%
index=1;in=1;inv=1;
for w=1:week
    for t=(w-1)*7:dt:w*7-dt                                                 % 第 w 周内的时间 
        if mod(t,1)<time-10^(-7) && ...                                           	% 处于x:x+time
                ( fix(mod(t+1,7))==1 || fix(mod(t+1,7))==3 || fix(mod(t+1,7))==5 )
            t1(index)=1;
        else t1(index)=0;
        end
        if t1(index)==1
            dV(index)=(-(A*Gy(w)+B*Gy(w)^2)*V(index))*dt;                  	% r*V(index)*(1-V(index)/K)
        else dV(index)=r*V(index)*(1-V(index)/K)*dt;
        end
        V(index+1)=V(index)+dV(index);
        if ( mod(t,1)==0 || mod(t+dt/10^3-time,1)<=10^(-5) ) && ( fix(mod(t+1,7))==1 || ...
                fix(mod(t+1,7))==3 || fix(mod(t+1,7))==5 )
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
        if t==7*(week-1)+4+time
            Vmin=V(index);  
        end
        index=index+1;
    end
end
if Vmin<=good
    M=5*sum(Gy);
else M=inf;
end
res1=[Gy;V_every;zeros(1,week)];re1(3,week)=M;
end