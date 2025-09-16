%% poly_func.m —— 多项式折扣函数
function poly_IperN = poly_func()
x = [500 5000 10000 20000 40000];
y = [1 0.95 0.9 0.85 0.8];
p = polyfit(x,y,3);
poly_IperN = @(xx) polyval(p,xx);
end
