clear
tic
load datas;
load data2;
T_set=sampleT_set(1,:);
T_set(5)=25;
vm=samplevm(1);
%% 位置/cm
length=435.5; % cm
dt=0.5;x(1)=0;p(1)=1;
v=vm/60;                                                    % m/s
clear pT;clear Ta;clear t;clear x;clear p;clear l;clear V;clear H;clear S
dot=fix(length/(v*dt))+1;
for i=1:dot
    % /(cm/s)
    x(i)=v*(i-1)*dt;
    t(i)=0.5*(i-1);
end
for i=2:dot
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
        else p(i)=23;
        end
    end
end
for i=1:dot                             % 39:39+708=747
    for WQ=1:11
        if  x(i)<=25
            p(i)=1;
            l(i)=0;
        elseif x(i)>=25+35.5*(WQ-1) && x(i)<25+30.5*WQ+5*(WQ-1)
            p(i)=2*WQ;
            l(i)=10*WQ;
        elseif x(i)>=25+30.5*WQ+5*(WQ-1) && x(i)<25+35.5*WQ && WQ<11
            p(i)=1+2*WQ;
            l(i)=10*WQ+5;
        elseif x(i)>=25+35.5*10+30
            p(i)=23;
            l(i)=10*WQ+10;
        end
    end
end
T(1)=25;            % 推测
t2=[t;x;p;l];
%% 计算 T_air
%录入数据
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
    a1=(T_set(1)-25)/25;
    b1=25;
    for i=1:dot
        if x(i)>=xl(j) && x(i)<=xr(j)
            Ta(i)=a(j)*x(i)+b(j);
        end
    end
end
for i=1:dot
    % 假定炉前炉后区 这里是线性拟合
    if p(i)==1
        Ta(i)=a1*x(i)+b1;
    elseif p(i)>=19
        Ta(i)=25;
    end
    % 假定炉前炉后区
end
%% 假设冷却区推迟降温
a2=T_set(4)-25/(30.5+10);
b2=T_set(5)-a2*xl(4);
for i=1:dot
    if x(i)>=339.5 && x(i)<=380
        Ta(i)=a2*x(i)+b2;
    end
end
%% k的分区
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

%% k的代入
for hf=1:nf     %第hf行
    for i=qu(hf,1):qu(hf,2)-1
        if hf==1
            pT(qu(hf,1))=25;    % 设定初值
        else pT(qu(hf,1))=Ta(qu(hf,1))+(pT(qu(hf,1)-1)-Ta(qu(hf,1)))*exp(-K(hf-1)*dt);
        end
        pT(i+1)=Ta(i)+(pT(i)-Ta(i))*exp(-K(hf)*dt);
    end
end
%%
figure
scatter(t(1:dot),pT(1:dot),'r','filled');xlabel('时间(s)');ylabel('T(℃)');grid on;
for i=1:dot-1
    dT(i)=(pT(i+1)-pT(i))/dt;
    if abs(dT(i))>3
        Y(1)=0;
        %break
    else Y(1)=1;
    end
    if pT(i+1)>=150 && pT(i+1)<=190 && dT(i)>0
        y2(i)=1;
    else y2(i)=0;
    end
end
for i=1:dot
    if pT(i)>=217
        y3(i)=1;
    else y3(i)=0;
    end
end
Y(2)=sum(y2);
if Y(2)>=60/dt+1 && Y(2)<=120/dt+1
    Y(2)=1;
else Y(2)=0;
end
Y(3)=sum(y3);
if Y(3)>=(40/dt+1) && Y(3)<=(90/dt+1)
    Y(3)=1;
else Y(3)=0;
end
y4=max(pT);
if y4>=240 && y4<=250
    Y(4)=1;
else Y(4)=0;
end
ys=sum(Y);
if ys==4
    ys=1;
    vv=vm;
else ys=0
    vv=0;
end




toc




