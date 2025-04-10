%% Q2.1 
% 综合评价
%% 各周期的综合得分权重
x=1:10
a=40/log(10);
b=1;
y=a*log(x)+60;
% y=guiyi(y',1,60,100);y=y';
figure;plot(x,y,'--');hold on
scatter(x,y,'fill');grid on;hold on
xlabel('周期'),ylabel('综合得分权重');
q=numel(y);     % 求y的元素个数
for i=1:1:q
    text(x(i)+0.1,y(i),num2str(y(i)),'color','blue','fontsize',9);hold on
    % 这个函数将数值转化为字符串
end
text(6,85,'y=40/ln(10)*ln(x)+60','fontsize',14)
legend('\fontsize {14}各周期的综合得分权重','Location','NorthWest');


%% zhou qi xing

for i=1:24
    idl=i+(T-1)*24;
    minzq=min(O(:,idl)');
    if isempty(minzq)==1
        disp('x')
        return
    end
    zq{1}(:,i)=minzq';
    zq{2}(:,i)=mean(O(:,idl),2);
    [zq{3}(:,i),~]=max(O(:,idl),[],2);
end
max()
sortrows([sum(O(idb,:),2) idb],1,'DESCEND')
na()=sum(sum(O(ida,:)));
nc=sum(sum(O(idc,:)));
ida=find(index{1}(:,1)==1);
idb=find(index{1}(:,1)==2);
idc=find(index{1}(:,1)==3);
zq{2,1}=[ida zq{1,3}(ida,:)];
zq{2,2}=[idb zq{1,3}(idb,:)];
zq{2,3}=[idc zq{1,3}(idc,:)];
w=1:24;
T=1:10;