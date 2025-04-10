function [ys]=n2we(N)
m = [3 2];          % 单位资源质量
M = 1200;
if sum(N.*m)<=M
    ys=1;       	% 满足
else ys=0;
end
end