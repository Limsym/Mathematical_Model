clear;clc;tic
% 录入基本信息
fl0=[6,7,3,2,1,4,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,2,1,1,1,1,1,0,1,1,2,4,1,3,2,4,3,3,3,1,6,1,5,1,2,3,1,2,2,0,1,3,1,1,6,3,2,3,2,4,1,2,0,2,1,4,5,1,5,3,3,1,4,6,3,8,4,3,5,1,3,3,6,1,3,5,4,3,1,1,1,3,1,0,1,2,5,0,3,4,2,4,5,0,3,5,2,1,2,2,4,6,6,2,3,1];
cl0=[149 70  50  39  39 212 111 120 ...
    235 345 355 521 558 575 487 464 ...
    365 637 167 275 392 661 421 224];
pipy=98238;
ba_tw=180.82;
td=40;                	% min
vfamax=100;
C0=2;
dt1=10;
seat=158;
alpha=87.2/100;
day=[6 18];             % night=[18 24;0 6];
beta=[20 25]/100;
zkl=1.5;
% 开始计算
dot0=size(fl0,2);
dt=1;                   % min
dot=60*24*1/dt;
for i=1:dot
    minu(i)=i;
    h(i)=i/60;
    nf(i)=fl0(ceil(i/10));
    if i<=30 cl(i)=cl0(24)/60;
    else cl(i)=cl0(ceil((i-30+0.1)/60))/60;
    end
    ndp(i)=fl0(ceil(i/10))/dt1*seat*alpha;          % deplanement
    if h(i)>=day(1) && h(i)<day(2)
        N1p(i)=ndp(i)/zkl*beta(1);                  % 需车辆 未延后
    else N1p(i)=ndp(i)/zkl*beta(2);
    end
end
% figure,plot(h,ndp)
for i=1:dot
    if i*1<=td
        N(1,i)=N1p(dot-td);
    else N(1,i)=N1p(i-td);
    end
end
sumN1=sum(N(1,:));sumCl=sum(cl0);ncfix=sumN1/sumCl;cl=cl*ncfix;             % 车流量 预处理
vfamax=9/2;
lambda=-20/10;    % parameter
set_N1=200;set_nc=900;
for i=1:dot
    if i==1 
        N(3,1)=set_N1;nc(1)=set_nc;
    else
        N(3,i)=N(3,i-1)+N(1,i-1)-N(2,i-1);
        nc(i)=nc(i-1)+cl(i-1)-N(2,i-1);
        if N(3,i)<0 || nc(i)<0 
            T=[N(3,i-1),nc(i-1)];
            N(2,i-1)=min(T);if N(2,i-1)<0;N(2)=0;end
            nc(i)=nc(i-1)+cl(i-1)-N(2,i-1);
            N(3,i)=N(3,i-1)+N(1,i-1)-N(2,i-1);
        end
    end
    vf(1,i)=(-1/(N(3,i)-1))+1;
    vf(2,i)=(-1/(nc(i)-1))+1;
    vf(3,i)=vf(1,i)*vf(2,i)*vfamax;
    N(2,i)=vf(3,i)*dt;% if N(2,i)<0;N(2,i)=0;end
    if N(2,i)<0;N(2,i)=0;end;
    % if N(2,i)<0;N(2,i)=0;end
end
result=[N;nc;vf;minu;h];
save('C1_Q1','N','minu','nc');
%% 画
% figure;bar(h,nf);xlabel('时间/小时');ylabel('实际抵港航班数/架');grid on
paint=1;
if paint==1
    figure
    scatter(h,nc,'fill');grid on;hold on
    scatter(h,N(2,:) ,'fill');grid on;hold on
    scatter(h,N(3,:),'fill');grid on
%     plot(h,N1p,'b');grid on
    plot(h,N(2,:));grid on
    plot(h,N(3,:));grid on
    plot(h,cl,'r');grid on
    legend('蓄车池队伍长度','出租车发车量','出租车需求量') % ,'新增出租车需求量'
    xlabel('t/h');ylabel('车/辆');paint=0;
end
%%
tf=1;
num=1;
for tw=1:1/100:500    %   I set
    tthis(num)=tw;
    dist=29;    % m
    s(1)=dist;	% m
    twork(1)=38;    % min
    t_all=twork(1)+tw;
    workhours=12;
    pipm=pipy/12/30/workhours/60;
    [pi0(1),R(1),C(1)]=s2pi(s(1));
    Rm(1)=tw*pipm;
    pi(1,num)=pi0(1)-Rm(1);     % gamma=0.1;
    v=s(1)/twork(1);
    t_kong=dist/v;
    twork(2)=t_all-t_kong;
    s(2)=dist;
    fucm=7.1;               % fuel_consumption
    proi=7.03;              % oil pricing
    Co=s(2)*fucm/100*proi;
    Ct=20;
    gamma=0.1;
    Cq=s2pi(s(1))*0.1;
    C(2)=Ct+Co+C0+Cq;
    R(2)=pipm*twork(2);
    pi(2,num)=R(2)-C(2);
    cha=(pi(1,num)-pi(2,num))^2;
    if tw==tf
        minc=cha;
        thispi=pi(:,num);
        thistw=tw;
    elseif cha<minc
        minc=cha;
        thispi=pi(:,num);
        thistw=tw;
    end
    num=num+1;
end
minc,thispi,thistw
figure;plot(tthis,pi(1,:),'r');hold on ;plot(tthis,pi(2,:),'b')
toc
