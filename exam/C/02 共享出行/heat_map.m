clear;clc
pass0=importdata('pass.txt');
taxi=importdata('taxi.txt');
n=size(pass0,1);
% 检验修改数据
p1=pass0(:,1:2);p2=pass0(:,3:4);
pass=pass0;
for i=1:n
    if pass0(i,1)==pass0(i,3) && pass0(i,2)==pass0(i,4)
        pass(i,:)=[];
    end
end
X=pass(:,2);
Y=pass(:,1);
X=taxi(:,2);
Y=taxi(:,1);
Xmin=min(X);Xmax=max(X);
Ymin=min(Y);Ymax=max(Y);


% t=[0:0.001:1].^1.0;
% X=0.5*(t).*cos(618*pi*t)+0.5;
% Y=0.5*(t).*sin(618*pi*t)+0.5;
% Xmin=0;Xmax=1;Ymin=0;Ymax=1;

%加密划分区间
Nx=500;
Ny=500;

Xedge=linspace(Xmin,Xmax,Nx);
Yedge=linspace(Ymin,Ymax,Ny);

%N的xy定义是转置的
[N,~,~,binX,binY] = histcounts2(X,Y,[-inf,Xedge(2:end-1),inf],[-inf,Yedge(2:end-1),inf]);

XedgeM=movsum(Xedge,2)/2;
YedgeM=movsum(Yedge,2)/2;

[Xedgemesh,Yedgemesh]=meshgrid(XedgeM(2:end),YedgeM(2:end));

%绘制pcolor图
figure(1)
pcolor(Xedgemesh,Yedgemesh,N');shading interp

%滤波平滑
%h=ones(round(Nx/20));
%h=fspecial('disk',round(Nx/40));
h = fspecial('gaussian',round(Nx/20),6);%最终选用高斯滤波
N2=imfilter(N,h);
figure(2)
pcolor(Xedgemesh,Yedgemesh,N2');shading interp

ind = sub2ind(size(N2),binX,binY);
col = N2(ind);

figure(3)
scatter(X,Y,20,col,'filled');
axis([-74.1 -73.85 40.625 40.9])

