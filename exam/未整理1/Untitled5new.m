B=xlsread('附件2.xlsx','B3:EX5002');
%% 对B主成分分析
for i=1:b
    SB(:,i)=(B(:,i)-mean(B(:,i)))/std(B(:,i));%%%标准化处理
end
CM=corrcoef(SB);
[V,D]=eig(CM);
for j=1:b
    DS(j,1)=D(b+1-j,b+1-j);
end
for i=1:b
    DS(i,2)=DS(i,1)/sum(DS(:,1));
    DS(i,3)=sum(DS(1:i,1))/sum(DS(:,1));
end
T=0.85;
for k=1:b
    if DS(k,3)>=T
        Com_num=k;
        break;
    end
end
for j=1:Com_num
    PV(:,j)=V(:,b+1-j);
end
new_score=Sdata*PV;
for i=1:a
    total_score(i,1)=sum(new_score(i,:));
    total_score(i,2)=i;
end
result_report=[new_score,total_score];
result_report=sortrows(result_report,-(k+1));
disp('PCA处理的得到各主成分得分及总得分为:');
% result_report
%%%%求对应各主成分的系数
cofficient=[];
for i=1:size(B,2)
    sum1=0;
    for j=1:Com_num
        sum1=sum1+PV(i,j)*DS(j,2);
    end
    cofficient(i)=sum1/sum(DS(1:Com_num,2));
end
disp('PCA求得的各主成分的系数为:');
%% 超温区间逐步线性回归
i=2901;j=3500;
X=new_score(i:j,:);                            %自变量数据
Y=A(i:j,10);                                   %因变量数据
stepwise(X,Y)
%导出系数beta、手动记录截距beta0
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
    T10(i,1)=sum(b2T2(i,:))+beta0;%424.909
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
%% 第五题
for i=1:5000
    for j=1:153
        for k=1:8
            xishu(i,j,k)=beta(k)*PV(j,k)*SB(i,j);
        end
    end
end