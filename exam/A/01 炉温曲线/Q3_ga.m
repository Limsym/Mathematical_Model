clear;clc;tic
cd 'D:\Program Files\Polyspace\R2021a\bin\win64\A\01 炉温曲线'
%% ga函数的参数设置
% fx是函数句柄， nvars变量数，A,b,Aeq,beq是线性约束，lb,ub限制X范围，
fx = @sharea;          	% 设置适应度函数句柄，在定义的函数名前加个@即可
nvars = 5;              % 自变量个数，本题为5个自变量
A = [];  b = [];        % 线性不等式约束 Ax \leq b
Aeq = [];  beq = [];    % 线性等式约束 Aeq \cdot x= beq
lb = [165;185;225;245;65];  ub = [185;205;245;265;100];  % 对自变量x的限制
% nonlcon是非线性约束，做线性规划寻优时赋值为空即可。
nonlcon = [];
% options是设定参数的结构体。根据需要设置，这里设置的是种群大小100，交叉概率0.8，迭代200次
options = gaoptimset('PopulationSize',100, 'CrossoverFraction', 0.8, 'Generations', 200);
%% 调用ga函数计算
% 调用格式[x_best,fval] = ga(fun,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options); 
[x_best, fval] = ga(fx,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options);
disp(x_best);disp(fval);toc 
% 思考：如何调出最优的 n 组种群？
%% 绘图
[pT,t]=Tv2p(x_best);
figure
h1=plot(t,pT,'b','LineWidth',4);hold on
h2=plot([0 size(pT,2)/2],[217 217],'r--','linewidth',2);hold on
h3=plot([t(find(pT==max(pT))) t(find(pT==max(pT)))],[0 max(pT)*1.1],'r--','linewidth',2,'Color',[1 0.41 0.16]);hold on
point=8*10^5;
x=unifrnd(t(min(find(pT>=217))),t(find(pT==max(pT))),[1,point]);
sl=((t(find(pT==max(pT))))-t(min(find(pT>=217))))/(point-1);
% x=t(min(find(pT>=217))):sl:t(find(pT==max(pT)));
y=unifrnd(217,max(pT),[1,point]);
for i=1:point
    for j=min(find(pT>=217)):max(find(pT>=217))
        if x(i) >= t(j) && x(i) <=t(j+1) && y(i) >= pT(j)
            y(i)=[nan];x(i)=[nan];
        end
    end
end
h4=plot(x,y,'--','LineWidth',2,'Color',[76 80 84]/100);hold on              % [0.65 0.65 0.65]
xlabel('时间 t(s)');ylabel('温度 u(℃)');grid on
legend('炉温曲线','u=217','t=[t|u(t)=maxu]','所求阴影');hold on
set(gca,'child',[h2 h3 h1 h4])
axis([195 237,210,245])