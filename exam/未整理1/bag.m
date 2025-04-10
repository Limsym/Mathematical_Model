function [ID,sum_Weight,sum_Value] = bag(Value,Weight,Capacity)
N=length(Value);
m=zeros(N,Capacity+1); % 建立二维数组
sum_Weight=0;
ID=[];
% ii指第ii个物体，jj指'背包'容量
for jj=0:Capacity
    if jj>=Weight(1)
        m(1,jj+1)=Value(1);
    end
end % 初始化第一行，数组编码从1开始，因此下标要加1
for ii=2:N
    for jj=1:Capacity
        if jj>=Weight(ii) % 背包可以装下当前物体
            m(ii,jj+1)=max(m(ii-1,jj+1),m(ii-1,jj-Weight(ii)+1)+Value(ii)); % 1.不装 2.空出刚好可以放进去的容量
        else
            m(ii,jj+1)=m(ii-1,jj+1); % 容量不够不能装
        end
    end
end
sum_Value=m(N,Capacity+1); % 数组最后一行最后一列即为最大价值
x=zeros(1,N); % 布尔数组记录当前物体是否被装入
x(1)=1;
jj=Capacity; % 从最后一个数开始回溯
for ii=N:-1:2
    if jj>=Weight(ii)&m(ii,jj+1)==m(ii-1,jj-Weight(ii)+1)+Value(ii)
        x(ii)=1;
        jj=jj-Weight(ii); % 列要进行更新才能找到路线
    else
        x(ii)=0;
    end
end;
for ii=1:N
    if x(ii)==1
        sum_Weight=sum_Weight+Weight(ii);
        ID=[ID,ii];
    end
end



%% 参考代码
% v=[90 75 83 32 56 31 21 43 14 65 12 24 42 17 60];
% w=[30 27 23 24 21 18 16 14 12 10 9 8 6 5 3];
% m=zeros(15,121);//建立二维数组
% sum_W=0;
% product_N=[];
% //i指第i个物体，j指背包容量
% for j=0:120
%     if j>=w(1)
%         m(1,j+1)=v(1);
%     end
% end//初始化第一行，数组编码从1开始，因此下标要加1
% for i=2:15
%     for j=1:120
%         if j>=w(i)//背包可以装下当前物体
%             m(i,j+1)=max(m(i-1,j+1),m(i-1,j-w(i)+1)+v(i));//1.不装 2.空出刚好可以放进去的容量
%         else
%             m(i,j+1)=m(i-1,j+1);//容量不够不能装
%         end
%     end
% end
% sum_V=m(15,121);//数组最后一行最后一列即为最大价值
% x=zeros(1,15);//布尔数组记录当前物体是否被装入
% x(1)=1;
% j=120;//从最后一个数开始回溯
% for i=15:-1:2
%         if j>=w(i)&m(i,j+1)==m(i-1,j-w(i)+1)+v(i)
%             x(i)=1;
%             j=j-w(i);//列要进行更新才能找到路线
%         else
%             x(i)=0;
%         end
% end;
% for i=1:15
%     if x(i)==1
%         sum_W=sum_W+w(i);
%         product_N=[product_N,i];
%     end
% end
% disp(product_N)
% disp(sum_W)
% disp(sum_V)