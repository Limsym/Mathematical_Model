test=B(1:4999,:);
a=size(test,1);
b=size(test,2);
SA=test-mean(test);
CM=corrcoef(SA);
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
new_score=SA*PV;
for i=1:a
    total_score(i,1)=sum(new_score(i,:));
    total_score(i,2)=i;
end
result_report=[new_score,total_score];
result_report=sortrows(result_report,-(k+1));
disp('PCA处理的得到各主成分得分及总得分为:');
result_report
%% 求对应各主成分的系数
cofficient=[];
for i=1:size(test,2)
    sum1=0;
    for j=1:Com_num
    sum1=sum1+PV(i,j)*DS(j,2);
    end
    cofficient(i)=sum1/sum(DS(1:Com_num,2));
end
disp('PCA求得的各主成分的系数为:');
cofficient