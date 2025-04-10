clear;clc
%% ga函数的参数设置
fx = @rs2S;             % 设置适应度函数句柄，在定义的函数名前加个@即可
nvars = 2;              % 自变量个数，本题为5个自变量
A = [];  b = [];        % 线性不等式约束 Ax \leq b
Aeq = [];  beq = [];    % 线性等式约束 Aeq \cdot x= beq
lb = [0;1300];  ub = [0.15;2400];  % 对自变量x的限制
nonlcon = [];
%% 调用ga函数计算
% 调用格式[x_best,fval] = ga(fun,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options); 
% fx是函数句柄， nvars变量数，A,b,Aeq,Beq是线性约束，lb,ub限制X范围，
% nonlcon是非线性约束，做线性规划寻优时赋值为空即可。options是设定参数的结构体
% 根据需要设置，这里设置的是种群大小100，交叉概率0.8，迭代200次
options = gaoptimset('PopulationSize',100, 'CrossoverFraction', 0.8, 'Generations', 100);
[x_best, fval] = ga(fx,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options);