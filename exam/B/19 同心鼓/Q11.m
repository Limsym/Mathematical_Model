clear;clc;tic
m=0.27;M=3.6;g=-9.8;k=0.8;          % 设定初值
v1=-sqrt(m*(-g)*2/m);v3=-v1;
syms v2 v4 tl tL T1 T2;assume(v2>0),assume(v4<0);assume(tl>0);
res=solve(k*1/2*(m*v1^2+M*v2^2)==1/2*(m*v3^2+M*v4^2),m*v1+M*v2==m*v3+M*v4,v2,v4);
tl=solve(1/2*(-g)*tl^2==0.4,tl);
id=1;dn=1;dh=0.01;               	% result
for n=8:dn:16;for h=0.01:dh:0.10
        disp(n);
        syms tL;assume(tL>0);tL=solve(res.v4*tL+1/2*g*tL^2==-h,tL);tw=2*tl-tL;
        theta=360/n;R=0.6/sin(deg2rad(theta))*sin(deg2rad(1/2*(180-theta)));l=sqrt(R^2+h^2);
        syms T1 T2;assume(T1>0);assume(T2>0);
        T1=vpasolve(0==(-h-(M*l)/(n*T1)*g)*cos(sqrt((n*T1)/(M*l))*tl)+(M*l)/(n*T1)*g);
        T2=vpasolve(0==(-h-(M*l)/(n*T2)*g)*cos(sqrt((n*T2)/(M*l))*tw)+(M*l)/(n*T2)*g);
        Wp1=T1*h; Wp2=T2*h;
        re(id,:)=[n,h,l,double(T1),double(T2),double(Wp1),double(Wp2)];id=id+1;end;end
[ind,~]=find(max(re(:,4),re(:,5))<10^3);
figure(1);scatter(re(ind,1),re(ind,2),re(ind,4),'.','cdata',re(ind,4));
xlabel('人数 n'),ylabel('高度 h');toc
x=intersect(re(ind,1),re(:,1));y=intersect(re(ind,2),re(:,2));             	% ndgrid
id=1;i=1;
id=1;j=1;
while id<=size(ind,1)
    i=find(y==(re(ind(id),2)));
    if id>1 && re(ind(id),1)~=re(ind(id-1),1)
        j=j+1;
    end
    z(i,j)=re(ind(id),4);
    id=id+1;
end
mesh(x,y,z);xlabel('x'),ylabel('y'),zlabel('z');surf(x,y,z)
% x0=re(ind,1);y0=re(ind,2);
% c=re(ind,4);% c表示对z轴进行着色
% plot3(re(ind,1),re(ind,2),re(ind,4)),grid on
% % plot3(re(ind,1),re(ind,2),re(ind,5))
% Z=re(ind,4);
% [id1,id2]=find(z==0);
% for i=1:size(id1,1);z(id1(i),id2(i))=nan;end
% subplot(x,y)
% for i=1:size(x,1);for j=1:size(x,1);ind1=find(re(:,1)==x0(i));ind2=find(re(:,2)==y0(i));z(i,j)=re(ind,4)();end;end
% h = colorbar;%右侧颜色栏
% set(get(h,'label'),'string','拉力大小 (牛)');%给右侧颜色栏命名
