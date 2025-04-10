function [w_ultimately,beta,a,alpha]=zcf(x0)
% 主成分分析法 PCA
% not successful
% updated at 2020.06.16;05.20
[n,m]=size(x0);
%% 预处理
for i=1:m
    x(:,i)=(x0(:,i)-mean(x0(:,i)))./std(x0(:,i));       % (去中心化处理 'x0(:,i)-mean(x0(:,i));') (标准化处理 'std(x(:,i));')
end

%% 计算特征值，排序lambda，计算对应特征向量,单位化,a
C=cov(x);                                               % 计算协方差C
[V,D]=eig(C);
n2D=length(D);
for i=1:n2D
    lambda0(1,i)=D(i,i);                                % [1*m]，对角线元素为特征值
end
% 排序 w
[lambda,index]=sort(lambda0,'descend');                 %从大到小排序
% 计算 a=w
eigenvector0=V;                                         %[m*m]，复制特征向量
for i=1:m
    j=index(1,i);
    w0(:,i)=eigenvector0(:,j);                          %w==a
end
% 单位化 w
chushu2=sum(w0).^2;
for i=1:m
    for j=1:m
        w(i,j)=w0(i,j)./chushu2(1,j);
    end
end
a=w;

%% 计算每个主成分的贡献率alpha、累计贡献率beta
for i=1:m
    alpha(1,i)=lambda(1,i)/sum(lambda);
    beta(i)=sum(lambda(1,1:i))/sum(lambda);
end
count_num=0;                                    % 选取主成分个数
for i=1:m
    if beta(i)<0.85;
        count_num=count_num+1;
    end
end
count_num=count_num+1;                          % 选取主成分个数
%% 计算各主成分的权重Z
w_ultimately=zeros(1,m);
for i=1:count_num
    w_ultimately=w_ultimately+w(i,:)*alpha(1,i);
end
% calculate y
for i=1:n
    for j=1:m
        for k=1:m
            y(i,j,k)=x(i,j)*a(k,j);             % 第k项主成分，第i项
        end
    end
end
% calculate Z & sumZ
for i=1:m
    Z(:,:,i)=y(:,:,i)*alpha(1,i);
    if i==1
        sumZ=Z(:,:,1);
    else
        sumZ(:,:,i)=sumZ(:,:,i-1)+Z(:,:,i);
    end
end

end