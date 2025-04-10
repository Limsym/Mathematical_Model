week=5;
D=50;
load('r2_1');r=0.0835753;K=1381.78096;
V(1)=4/3*pi*(2*5/2)^3;
good=4/3*pi*(5/2)^3;
delta=mean([0.36 0.2 0.5]);
dt=1/1000;
time=0.004;
days=week*7;
% op=[1 0];

%%
tic
Best_E=inf;
Best_V=inf;
for g1=0.5:1:2.5
    for g2=0.5:1:2.5
        for g3=0.5:1:2.5
            for g4=0.5:1:2.5
                g5=10-g1-g2-g3-g4;
                Gy=[g1 g2 g3 g4 g5];
                index=1;in=1;
                if min(Gy)>0 && max(Gy)<=2.5
                    for w=1:5
                        for t=(w-1)*7:dt:w*7-dt                             % 第 w 周内的时间
                            if mod(t,1)<time && ...                         % 处于x:x+time
                                    ( fix(mod(t+1,7))==1 || fix(mod(t+1,7))==2 || fix(mod(t+1,7))==3 ...
                                    || fix(mod(t+1,7))==4 || fix(mod(t+1,7))==5 )
                                t1(index)=1;
                            else t1(index)=0;
                            end
                            if t1(index)==1
                                dV(index)=(-(A*Gy(w)+B*Gy(w)^2)*V(index))*dt;   % r*V(index)*(1-V(index)/K)
                            else dV(index)=r*V(index)*(1-V(index)/K)*dt;
                            end
                            V(index+1)=V(index)+dV(index);
                            %         if mod(t,1)==0 || mod(t-time,1)==0
                            %             Vres(in,1)=w;
                            %             Vres(in,2)=t;
                            %             Vres(in,3)=V(index+1);
                            %             in=in+1;
                            %         end
                            if t==7*(week-1)+5+time
                                Vmin=V(index+1);
                            end
                            index=index+1;
                        end;index=index-1;V(index)=[];
                    end
                    if Vmin<Best_V
                        Best_V=Vmin;Best_Gy=Gy;
                        result=[Best_Gy Best_V];
                    end
%                     y(xuhao)=V_test;
%                     xuhao=xuhao+1;
                end
            end
        end
    end
end
disp(Best_Gy);disp(Best_V)
toc