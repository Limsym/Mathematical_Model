clear;clc
% Q1
re=zeros(1,6);
m=0.27;
M=3.6;
r1=mean([20.7 21.3])/2/100;
r2=0.2;
h=0.22;
hei=0.4;
C=0.5;
p=1.293;    % g/L
S=pi*r1^2;
g=-9.8;
v0=0;
%% 设定初值
% 不可控初值
k=0.8;
E0=m*(-g)*0.4;     % =1/2*vmax^2*m;
v1=-sqrt(E0*2/m);
v3=-v1;
Q=(1-k)*E0;
E1=E0-Q;
% v11=-sqrt(E1*2/m);
syms v2 v4
assume(v2>0),assume(v4<0)
res=solve(k*1/2*(m*v1^2+M*v2^2)==1/2*(m*v3^2+M*v4^2),m*v1+M*v2==m*v3+M*v4,v2,v4);
res.v2;
res.v4;
Wn=1/2*res.v2^2*M+M*(-g)*h;
syms tl;assume(tl>0);
tl=solve(1/2*(-g)*tl^2==0.4,tl);
syms tL;assume(tL>0);
tL=solve(res.v4*tL+1/2*g*tL^2==-h,tL);
tw=2*tl-tL;
% 可控初值
% l=2.00;       % [1 3]
for n=8:16
    for h=0.01:0.01:0.1
        % 因变量
        theta=360/n;
        R=0.6/sin(deg2rad(theta))*sin(deg2rad(1/2*(180-theta)));
        l=sqrt(R^2+h^2);
        d2=R-r1;
        % minT=M*(-g)/h*l/n;
        % H=1.00;   % [ ]
        % dh=0.05;
        % E=10000;
        %% solving
        % testing
        % alpha=rad2deg(asin(M*(-g)/(n*T)));
        % if alpha <=30
        %     ys(3)=1;
        % else ys(3)=0;
        % end
        % R=l*cos(deg2rad(alpha));
        % d1=R/sin(deg2rad((180-theta)/2))*sin(deg2rad(theta));
        % if d1>=0.6
        %     ys(1)=1;
        % else ys(1)=0;
        %     disp('间距越界')
        % end
        
        % h=l*sin(deg2rad(alpha));
        % R=1.50;
        % a=sqrt(-1/(2*m)*C*p*S*g);
        % a1=a/arctan(a*(-g))
        % v(t)=t*sqrt()
        % v=2*m*v0/(C*p*S*v0*t+2*m);
        % trial
        % t=0;
        % id=1;v(1)=0
        % while x<=0.4
        %     v(id)=
        %     t=0.01;
        %     id=id+1;
        % end
        
        syms T1;assume(T1>0);T1=vpasolve(0==(-h-(M*l)/(n*T1)*g)*cos(sqrt((n*T1)/(M*l))*tl)+(M*l)/(n*T1)*g);
        syms T2;assume(T2>0);T2=vpasolve(0==(-h-(M*l)/(n*T2)*g)*cos(sqrt((n*T2)/(M*l))*tw)+(M*l)/(n*T2)*g);
        
        % while h1<=h
        %     dW=T*(h-h1)/l*h1*n;
        %     W=W+dW;
        %     h1=h1+0.001;
        % end
        % if W >= Wn
        %     ys(2)=1;
        % else ys(2)=0;
        %     disp('做功过低');disp(W);disp('<');disp(vpa(Wn));
        % end
        % vmax=g*t;
        % vmax=g*t;%% result
        % dh=;
        % if dh<=h
        %     ys(size(ys,2))=1;
        % else ys(size(ys,2))=0;
        % end
        % objective function
        Wp1=T1*h;
        Wp2=T2*h;
        if re(1)==0
            re=[n,h,l,double(T1),double(T2),double(Wp1),double(Wp2)];
        else re=[re;n,h,l,double(T1),double(T2),double(Wp1),double(Wp2)];
        end
    end
end