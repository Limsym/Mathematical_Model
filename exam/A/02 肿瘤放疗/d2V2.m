function M=d2V2(Gy)
% Gy=[0.1 2.5 2.5 2.5];
week=3;
if max(abs(Gy(1:2)-Gy(2:3))./Gy(1:2)) > 0.1
    M=6.5*5*week;
    return
end
load('r2_1');r=0.0835753;K=1381.78096;
V(1)=4/3*pi*(2*10/2)^3;
good=4/3*pi*(5/2)^3;
delta=mean([0.36 0.2 0.5]);
dt=0.001;
time=0.004;
days=week*7;
%%
index=1;
for w=1:week
    for t=(w-1)*7:dt:w*7-dt                                                 % 第 w 周内的时间 
        if mod(t,1)<time-10^(-7) && ...                                           	% 处于x:x+time
                ( fix(mod(t+1,7))==1 || fix(mod(t+1,7))==3|| fix(mod(t+1,7))==5 )
            t1(index)=1;
        else t1(index)=0;
        end
        if t1(index)==1
            dV(index)=(-(A*Gy(w)+B*Gy(w)^2)*V(index))*dt;                  	% r*V(index)*(1-V(index)/K)
        else dV(index)=r*V(index)*(1-V(index)/K)*dt;
        end
        V(index+1)=V(index)+dV(index);
        if t==7*(week-1)+4+time
            Vmin=V(index);  
        end
        index=index+1;
    end     % ;index=index-1;V(index)=[];
end
if Vmin<=good
    M=5*sum(Gy);
else M=inf;
end
end