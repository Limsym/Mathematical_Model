function [R,w]=critic(x)
% Criteria Importance Though Intercrieria Correlation 赋权法
% CRITIC 赋权法
[n,m]=size(x);
%% 计算相关系数
R=corrcoef(x);
%% 计算冲突性 c(j)
for j=1:m
    c(1,j)=1*m-sum(R(:,j));
end
%% 计算信息量 I(j)
s=he2/n;
I=s.*c;
%% 计算权重系数 w(j)
w=I/sum(I(1,:));
%% 输出结果
% t11=['R='];t12=[num2str(R)];
% t21=['c='];t22=[num2str(c)];
% t31=['I='];t32=[num2str(I)];
% t41=['w='];t42=[num2str(w)];
% space=[' '];
% disp(t11),disp(t12),disp(space),disp(t21),disp(t22),disp(space),
% disp(t31),disp(t32),disp(space),disp(t41),disp(t42),disp(space),
end