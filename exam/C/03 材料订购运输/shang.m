%% updated at 0817
function [w,s]=shang(A)
% s 返回各行得分, w返回各列权重
[n,m]=size(A); % 返回对象个数 n, 指标个数 m
%% 1 数据的归一化处理得出p(i,j)
[A,ps]=mapminmax(A',0,1);
A=A';
%% 计算第j个指标下，第i个记录占该指标的比重p(i,j)
for i=1:n
    for j=1:m
        p(i,j)=A(i,j)/sum(A(:,j));
    end
end
%% 2 计算第j项指标的熵值E(j)
k=1/log(n);
for j=1:m
    for i=1:n
        if p(i,j)==0
        lnp(i,j)=0;
    else lnp(i,j)=log(p(i,j));
        end
    end
    E(j)=-k*sum(p(:,j).*lnp(:,j));  % 信息熵越大，指标出现概率越近，提供信息量越少，权重越小
end
%% 3 计算变异系数r(j)
r=ones(1,m)-E;  % 计算信息熵冗余度（变异系数）; ones 创建1行m列元素为1的矩阵
%% 4 计算权重系数w(j)
w=r./sum(r);    % 求权值w
%% 5 计算综合得分s(j)
s=w*p';         % 求综合得分
end