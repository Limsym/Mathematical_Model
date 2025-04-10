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
numt=nowt+n-1;
%% 未知区
for i=1:unknownt
    v(i)=70/60;                                 % /(cm/s)
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
for i=nowt:numt                             % 39:39+708=747
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
scatter(t(nowt:numt),T(nowt:numt),35,'fill');xlabel('时间(s)');ylabel('T(℃)');

%% 计算 T_air
%录入数据
T_set=[175 195 235 255 25];
for i = 1:numt
    if     p(i) >=  2 && p(i)<=10	%1:5
        T_label(i)=2;                   % T_label
        Ta(i)=T_set(1);
    elseif p(i) == 12                   % 6
        T_label(i)=3;
        Ta(i)=T_set(2);
    elseif p(i) == 14                   % 7
        T_label(i)=4; Ta(i)=T_set(3);
    elseif p(i) >= 16 && p(i)<=18       % 89
        T_label(i)=5;Ta(i)=T_set(4);
    elseif p(i) >= 20                   % 1011
        T_label(i)=6;Ta(i)=T_set(5);
    else T_label(i)=0;
    end
end
% 计算间隙期
nj=[5 6 7 9];                           % 边界
for j=1:4
    xl(j)=25+35.5*nj(j)-5;
    xr(j)=25+35.5*nj(j);
    %     tl(j)=xl(j)/v(j);
    %     tr(j)=xr(j)/v(j);
    a(j)=(T_set(j+1)-T_set(j))/5;
    b(j)=T_set(j)-a(j)*xl(j);
    a1=150/25;
    b1=25;
    for i=1:numt
        if x(i)>=xl(j) && x(i)<=xr(j)
            T_label(i)=j+20;                  % T_labelA指温度恒定的区域
            Ta(i)=a(j)*x(i)+b(j);
        end
    end
end
for i=1:numt
    % 假定炉前炉后区 这里是线性拟合
    if p(i)==1
        Ta(i)=a1*t(i)+b1;
    elseif p(i)>=19
        Ta(i)=25;
    end
    % 假定炉前炉后区
end
%% 假设冷却区推迟降温
for i=1:numt
    if x(i)>=339.5 && x(i)<=380
        Ta(i)=-5.68*x(i)+2183.36;
    end
end
plot(t,Ta)
xlabel('x轴(s)');ylabel('T_air(℃)')
%% 求解 k
k(1)=0;
for i=2:numt-1
    k(i)=((T(i+1)-T(i))/dt)/(-T(i)+Ta(i));       %℃/s
end
%% 绘图k-t曲线
%plot(t(nowt:numt-1),k(nowt:numt-1));title('系数k随时间的变化规律');xlabel('时间(s)');ylabel('k');
if k(587)==min(k)
    k(587)=k(588);
end
scatter(t(nowt:numt-1),k(nowt:numt-1),35,'filled');xlabel('时间(s)');ylabel('k')
% %% 散点估计
% ET(39)=T(39);
% for i=nowt:numt-1
%     ET(i+1)=Ta(i)+(ET(i)-Ta(i))*exp(-k(i)*dt);
% end
%% k的分区拟合
% 对x划区
fenduan=...
    [0    0
    10   50
    55   80
    85   90
    95   95
    100 105
    110 110
    120 120];
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
%pT(39)=T(39);    给定初值
% dt1=0.5;      % 缩小求解步长
% ndt=dt*dt1;
for hf=1:1     %第hf行
    numk=1;
    mink(hf)=min(k);
    maxk(hf)=max(k);
    pT(qu(hf,1))=25;
    for testk=mink(hf):0.0001:maxk(hf)
        wc(qu(hf,1))=0;
        for i=qu(hf,1):qu(hf,2)-1                           % 取值范围
            pT(i+1)=Ta(i)+(pT(i)-Ta(i))*exp(-testk*dt);
            if T(i+1)==0
                wc(i+1)=0;
            else wc(i+1)=(pT(i+1)-T(i+1))^2;
            end
            
        end
        WC(numk)=sum(wc);
        if testk==mink(hf)
            minwc = WC(numk);
                        k_better(hf)=testk;
        elseif WC(numk)<minwc
            minwc=WC(numk);
            k_better(hf)=testk;
        end
        numk=numk+1;
    end
    for i=qu(hf,1):qu(hf,2)-1
        pT(i+1)=Ta(i)+(pT(i)-Ta(i))*exp(-k_better(hf)*dt);
    end
end
%% k的拟合2
for hf=2:nf     %第hf行
    numk=1;
    if hf==1
        mink(hf)=min(k);
        maxk(hf)=max(k);
    else
        mink(hf)=min(k(qu(hf,1):qu(hf,2)-1));
        maxk(hf)=max(k(qu(hf,1):qu(hf,2)-1));
    end
    for testk=mink(hf):0.0001:maxk(hf)
        % 设定初值
        if hf==1
            pT(qu(hf,1))=25;
        else pT(qu(hf,1))=Ta(qu(hf,1))+(pT(qu(hf,1)-1)-Ta(qu(hf,1)))*exp(-k_better(hf-1)*dt);
        end
        wc(qu(hf,1))=0;
        for i=qu(hf,1):qu(hf,2)-1                           % 取值范围
            pT(i+1)=Ta(i)+(pT(i)-Ta(i))*exp(-testk*dt);
            wc(i+1)=(pT(i+1)-T(i+1))^2;
        end
        WC(numk)=sum(wc);
        if testk==mink(hf)
            minwc = WC(numk);
                        k_better(hf)=testk;
        elseif WC(numk)<minwc
            minwc=WC(numk);
            k_better(hf)=testk;
        end
        numk=numk+1;
    end
    for i=qu(hf,1):qu(hf,2)-1
        pT(i+1)=Ta(i)+(pT(i)-Ta(i))*exp(-k_better(hf)*dt);
    end
end
figure
plot( t(1:746),pT(1:746) );hold on;grid on
plot( t(39:746), T(39:746) );hold on
% plot( t(39:746),ET(39:746) );hold on
for i=nowt:numt
    pianchalv(i)=(pT(i)-T(i))/pT(i);
end
PCL=sum(pianchalv)/numt
%%
T_set=[173 198 230 257 25];
%%
title=['时间(s)','温度(摄氏度)'];
result=[title;result];
xlswrite('result.csv',result)