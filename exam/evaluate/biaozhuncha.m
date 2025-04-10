function y=biaozhuncha(x)
[n,m]=size(x);
for i=1:n
    for j=1:m
        %差(i,j)=x(i,j)-ave(x(:,j))
        aveA(j)=sum(x(:,j))/n;
        cha(i,j)=x(i,j)-aveA(1,j);
    end
end
%平方(i,j)=(x(i,j)-ave(x(:,j))).^2
pingfang=cha.^2;
fangcha=mean(pingfang);
y=sqrt(fangcha);
end