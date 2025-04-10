%% 不考虑时间间隔
clear;clc;tic;load('r2_1')
for paint=1:3
    syms=paint-2;
r=0.0835753;K=1381.78096;
dt=0.001;
V(1)=520*(1-0);
days=7*(5+syms);
D=50;
time=0.004;
% good=65;
Best_D2=inf;Best_V=inf;
xuhao=1;
op=[0 1];
for t2=0.1:dt:(days)/20             % 35
    N=fix((days-time)/t2)+1;
    D=50/N;
    if N>=20
        index=1;
        for t=0:dt:days %
            if mod(t,t2)<=time
                dV(index)=(r*V(index)*(1-V(index)/K)-(A*D+B*D^2)*V(index))*dt;
            else dV(index)=r*V(index)*(1-V(index)/K)*dt;
            end
            V(index+1)=V(index)+dV(index);
            if mod(t,t2+0.004)==0               % fix(t)==days-1 && mod(t,1)==time
                V_test=V(index+1);
            end
            index=index+1;
        end;index=index-1;V(index)=[];
        if op(1)==1
            if V_test<good && D<Best_D2
                Best_t2=t2;Best_N=N;Best_D2=D;Best_V=V_test;result=[Best_V Best_D2 Best_N Best_t2];
        end;end
        if op(2)==1
            if V_test<Best_V
            Best_V=V_test;Best_D2=D;Best_t2=t2;Best_N=N;result=[Best_V Best_D2 Best_N Best_t2];
        end;end
        y(xuhao)=V_test;
        xuhao=xuhao+1;
    end
end
disp(result)
plot(0:0.001:days,V);legend('最佳放疗方案');hold on
end
xlabel('放射强度 D（Py）');ylabel('放疗期末肿瘤体积 minV（mm^3）');
%%
tn=0.1:dt:(days)/20;
hold on;plot(tn,y);legend('放疗方案');
% xlabel('l_{2}(day)');ylabel('放疗期末肿瘤体积 minV（mm^3）');
%% 输出最佳方案
tic
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
%% 考虑实际患者时间状况；考虑间隔
clear;clc;tic;load('r2_1')
r=0.0835753;K=1381.78096;
dt=0.001;
V(1)=520*(1-0);
week=5;
days=7*(week);
D=50;
time=0.004;
Best_D2=inf;Best_V=inf;
xuhao=1;
op=[0 1];
N=50/week/3;
D=50/N;
index=1;
for t=0:dt:days %
    if mod(t,t2)<=time
        dV(index)=(r*V(index)*(1-V(index)/K)-(A*D+B*D^2)*V(index))*dt;
    else dV(index)=r*V(index)*(1-V(index)/K)*dt;
    end
    V(index+1)=V(index)+dV(index);
    if mod(t,t2+0.004)==0               % fix(t)==days-1 && mod(t,1)==time
        V_test=V(index+1);
    end
    index=index+1;
end;index=index-1;V(index)=[];
if op(1)==1
    if V_test<good && D<Best_D2
        Best_t2=t2;Best_N=N;Best_D2=D;Best_V=V_test;result=[Best_V Best_D2 Best_N Best_t2];
    end;end
if op(2)==1
    if V_test<Best_V
        Best_V=V_test;Best_D2=D;Best_t2=t2;Best_N=N;result=[Best_V Best_D2 Best_N Best_t2];
    end;end
y(xuhao)=V_test;
xuhao=xuhao+1;
end
% end
disp(result)
plot(0:0.001:days,V);legend('最佳放疗方案');hold on
end
xlabel('放射强度 D（Py）');ylabel('放疗期末肿瘤体积 minV（mm^3）');
%%
tn=0.1:dt:(days)/20;
hold on;plot(tn,y);legend('放疗方案');
% xlabel('l_{2}(day)');ylabel('放疗期末肿瘤体积 minV（mm^3）');
%% 输出最佳方案
tic
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