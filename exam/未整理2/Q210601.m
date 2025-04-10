clear;clc
load K;
T_set=[173 198 230 257 25];
vm=78;
%% 位置/cm
x(1)=0;
bian=25;xi=5;xiao=30.5;n_bian=2;n_xiao=11;n_xi=n_xiao-1;length=bian*n_bian+xiao*n_xiao+xi*n_xi;         % 435.5 cm
dt=0.5;                                         % /s
v=vm/60;
dot=fix(length/(v*dt)+1);
for i=1:dot
    x(i)=(i-1)*dt*v;    % /(cm/s)
    t(i)=(i-1)*dt;
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
for i=1:dot                                     % 39:39+708=747
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
for i=1:dot
    dtknowx=355;
    if x(i)>=dtknowx && l(i)==100
        l(i)=103;
    end
end
t2=[t;x;p;l];
%% 计算 T_air
% 计算小温区
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
% 假设冷却区推迟降温
% a2=T_set(4)-25/(30.5+10/v);
% for i=1:dot
%     if x(i)>=339.5 && x(i)<=380
%         Ta(i)=-5.68*x(i)+2183.36;
%     end
% end
thefigure=0;
if thefigure==1
    plot(t,Ta,'r','LineWidth',6);
    xlabel('x轴(s)');ylabel('T_{air}(℃)')
end
%% k的分区
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
%% k的代入
for hf=1:nf     %第hf行
    for i=qu(hf,1):qu(hf,2)
        if i==1
            pT(qu(hf,1))=25;    % 设定初值
        else pT(i)=Ta(i)+(pT(i-1)-Ta(i))*exp(-K(hf)*dt);
        end
    end
end
%%
result=[pT'];
figure
scatter(t(1:dot),pT(1:dot),'r','filled');xlabel('时间(s)');ylabel('T(℃)');grid on;
%%
numqu=[3 6 7 8];
for i=1:4
    if i<4
        duex(i)=(2*(25+(numqu(i)-1)*33.5)+30.5)/2;
    else duex(i)=(25+(numqu(i)-1)*33.5)+30.5;
    end
    [sn,tn]=find(x<=duex(i));tn=max(tn);nowx(i)=x(tn);step(i)=x(tn+1)-nowx(i);
    for hf=1:nf
        if nowx(i)>qu(hf,1) && nowx(i)<=qu(hf,2)
            dueT(i)=Ta(tn)+(pT(tn)-Ta(tn))*exp(-K(hf)*step(i));
        end
    end
end
disp('needT='),disp(dueT)
%%
result=[t' pT'];
title={'时间(s)','温度(摄氏度)'};
result_table=table(result(:,1),result(:,2),'VariableNames',title);
writetable(result_table,'result.csv');
%%
[ys,re]=happier(dot,pT);re