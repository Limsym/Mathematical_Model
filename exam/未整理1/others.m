%% 逐步线性回归
for i=1:10
    aa(:,i)=new_score(:,i);
end
i=2901;j=3500;
a=1;b=5000;
X=new_score(a:b,:);                             %自变量数据
Y=A(:,10);                                      %因变量数据
stepwise(X,Y)
% in=[1,2,3,4]表示X1、X2、X3、X4均保留在模型中
%%
