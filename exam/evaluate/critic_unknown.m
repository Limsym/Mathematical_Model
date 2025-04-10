function [R,w]=critic(X)
[n,m]=size(X);
X(:,3) = min_best(X(:,3)) ;% 将极小型指标转化为加大型
xmin = min(X);
xmax = max(X);
xmaxmin = xmax-xmin;
Z =(X-xmin)./repmat(xmaxmin,n,1);  % 最大值最小值标准化，去除量纲
R = corrcoef(Z);  % 计算相关系数矩阵，但是要将相关系数矩阵都变成正相关
for i =1:n
    for j=1:m
        if R(i,j)<0
            R(i,j)=-R(i,j);
        end
    end
end 
delta = zeros(1,m);
c = zeros(1,m);
for j=1:m
    delta(j) = std(Z(:,j));
    c(j)= size(R,1)-sum(R(:,j));
end
C = delta.*c;
w =C./(sum(C))

% min_best子函数：
function [change_x]=min_best(x)
  r=size(x,1);
  change_x = repmat(max(x),r,1)-x;
end
end
