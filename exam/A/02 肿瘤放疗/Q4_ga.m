clear;clc
% cd '改成自己保存的“Shade”函数所在的路径'
% ga函数的参数设置
week=3;

fx = @d2V2;              % 设置适应度函数句柄，在定义的函数名前加个@即可
nvars = week;              % 自变量个数，本题为5个自变量
A = [];  b = [];        % 线性不等式约束 Ax \leq b
Aeq = [];  beq = [];    % 线性等式约束 Aeq \cdot x= beq
lb = ones(1,3)*2.5;  ub = ones(1,3)*6.5;  % 对自变量x的限制
nonlcon = [];
%% 调用ga函数计算
% 调用格式[x_best,fval] = ga(fun,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options); 
% fx是函数句柄， nvars变量数，A,b,Aeq,Beq是线性约束，lb,ub限制X范围，
% nonlcon是非线性约束，做线性规划寻优时赋值为空即可。options是设定参数的结构体
% 根据需要设置，这里设置的是种群大小100，交叉概率0.8，迭代200次
tic
options = gaoptimset('PopulationSize',100, 'CrossoverFraction', 0.8, 'Generations', 100);
[x_best, fval] = ga(fx,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options);
% disp(x_best);disp(fval)
[r1 r2]=d2V3([3.295 3.624 3.704]);
toc
%% 绘图
[pT,t]=Tv2p([x_best(1:4) 25],x_best(5));
figure
h1=plot(t,pT,'b','LineWidth',4);hold on
h2=plot([0 size(pT,2)/2],[217 217],'r--','linewidth',2);hold on
h3=plot([t(find(pT==max(pT))) t(find(pT==max(pT)))],[0 max(pT)*1.1],'r--','linewidth',2,'Color',[1 0.41 0.16]);hold on
point=8*10^5;
x=unifrnd(t(min(find(pT>=217))),t(find(pT==max(pT))),[1,point]);
y=unifrnd(217,max(pT),[1,point]);
for i=1:point
    for j=min(find(pT>=217)):max(find(pT>=217))
        if x(i) >= t(j) && x(i) <=t(j+1) && y(i) >= pT(j)
            y(i)=[nan];x(i)=[nan];
        end
    end
end
h4=plot(x,y,'--','LineWidth',2,'Color',[0.65 0.65 0.65]);hold on
xlabel('时间 t(s)');ylabel('温度 u(℃)');grid on
legend('炉温曲线','T=217','t=[{T(t)=maxT}]','所求阴影');hold on
set(gca,'child',[h1 h2 h3 h4])
axis([190 233,210,245])