function y=fangcha(A)
[n,m]=size(A);
for i=1:n
    for j=1:m
        %差(i,j)=x(i,j)-ave(x(:,j))
        aveA(j)=sum(A(:,j))/n;
        cha(i,j)=A(i,j)-aveA(1,j);
    end
end
%平方(i,j)=(x(i,j)-ave(x(:,j))).^2
pingfang=cha.^2;
y=mean(pingfang);
%% 返回方差的值
text=['方差='];
disp(text)
disp(y)
end