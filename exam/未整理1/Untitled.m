X=fujian1;
for j=1:m
H= jbtest (X(:,j));

H = jbtest (X,alpha);

[h, p, jbstat, cv] = jbtest (X,alpha)
end
% 其中，alpha 为显著水平（默认0.005）
% h 为测试结果，如果 h=0，则认为 X 服从正态分布，如果 h=1，则否定 X 服从正态分布；
% p 为接受假设的概率，p 越接近于0，可拒绝正态分布假设；
% CV 为是否拒绝原假设的临界值
zhibiao=xlsread('筛选的指标.xlsx')
%% 预处理
for i=1:n
    if A(i,3)==0
        A(i,3)=1;
    else A(i,3)=1/A(i,3)
    end
end
avex=mean(x);
for i=1:n
    for j=1:m
        %差(i,j)=x(i,j)-ave(x(:,j))
        cha(i,j)=x(i,j)-avex(1,j);
    end
end