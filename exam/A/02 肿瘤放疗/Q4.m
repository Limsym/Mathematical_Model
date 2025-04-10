clear;clc;tic;load('r2_1')
r=0.0835753;K=1381.78096;
V(1)=4/3*pi*(2*10/2)^3;
good=4/3*pi*(5/2)^3;
delta=mean([0.36 0.2 0.5]);
dt=0.001;
time=0.004;
days=21;
op=[1 0];
Best_E=inf;
Best_V=inf;
xuhao=1;
for t2=5.2:0.001:5.3                      % [1.43 7]
    N=fix((days-time)/t2)+1;
    for D=5.1:0.001:5.2               % 4.95:0.001:5.77               % 2.6:0.001:2.9	% [2.5 6.5]
        M=D*N;
        if  M<=70               % [20 70]
             if N==4                    % N>=3 && N<=5
                E=(A*delta*D+B*(delta*D)^2)*N;
                if E<400
                    index=1;
                    for t=0:dt:days
                        if mod(t,t2)<=time
                            dV(index)=(r*V(index)*(1-V(index)/K)-(A*D+B*D^2)*V(index))*dt;
                        else dV(index)=r*V(index)*(1-V(index)/K)*dt;
                        end
                        V(index+1)=V(index)+dV(index);
                        if mod(t,t2+time)==0                                  % fix(t)==days-1 && mod(t,1)==time
                            V_test=V(index+1);
                        end
                        index=index+1;
                    end;index=index-1;V(index)=[];
                    if op(1)==1
                        if V_test<good && E<Best_E
                            Best_t2=t2;Best_N=N;Best_D2=D;Best_V=V_test;Best_E=E;Best_M=M;
                            result=[Best_M Best_N Best_D2 Best_t2 Best_V Best_E];
                        end;end
                    if op(2)==1
                        if V_test<Best_V
                            Best_t2=t2;Best_N=N;Best_D2=D;Best_V=V_test;Best_E=E;Best_M=M;
                            result=[Best_M Best_N Best_D2 Best_t2 Best_V Best_E];
                        end;end
                    y(xuhao)=V_test;
                    xuhao=xuhao+1;
                end
             end
        end
    end
end
disp(result)
toc
%%
tn=0.1:dt:(days)/20;
figure;plot(tn,y);legend('放疗方案');
xlabel('t2');ylabel('放疗期末肿瘤体积 minV（mm^3）');
% figure;plot(tn,V);legend('最佳放疗方案');
% xlabel('放射强度 D（Py）');ylabel('放疗期末肿瘤体积 minV（mm^3）');
toc
%% 
index=1;
in=1;           % 天数
for t=0:dt:days %
    if mod(t,t2)<=time
        dV(index)=(r*V(index)*(1-V(index)/K)-(A*Best_D2+B*Best_D2^2)*V(index))*dt;
    else dV(index)=r*V(index)*(1-V(index)/K)*dt;
    end
    V(index+1)=V(index)+dV(index);
    if t==days-1+time           % fix(t)==days-1 && mod(t,1)==time
        V_test=V(index+1);
    end
    if mod(t,Best_t2)==0 || mod(t,Best_t2+0.004)==0  || t==time
        record(in,:)=[t V(index)];
        in=in+1;
    end
    index=index+1;
end;index=index-1;V(index)=[];
figure;plot(0:0.001:days,V);legend('最佳放疗方案');
xlabel('放射强度 D（Py）');ylabel('放疗期末肿瘤体积 minV（mm^3）');
toc