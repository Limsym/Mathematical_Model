%% 导入数据 创建Excel表格"data0.xlxs"记录样本数据，并以矩阵类型导入6*7数据
filename = '医疗质量评价指标.xlsx';
data=xlsread(filename,'B3:H8');
%% 数据预处理
[n,m]=size(data);
B=data(1,:);
A=data(2:n,:);
n=n-1;
aj=85;
bj=93;
for j=1:m
    AM(j)=max(A(:,j));
    Am(j)=min(A(:,j));
end
% C=A同向化后的数据集
for j=1:m
    if B(j)==1
        C(:,j)=A(:,j);
    elseif B(j)==2
        C(:,j)=AM(j)-A(:,j);
    else
        cj=max(aj-Am(j),AM(j)-bj);%cj=max(aj-Am(2),AM(2)-bj);
        for i=1:n
            if A(i,j)<aj
                C(i,j)=1-(aj-A(i,j))/cj;
            elseif A(i,j)>=aj&&A(i,j)<=bj
                C(i,j)=1;
            else C(i,j)=1-(A(i,j)-bj)/cj;
            end
        end
    end
end
% D1=C归一化处理后的数据集
xmin=min(C);
xmax=max(C);
for j=1:m
    D1(:,j)=(C(:,j)-xmin(j))/(xmax(j)-xmin(j));
end
% D2=C标准差处理后的数据集
s=std(C,0);
for j=1:m
    D2(:,j)=(C(:,j)-mean(C(:,j)))/s(j);
end
%% ****************指标赋权****************
%% 1.标准离
%% 1.标准离差法
w1=bzlc(D1);
%% 2.熵权法
[w2,s2]=shang(C);
%% 3.CRITIC法
[R3,w3]=critic(D2);
%% 4.主成分分析法
[w4,beta,a4,alpha4]=zcf(D2);
%% 权重汇总
w=[w1;w2;w3;w4];
w_1=w';
%% ****************指标赋权****************
sw=std(w_1);
% 标准离差法
for i=1:n
    for j=1:m
        score1(i,j)=D1(i,j)*w(1,j);
    end
end
for i=1:n
    score1sum0(i)=sum(score1(i,:));
end
[score1sum1,index1]=sort(score1sum0,'descend');
score1sum2=[score1sum0',index1'];
% 熵权法
[s21,index2]=sort(s2,'descend');
score2sum2=[s2',index2'];
% CRITIC法
for i=1:n
    for j=1:m
        score3(i,j)=D2(i,j)*w(3,j);
    end
end
for i=1:n
    score3sum0(i)=sum(score3(i,:));
end
[score3sum1,index3]=sort(score3sum0,'descend');
score3sum2=[score3sum0',index3'];
% 主成分分析法
for i=1:n
    for j=1:m
        score4(i,j)=D2(i,j)*w(4,j);
    end
end
for i=1:n
    score4sum0(i)=sum(score4(i,:));
end
[score4sum1,index4]=sort(score4sum0,'descend');
score4sum2=[score4sum0',index4'];
% score
score=[score1sum2,score2sum2,score3sum2,score4sum2];
