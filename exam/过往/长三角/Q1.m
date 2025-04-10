%% 导入数据
filename = '附件1.xlsx';
A=xlsread(filename,'B2:K5001');
filename = '附件2.xlsx';
B=xlsread(filename,'B3:EX5002');
% 补充B矩阵空缺数据
filename = '新锅炉负荷.xlsx';
B(:,113)=xlsread(filename,'A3:A5002');
clear filename
%% 第一题
[n,m]=size(A);
[n1,m1]=size(B);
%% 绘制钢管温度时间变化曲线图
for j=1:m
    plot(A(:,j))
    hold on
end
aveA=mean(A,2);
plot(aveA,'r')
jingjiexian=ones(5000,1)*445;
plot(jingjiexian,'r')
%% A温度变化特征
% A极差
jc=max(A)-min(A);
% A方差与标准差
fc=fangcha(A);
bzc=biaozhuncha(A);
% 变化率及其标准差
for i=1:n-1
    for j=1:m
        Abhl(i,j)=(A(i+1,j)-A(i,j))/15;
    end
end
bhlbzc=biaozhuncha(Abhl);
% 超过警戒线
cgwdmax=max(A)-445;
for j=1:m
    if cgwdmax(j)<0
        cgwdmax(j)=0;
    end
end                             %最高温度超过预警线的值
for i=1:n
    for j=1:m
        if A(i,j)<=445
            chaoguoshichang(i,j)=0;
            chaoguowendu(i,j)=0;
        else chaoguoshichang(i,j)=1;
            chaoguowendu(i,j)=A(i,j)-445;
        end
    end
end
scsum=sum(chaoguoshichang);     %累计超过时长
wdsum=sum(chaoguowendu);        %累计超过温度
%% 第二题
% 指标预处理
jc1=-jc;
bzc1=-bzc;
bhlbzc1=-bhlbzc;
cgwdmax1=-cgwdmax;
scsum1=-scsum;
wdsum1=-wdsum;
% 评价指标汇总
zhibiao=[[jc1]' [bzc1]' [bhlbzc1]' [cgwdmax1]' [scsum1]' [wdsum1]'];
% 指标归一化
zbgy=guiyi(zhibiao,1,0,1);
% 熵权法求指标权重
[s,w]=shang(zbgy);
%% ********************************第三题********************************
% 归一化处理B
B1=guiyi(B,1,0,1);
% 相关系数计算
R=corrcoef(B1);
Rop2op=R(1:111,1:111);              %操作变量对操作变量的相关系数
Rop2op1=Rop2op;
Rop2st=R(1:111,112:153);            %操作变量对状态变量的相关系数
Rop2st1=Rop2st;
Rst2st=R(112:153,112:153);          %状态变量对状态变量的相关系数
Rst2st1=Rst2st;
for i=1:111
    for j=1:111
        if Rop2op1(i,j)<0.7
            Rop2op1(i,j)=0;
        else Rop2op1(i,j)=1;
        end
    end
end
for i=1:111
    for j=1:42
        if Rop2st(i,j)<0.7
            Rop2st1(i,j)=0;
        end
    end
end
for i=1:42
    for j=1:42
        if Rst2st1(i,j)<0.7
            Rst2st1(i,j)=0;
        end
    end
end
% 变化率
for i=1:4999
    aveAblh(i,:)=mean(Abhl(i,:));
end
for i=1:4999
    for j=1:143
        Bbhl(i,j)=B(i+1,j)-B(i,j);
    end
end
xlswrite('附件2变化率.xlsx',Bbhl) %Bbhl=xlsread('附件2变化率.xlsx');

%% ********************************第四题********************************
% 在各时间节点各输入变量对于10号管的温度的贡献值
%% 计算b(i,j)对于T10的贡献值
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
    T10(i,1)=sum(b2T2(i,:))+433.887;%424.909
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
plot(b2T2(:,4));axis([a b,-4,2]);hold on;plot(b2T2(:,102));plot(b2T2(:,105))

