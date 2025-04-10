clear;clc
plank=[120 50 3];
d=2.5;
height=53;
r=plank(2)/2;
% n=blank(2)/width;
% OA = sym('OA',[1,N]);
% syms OA;assume(OA>0);
% OA=solve(OA.^2+(r-r/(N/2)/2)^2==r^2);
N=N0;
% n=[1:plank(2)/d]';
n=[1:N]';
O=[0 0 0];
d=plank(2)/N;
xi=sqrt(r^2-(r-d/2-d*(n-1)).^2)
l=plank(1)/2-xi;
yi=plank(2)/2-d*n+d/2;
A=[xi,yi,zeros(N,1)];
alpha=sym('alpha',[N,1]);assume(alpha>0 & alpha<150);assume(alpha(1)<90 & alpha(1)>0);
% syms height;assume(height<=53 & height>0)
alpha(1)=asind((height-plank(3))/l(1));                       % 求解末时刻 a1
B=[xi+d/2*sind(alpha),yi,-d/2*cosd(alpha)];
% ve=[1,0];
% A=[xi+sind(alpha).*d/2,cosd(alpha).*d/2,zeros(N,1)];
% OA=A-O;
% E=sym('E',[N,2]);AE=sym('AE',[N,2]);
% eq1=AE==E-A;
% eq2=norm(AE)==PD;
% eq3=acosd(dot(AE,ve)/(norm(AE)*norm(ve)))==alpha;
% solve(eq1,eq2,eq3)
% syms 
% solve(B==A)
% B=[]
% C=A+[cosd(alpha).*l/2 sind(alpha).*l/2];
% A1Ci=C-A(1,:);AiA1=A-A(1,:);
C=B+[l(1)/2*cosd(alpha) zeros(N,1) l(1)/2*sind(alpha)];
BiC1=C(1,:)-B;
m=[0 0 1];
alpha=sym('alpha',[N,1]);
for ii=2:N/2
    eq1= sind(alpha(ii)) == dot(BiC1(ii,:),m) / (norm(BiC1(ii,:))*norm(m)) ;
    alpha(ii)=vpasolve( eq1,alpha(ii) );            % ,'ReturnConditions',true
end
for ii=N/2+1:N
    alpha(ii)=alpha(ii-(ii-(1+N)/2)*2);
end
for ii=2:N
    if ii<=N/2 && alpha(ii)<alpha(ii-1)
        alpha(ii)=180-alpha(ii);
    elseif ii>N/2 && alpha(ii)>alpha(ii-1)
        alpha(ii)=180-alpha(ii);
    end
end
B=[xi+d/2*sind(alpha),yi,-d/2*cosd(alpha)];
C=B+[l(1)/2*cosd(alpha) zeros(N,1) l(1)/2*sind(alpha)];
D=C+[l.*cosd(alpha)/2,zeros(N,1),-l.*sind(alpha)/2];
Alpha=double(alpha);
% C1=double(C);
l(1)/2;
% re{1}=double(D)
x=double(D(:,1));y=double(D(:,2));z=double(D(:,3));
% plot3(D(:,1),D(:,2),D(:,3));hold on;
scatter3(D(:,1),D(:,2),D(:,3),'fill')
xlabel('x'),ylabel('y'),zlabel('z');grid on
p_yx = polyfit(y,x,4);
x_out = polyval(p_yx, y);
p_yz = polyfit(y,z,4);
z_out = polyval(p_yz, y);
plot3(x_out ,y, z_out, 'r'); hold on;
