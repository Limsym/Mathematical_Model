%1.1.1
x1=3;
z=1/2*log(x1+sqrt(1+x1^2))
%1.1.2
a=-3:0.1:3;
z=1/2.*((exp(0.3.*a))-exp(-0.3.*a)).*sin(a+0.3);
%1.2
A=[12 34 -4
    34 7 87
    3 65 7];
B=[1 3 -1
    2 0 3
    3 -2 7];
%1.2.1
C1=A*B
C2=A.*B
%1.2.2
D1=B^3
%1.2.3
E1=A/B
E2=A\B
E3=A./B
%1.2.4
C=A(:,1:3)
D=B(1:3,:)
F=C*D
%1.2.5
U=A(:,1)
V=B(1,:)
G=U*V
%1.3.1 rand det rank trace
A3=rand(5,5)
A31=det(A3)
A32=A3'
A33=rank(A3)
A34=trace(A3)
%1.3.2 find
[s,t]=find(A3==max(max(A3)))
%1.4.1
A4=[1/2 1/3 1/4
    1/3 1/4 1/5
    1/4 1/5 1/6];
b4=[0.95;0.67;0.52];
X1=A4\b4
b4(3,1)=0.53;
X2=A4\b4
%2.1
y21=0;
for i21=1:1:100;
    x21(i21)=1/i21;
    y21=x21(i21)+y21;
end
y21
%2.2
y22=0
for i22=1:1:51;
    x22(i22)=1/(i22*2-1);
    y22=y22+x22(i22);
end
y22
%2.3
syms x
ans1=limit(sin(x)/x,x,0)
ans2=limit(1+1/x,x,inf)
clear
%2.4
n=10     %给定自然数n
x=n
y=1;
for x=n:-1:1
    y=y*x;
end
clear
%2.5
y=0;
for n=1:100000     %控制精度
    y=y+1/n^2;
end
pi=sqrt(y*6)
clear
%2.6
z=0;
for x=1:1000
    y=x/6;
    if(y)==fix(y)
        z=z+x;
    end
end
z
% know more
% clear
% z=0;
% for x=1:1000
%     y(x)=x/6;
%     if(y(x))==fix(y(x))
%         y(x)=x;
%         z(x+1)=z(x-5)+y(x);
%     else y(x)=0;
%     end
% end
% max(z)
%2.7.1
%①
clear
x=1;
for n=1:10000
    x(n+1)=1/(1+x(n));
end
x(10001)
%②
clear
x=2;
for n=1:10000
    x(n+1)=1/(1+x(n));
end
x(10001)
%7.2
clear
x=1;
for n=1:10000
    x(n+1)=1/(1+x(n));
    if abs(x(n)-x(n+1))>0.00001
        ans=n+1
    end
end
%8.1
x(1)=0.4;
for i=1:500
    f(i)=1*x(i)*(1-x(i));
    x(i+1)=f(i);
end
f(500)
%8.1.2
x(1)=0.8;
for i=1:500
    f(i)=1*x(i)*(1-x(i));
    x(i+1)=f(i);
end
f(500)
%8.2.1
x=0.4;
for i=1:500
    f(i)=4*x(i)*(1-x(i));
    x(i+1)=f(i);
end
f(500)
%8.2.2
x=0.40001;
for i=1:500
    f(i)=4*x(i)*(1-x(i));
    x(i+1)=f(i);
end
f(500)
%8.3
%系数在复合函数中具有重要作用
%9
%Plan A
clear
fmin=10000;
for x3=0:0.0001:3;
    x2=3-2*x3^2;
    x1=2-x2^2;
    if (x1^2-x2+x3^2>=0&&x1+x2^2+x3^3<=20&&x2>=0&&x2<=3&&x1>=0&&x1<=3)
        f=x1^2+x2^2+x3^2+8;
        if f<fmin
            fmin=f;
            x1t=x1;x2t=x2;x3t=x3;
        end
    end
end
fmin,x1t,x2t,x3t,
%Plan B
clear
x3=0:0.0001:3;
n=length(x3);
for i=(1:n)
    x2(i)=3-2*x3(i)^2;
    x1(i)=2-x2(i)^2;
%     x2(i)=solve (x2(i)+2*x3(i)^2==3,x2(i));
%     x1(i)=solve (-x1(i)-x2(i)^2+2==0,x1(i));
    if x1(i)^2-x2(i)+x3(i)^2>=0 && x1(i)+x2(i)^2+x3(i)^3<=20 ...
            && x2(i)>=0 && x2(i)<=3 && x1(i)>=0 && x1(i)<=3
        f(i)=x1(i)^2+x2(i)^2+x3(i)^2+8;
        else f(i)=nan;
    end
end
[s,t]=find(f==min(f));fmin=f(t);
f(t),x1(t),x2(t),x3(t)

%3.1 length函数
clear
x=-10:0.01:10;
n=length(x);
for i=1:n
if x(i)<-1 & x(i)~=-3
    y(i)=x(i)+1;
elseif x(i)>1 & x(i)~=3 & x(i)~=5
    y(i)=x(i).^2+1;
else y(i)=(1+x(i)).^1/x(i);
end
end
plot(x,y)
%3.2
clear
x1=0:0.05:2*pi
x2=0:0.05:2*pi
y1=sqrt(cos(x1));
y2=sqrt(sin(x2));
plot(x1,y1,x2,y2)
%3.3
clear
t=0:0.01:1;
x=t.^2;
y=t.^3;
plot(x,y)
%3.4 ezplot 绘制隐函数图像
ezplot('x.^3.*y+x.*y^3=5',[-5,5])
%3.5 meshgrid,surf 绘制曲面
x=-2:0.04:2;y=-2:0.04:2;
n=length(x);[X,Y]=meshgrid(x,y);
for i=1:n
    for j=1:n
        Z(i,j)=X(i,j)^2+Y(i,j)^2;
    end
end
surf(X,Y,Z)
%3.6 meshgrid,surf 绘制曲面
clear
x=-2:0.04:2;y=-2:0.04:2;
n=length(x);[X,Y]=meshgrid(x,y);
for i=1:n
    for j=1:n
        if X(i,j)^2+Y(i,j)^2 <=4
            Z(i,j)=X(i,j)^2+Y(i,j)^2;
        else Z(i,j)=nan;
        end
    end
end
surf(X,Y,Z)


