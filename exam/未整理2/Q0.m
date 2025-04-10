clear,clc
%% 数据录入
vm=70;
filename = '附件.xlsx';data=xlsread(filename,'A2:B710');clear filename
[n,m]=size(data);                               % n=709
dt=0.5;                                         % /s
unknown=data(1,1)/dt;                           % 个 38
nowt=unknown+1;                                 % 个 19.0是第39个点
v=vm/60;                                        % /(cm/s)
xb=25;xi=5;xw=30.5;nw=11;
length=xb*2+(xw+xi)*(nw-1)+xw;                  % 435.5 cm
dot=fix(length/(v*dt))+1;
pc_dot=(dot-(unknown+n))/dot;                   % 理论实际偏差
for i=1:dot
    for wq=1:nw
        t(i)=(i-1)*dt;
        x(i)=v*(i-1)*dt;                        % x(i)=x(i-1)+v*dt;
        if  x(i)<=xb
            p(i)=1;
            l(i)=0;
        elseif x(i)>=xb+(xw+xi)*(wq-1) && x(i)<xb+xw*wq+xi*(wq-1)
            p(i)=2*wq;
            l(i)=10*wq;
        elseif x(i)>=xb+xw*wq+xi*(wq-1) && x(i)<xb+(xw+xi)*wq && x(i)<xb+xw*nw+xi*(nw-1)
            p(i)=1+2*wq;
            l(i)=10*wq+5;
        elseif x(i)>=xb+(xw+xi)*nw-xi
            p(i)=1+2*wq;
            l(i)=10*(wq+1);
        end
    end
    if i>=nowt                                      % 39:39+708=747
        T(i)=data(i-unknown,2);
    end
end
paint=0;
if paint==1
    scatter(t(nowt:dot),T(nowt:dot),35,'fill');xlabel('时间(s)');ylabel('T(℃)');grid on
    paint=0;
end
%% 计算 T_{air}
T_set=[175 195 235 255 25];                 % 录入预设温度
nl=[0 5 6 7 9];                             % 第i区左边界
for j=1:5
    if j==1;
        xl(j)=0;
        xr(j)=xb;
        a(j)=(T_set(1)-T_set(5))/xb;
        b(j)=xb;
    else
        xl(j)=xb+35.5*nl(j)-xi;
        xr(j)=xb+35.5*nl(j);
        a(j)=(T_set(j)-T_set(j-1))/xi;
        b(j)=T_set(j-1)-a(j)*xl(j);
    end
end
for i=1:dot
    for j=1:5
        if x(i)>=xl(j) && x(i)<xr(j)
            Ta(i)=a(j)*x(i)+b(j);
            xjx(i)=1;
        elseif x(i)>=xr(j) && j<5  && x(i)<xl(j+1)    %1:5
            Ta(i)=T_set(j);
            xjx(i)=0;
        elseif x(i)>=xr(j)
            Ta(i)=T_set(j);
            xjx(i)=0;
        end
    end
end
% plot(x,Ta,'LineWidth',6);xlabel('位置(cm)');ylabel('T_{air}(℃)');% scatter(t,Ta,'fill')
%% 求解 k
for i=nowt:dot-1
    dT(i)=T(i+1)-T(i);
    k(i)=(dT(i)/dt)/(Ta(i)-T(i));       %℃/s
end
%% 绘制 ET-t 曲线
operation=0;
if operation==1
    for i=nowt:dot-1
        if i==nowt
            ET(nowt)=T(nowt);       % 散点估计
        end
        ET(i+1)=Ta(i+1)+(ET(i)-Ta(i+1))*exp(-k(i)*dt);
    end
    Q=sum((ET(nowt:dot)-T(nowt:dot)).^2);
    X=sum(T(nowt:dot).^2);
    R=(1-(Q/X)^(1/2))*100
    figure;grid on;hold on;scatter(t(nowt:dot),ET(nowt:dot));scatter(t(nowt:dot),T(nowt:dot),'r')
    for i=nowt:dot                          % Error
        if i==nowt ET(i)=T(i);end
        for j=1:5
            if i<dot && x(i)>=xl(j) && x(i)<xr(j)
                ET(i+1)=ET(i)*exp(-testk*dt)+(a(j)*v*t(i)+b(j)-a(j)*v/testk)+(a(j)*v/testk-b(j))*exp(-testk*dt);
            elseif i<dot
                ET(i+1)=Ta(i+1)+(ET(i)-Ta(i+1))*exp(-testk*dt);
            end
        end
    end
end
    %% k的分区拟合
    for i=1:dot
        newdot=355;
        if x(i)>=newdot && l(i)==100
            l(i)=103;
        end
    end
    fenduan=...
        [0    0
        10   10
        15   50
        55   65
        70   75
        80   90
        95   95
        100 100
        103 103
        105 120];
    [nf,mf]=size(fenduan);
    for hf=1:nf
        for lf=1:mf
            iwant=fenduan(hf,lf);
            if lf==1
                [none,s]=find(l==iwant);
                s=min(s);
            else [none,s]=find(l==iwant);
                s=max(s);
            end
            qu(hf,lf)=s;
        end
    end
    % Want(6,2)=626;>=592
    % Want(7,1)=627;<=652
    % Want(1,1)=39; %不计30℃以下数据
    % for i=1:59
    % Want(6,2)=620-i;
    % Want(7,1)=621+i;
    %% k的拟合
    pT(1)=25;
    for hf=1:nf     %第hf行
        for testk=min(k):0.0001:0.4       %min(k)-0.1:0.00001:max(k)+0.1                    % 设定初值
            for i=qu(hf,1):qu(hf,2)                           % 取值范围
                %             for j=1:5
                %                 if i<dot && x(i)>=xl(j) && x(i)<xr(j)
                %                     pT(i+1)=pT(i)*exp(-testk*dt)+(a(j)*v*t(i)+b(j)-a(j)*v/testk)+(a(j)*v/testk-b(j))*exp(-testk*dt);
                %                 elseif i<dot
                %                     pT(i+1)=Ta(i+1)+(pT(i)-Ta(i+1))*exp(-testk*dt);
                %         end
                if i<dot
                    pT(i+1)=Ta(i+1)+(pT(i)-Ta(i+1))*exp(-testk*dt);
                    pc(i)=(pT(i)-T(i))^2;
                end
                if T(i)==0
                    pc(i)=0;
                end
            end
            %             end
            PC=sum(pc);
            if testk==min(k)
                minPC=PC;
                K(hf)=testk;
            elseif PC<minPC
                minPC=PC;
                K(hf)=testk;
            end
        end
        for i=qu(hf,1):qu(hf,2)
            if i<dot
                pT(i+1)=Ta(i+1)+(pT(i)-Ta(i+1))*exp(-K(hf)*dt);
            end
        end
    end
    %         if i<dot && x(i)>=xl(j) && x(i)<xr(j)
    %             pT(i+1)=pT(i)*exp(-K(hf)*dt)+(a(j)*v*t(i)+b(j)-a(j)*v/K(hf))+(a(j)*v/K(hf)-b(j))*exp(-K(hf)*dt);
    %         elseif i<dot
    %             pT(i+1)=Ta(i+1)+(pT(i)-Ta(i+1))*exp(-K(hf)*dt);
    %         end
    t2=[x;t;p;l;T;pT];
    % 拟合度
    Q=sum((pT(nowt:dot)-T(nowt:dot)).^2);
    X=sum(T(nowt:dot).^2);
    R=1-(Q/X)^(1/2)
    %%
    thefigure=0;
    if thefigure==1
        scatter(t(39:746),k(39:746),'fill');xlabel('时间(s)');ylabel('k');grid on;hold on
        plot(t(39:746),k(nowt:dot-1),'LineWidth',2)
        thefigure=0;
    end
    sure=0;
    if sure==1
        save('K.mat','K');
    end
    thefigure=0;
    if thefigure==1
        figure
        scatter(t(nowt:dot-1),k(nowt:dot-1)*4000+90,35,'filled');xlabel('时间(s)');hold on
        scatter(t(39:746), l(39:746)*2,5,'g','filled');
        scatter(t(39:746), T(39:746),5,'r','filled');xlabel('时间(s)');ylabel('T(℃)');hold on;
        scatter(t(39:746),pT(39:746),5,'b','filled');xlabel('时间(s)');ylabel('T(℃)');grid on
        legend('拟合曲线','实验曲线');
        thefigure=0;
    end
    [ys,re]=happier(vm,pT);re