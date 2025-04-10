% 各变量对于10号管的温度在各时间节点的贡献值
%% 计算b(i,j)对于10号管的温度在第i个时间节点的贡献值
for i=1:5000
    for j=1:153
        for k=1:8
            b2T(i,j,k)=beta(k)*PV(j,k)*SB(i,j);
        end
    end
end
for i=1:5000
    for j=1:153
        b2T2(i,j)=sum(b2T(i,j,:));
    end
end
%% 计算该模型下T10的温度散点值
for i=1:5000
    T10(i,1)=sum(b2T2(i,:))+454.674;%433.887;%424.909
end
%% 输出曲线图
plot(T10)
hold on
plot(A(:,10))
hold on
jingjiexian=ones(5000,1)*445;
plot(jingjiexian,'r')
hold on

plot(b2T2)

for j=1:153
    plot(b2T2(:,j))
    hold on
end

%% 各输入变量对温度贡献度的变化率之和
a=2901;d=3550;
for i=1:(d-a)
    bianhualv(i,:)=b2T2(a+i,:)-b2T2(a+i-1,:);
end
sumbhl=sum(bianhualv);
plot(sumbhl)
