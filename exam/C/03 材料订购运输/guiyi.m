function y=guiyi(x,type,ymin,y_max)
% x 为原始数据矩阵, s一行代表一个样本, 每列对应一个指标
[n,m] = size(x);
y = zeros(n,m);
xmin = min(x);
x_max = max(x);
switch type     % type 设定s正向指标1,负向指标2
    case 1
        for j=1:m
            y(:,j)=(y_max-ymin)*(x(:,j)-xmin(j))/(x_max(j)-xmin(j))+ymin;% ymin,y_max 为归一化s的区间端点
        end
    case 2
        for j=1:m
            y(:,j)=(y_max-ymin)*(x_max(j)-x(:,j))/(x_max(j)-xmin(j))+ymin;
        end
end
