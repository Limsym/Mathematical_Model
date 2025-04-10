function [Sx,cofficient,new_score,PV,]=zhuchengfen(x)
n=size(x,1);
m=size(x,2);
for i=1:m
    Sx(:,i)=(x(:,i)-mean(x(:,i)));          % (去中心化处理 '(x(:,i)-mean(x(:,i)));') or (标准化处理 'std(x(:,i));')
end
CM=corrcoef(Sx);                            % 求相关系数矩阵
[V,D]=eig(CM);                              % 计算特征向量
for j=1:m
    DS(j,1)=D(m+1-j,m+1-j);
end
for i=1:m
    DS(i,2)=DS(i,1)/sum(DS(:,1));
    DS(i,3)=sum(DS(1:i,1))/sum(DS(:,1));
end
T=0.85;                                     % 设定累计贡献率阈值
for k=1:m
    if DS(k,3)>=T
        Com_num=k;                          % 计数主成分
        break;
    end
end
for j=1:Com_num
    PV(:,j)=V(:,m+1-j);                      % 主成分对应
end
new_score=Sx*PV;
for i=1:n
    total_score(i,1)=sum(new_score(i,:));
    total_score(i,2)=i;
end
result_report=[new_score,total_score];
result_report=sortrows(result_report,-(k+1));
% disp('PCA处理的得到各主成分得分及总得分为:');
% result_report
%% 求对应各主成分的系数
cofficient=[];
for i=1:size(x,2)
    sum1=0;
    for j=1:Com_num
        sum1=sum1+PV(i,j)*DS(j,2);
    end
    cofficient(i)=sum1/sum(DS(1:Com_num,2));
end
% disp('PCA求得的各主成分的系数为:');
% cofficient
