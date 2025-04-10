clear,clc
filename = '附件.xlsx';
data=xlsread(filename,'A2:B710');
clear filename
[n,m]=size(data);                           % m=709
%% 位置/cm
bian=25;xi=5;xiao=30.5;
n_bian=2;n_xiao=11;n_xi=n_xiao-1;
length=bian*n_bian+xiao*n_xiao+xi*n_xi;         % 435.5 cm
dt=0.5;                                         % /s
unknownt=(data(1,1)-dt)/dt+1;                   % 个 38
nowt=unknownt+1;                                % 个 19.0是第39个点
x(1)=0;
p(1)=1;
dot=nowt+n-1;
vm=70;
%% 未知区
for i=1:unknownt
    v(i)=vm/60;                                 % /(cm/s)
    t(i)=(i-1)*0.5;
end
for i=2:unknownt
    x(i)=x(i-1)+v(i)*dt;
    for WQ=1:10
        if x(i)>=25+30.5*WQ+5*(WQ-1) && x(i)<25+35.5*WQ
            p(i)=1+2*WQ;
        end
    end
    for WQ=1:11
        if  x(i)<=25
            p(i)=1;
        elseif x(i)>=25+30.5*WQ+5*(WQ-1) && x(i)<25+35.5*WQ
            p(i)=1+2*WQ;
        elseif x(i)>=25+35.5*(WQ-1) && x(i)<25+30.5*WQ+5*(WQ-1)
            p(i)=2*WQ;
        end
    end
end

%% 已知区 划区
for i=nowt:dot                             % 39:39+708=747
    v(i)=70/60;                                 % /(cm/s)
    t(i)=data(i-unknownt,1);                    % /s  19-373 //from 0
    x(i)=x(i-1)+v(i)*dt;
    T(i)=data(i-unknownt,2);
    for WQ=1:11
        if  x(i)<=25
            p(i)=1;l(i)=0;
        elseif x(i)>=25+35.5*(WQ-1) && x(i)<25+30.5*WQ+5*(WQ-1)
            p(i)=2*WQ;l(i)=10*WQ;
        elseif x(i)>=25+30.5*WQ+5*(WQ-1) && x(i)<25+35.5*WQ && WQ<11
            p(i)=1+2*WQ;l(i)=10*WQ+5;
        elseif x(i)>=25+35.5*10+30
            p(i)=23;l(i)=10*WQ+10;
        end
    end
end
T(1)=25;            % 推测
t2=[t;x;p;l];
scatter(t(nowt:dot),T(nowt:dot),35,'fill');xlabel('时间(s)');ylabel('T(℃)');

%% 计算 T_air
%录入数据
T_set=[175 195 235 255 25];
for i = 1:dot
    if     p(i) >=  2 && p(i)<=10	%1:5
        Ta(i)=T_set(1);
    elseif p(i) == 12                   % 6
        Ta(i)=T_set(2);
    elseif p(i) == 14                   % 7
        Ta(i)=T_set(3);
    elseif p(i) >= 16 && p(i)<=18       % 89
        Ta(i)=T_set(4);
    elseif p(i) >= 20                   % 1011
        Ta(i)=T_set(5);
    end
end
% 计算间隙期
nj=[5 6 7 9];                           % 边界
for j=1:4
    xl(j)=25+35.5*nj(j)-5;
    xr(j)=25+35.5*nj(j);
    a(j)=(T_set(j+1)-T_set(j))/5;
    b(j)=T_set(j)-a(j)*xl(j);
    for i=1:dot
        if x(i)>=xl(j) && x(i)<=xr(j)
            Ta(i)=a(j)*x(i)+b(j);
            Tj(i)=2;
        else Tj(i)=0;
        end
    end
end
a1=150/25;
b1=25;
for i=1:dot
    % 假定炉前炉后区 这里是线性拟合
    if p(i)==1
        Ta(i)=a1*t(i)+b1;
        T(j)=1;
    elseif p(i)>=19
        Ta(i)=25;
    end
    % 假定炉前炉后区
end
%% 假设：冷却区推迟降温
% for i=1:dot
%     if x(i)>=339.5 && x(i)<=380
%         Ta(i)=-5.68*x(i)+2183.36;
%     end
% end
%%
% plot(x,Ta,'LineWidth',6);xlabel('位置(cm)');ylabel('T_{air}(℃)');% scatter(t,Ta,'fill')
%% 求解 k
k(1)=0;
for i=2:dot-1
    k(i)=((T(i+1)-T(i))/dt)/(-T(i)+Ta(i));       %℃/s
end
%% 绘图k-t曲线
if k(587)==min(k)
    k(587)=k(588);
end
%scatter(t(nowt:dot-1),k(nowt:dot-1)*6000+100,35,'filled');xlabel('时间(s)');ylabel('k')
% %% 散点估计
% ET(39)=T(39);
% for i=nowt:numt-1
%     ET(i+1)=Ta(i)+(ET(i)-Ta(i))*exp(-k(i)*dt);
% end
for i=1:dot
    dtknowx=355;
    if x(i)>=dtknowx && l(i)==100
        l(i)=103;
    end
end
%% k的分区拟合
% 对x划区
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
        qu(hf,lf)=s;Want0=qu;
        % k的范围，划区结束
    end
end
% if qu(1,1)<39
%     qu(1,1)=39; %不计30℃以下数据
% end
% Want(6,2)=626;>=592
% Want(7,1)=627;<=652
% Want(1,1)=39; %不计30℃以下数据
%for i=1:59
% Want(6,2)=620-i;
% Want(7,1)=621+i;
%% k的拟合1
% pT(39)=T(39);    给定初值
% dt1=0.5;      % 缩小求解步长
% ndt=dt*dt1;
for hf=1:1     %第hf行
    numk=1;
    mink(hf)=min(k);
    maxk(hf)=max(k);
    pT(qu(hf,1))=25;
    for testk=mink(hf):0.0001:maxk(hf)
        wc(qu(hf,1))=0;
        for i=qu(hf,1):qu(hf,2)                           % 取值范围
            pT(i+1)=Ta(i)+(pT(i)-Ta(i))*exp(-testk*dt);
            if T(i+1)==0
                wc(i+1)=0;
            else wc(i+1)=(pT(i+1)-T(i+1))^2;
            end
        end
        WC(numk)=sum(wc);
        if testk==mink(hf)
            minwc = WC(numk);
            K(hf)=testk;
        elseif WC(numk)<minwc
            minwc=WC(numk);
            K(hf)=testk;
        end
        numk=numk+1;
    end
    for i=qu(hf,1):qu(hf,2)
        pT(i+1)=Ta(i)+(pT(i)-Ta(i))*exp(-K(hf)*dt);
    end
end
%% k的拟合2
for hf=2:nf     %第hf行
    numk=1;
    %     if hf==1
    mink(hf)=min(k);
    maxk(hf)=max(k);
    %     else
    %         mink(hf)=min(k(qu(hf,1):qu(hf,2)-1));
    %         maxk(hf)=max(k(qu(hf,1):qu(hf,2)-1));
    %     end
    for testk=mink(hf):0.00001:maxk(hf)                    % 设定初值
        for i=qu(hf,1):qu(hf,2)                            % 取值范围
            if i==1
                pT(qu(1,1))=25;
                wc(i)=0;
            elseif i<=dot
                %                 if Tj(i)=0
                pT(i)=Ta(i)+(pT(i-1)-Ta(i))*exp(-testk*dt);
                %                 elseif Tj(i)=1
                %                     pT(i)=Ta(i)+((pT(i-1)-Ta(i))*exp(-testk*dt);
                wc(i)=(pT(i)-T(i))^2;
            end
        end
        WC=sum(wc);
        if testk==mink(hf)
            minwc=WC;
            K(hf)=testk;
        elseif WC<minwc
            minwc=WC;
            K(hf)=testk;
        end
        numk=numk+1;
    end
end
for i=qu(hf,1):qu(hf,2)
    if i==1
        pT(i)=25;
    elseif i<=dot
        pT(i)=Ta(i)+(pT(i-1)-Ta(i))*exp(-K(hf)*dt);
    end
end
%     figure
%     scatter(t(39:746),pT(39:746),5,'r','filled');xlabel('时间(s)');ylabel('T_{air}(℃)');hold on;grid on;
%     scatter(t(39:746), T(39:746),5,'b','filled');legend('拟合曲线','实验曲线');hold on
% scatter(t(39:746), Ta(39:746),5,'filled')
thefigure=0;
if thefigure==1
    scatter(t(39:746),k(39:746),'fill');xlabel('时间(s)');ylabel('k');grid on;hold on
    plot(t(39:746),k(nowt:dot-1),'LineWidth',2)
    thefigure=0;
end
clear pianchalv
for i=nowt:dot
    j=i-unknownt;
    pianchalv(j)=(pT(j)-T(j))/pT(j);
end
PCL=mean(pianchalv)
nihedu=1-PCL
%K=k_better
save ('K.mat','K'); %表示将内存变量data, x, y, z 保存到当前路径下的datas.mat文件，其它程序若要载入这几个变量的数据，只需前面路径下执行
load K;
%%
clear dT
for i=1:dot-unknownt-1
    j=i+unknownt;
    dT(i)=(T(j+1)-T(j))/dt;
end
%     figure
%     scatter(t(unknownt+1:dot-1),dT(1:dot-unknownt-1),35,'r','filled');xlabel('时间(s)');ylabel('dT(℃)');grid on;
if thefigure==1
    figure
    scatter(t(nowt:dot-1),k(nowt:dot-1)*4000+90,35,'filled');xlabel('时间(s)');hold on
    scatter(t(39:746), l(39:746)*2,5,'g','filled');
    scatter(t(39:746),pT(39:746),5,'r','filled');xlabel('时间(s)');ylabel('T_{air}(℃)');hold on
    scatter(t(39:746), T(39:746),5,'b','filled');legend('k','区间','拟合曲线','实验曲线');grid on;
    thefigure=0;
end
[ys,re]=happier(vm,pT)