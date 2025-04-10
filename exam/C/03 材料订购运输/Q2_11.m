x=1:10
a=40/log(10);
b=1;
y=a*log(x)+60;
% y=guiyi(y',1,60,100);y=y';
figure;plot(x,y,'--');hold on
scatter(x,y,'fill');grid on;hold on
xlabel('周期'),ylabel('综合得分权重');
q=numel(y);%求y的元素个数
for i=1:1:q
    text(x(i)+0.1,y(i),num2str(y(i)),'color','blue','fontsize',9);hold on%这个函数将数值转化为字符串
end
text(6,85,'y=40/ln(10)*ln(x)+60','fontsize',14)
legend('\fontsize {14}各周期的综合得分权重','Location','NorthWest');
