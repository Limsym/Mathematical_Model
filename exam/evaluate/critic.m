function [w,Score,T,Tc,R]=critic(A)
% Criteria Importance Though Intercrieria Correlation 赋权法
% CRITIC 赋权法
[n,m]=size(A);
%% 计算相关系数
R=corrcoef(A);
%% 计算冲突性 c(j)
for j=1:m
    c(1,j)=1*m-sum(R(:,j));
end
%% 计算信息量 I(j)
s=std(A,0);
I=s.*c;
%% 计算权重系数 w(j)
w=I/sum(I(1,:));
%% 调用
[Score,T,Tc] = evamor(A,w)
end