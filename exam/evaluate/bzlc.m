function [w,Score,T,Tc]=bzlc(A)
% 标准离差赋权法
%% 
[n,m]=size(A);
for j=1:m
    avex(j)=sum(A(:,j))/n;
    for i=1:n
        dx2(i,j)=(A(i,j)-avex(j))^2;
    end
    s(j)=sqrt(sum(dx2(:,j)))/n;
end
for j=1:m
    if s(j)==0
        w(j)=['该项指标标准离差为0'];
    else
        w(j)=s(j)/sum(s);
    end
end
%% 调用
[Score,T,Tc] = evamor(A,w)
end