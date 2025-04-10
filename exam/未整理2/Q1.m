clear;clc
load K;
T_set=[173 198 230 257 25];
vm=78;
% needT = 129.4483  166.2135  179.9974  217.0346
% 130.4901  167.5758  180.4286  218.3042
%% 开始
v=vm/60;dt=0.5;xb=25;xi=5;xw=30.5;nw=11;length=xb*2+(xw+xi)*(nw-1)+xw;dot=fix(length/(v*dt))+1;
for i=1:dot;t(i)=(i-1)*dt;x(i)=v*(i-1)*dt;end
[pT,t]=Tv2p(T_set,vm);
thefigure=0;
if thefigure==1
    figure;scatter(t(1:dot),pT(1:dot),'r','filled');xlabel('时间(s)');ylabel('T(℃)');grid on;
end
%%
numqu=[3 6 7 8];                                         % /s
for i=1:dot
    for wq=1:nw
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
end
for i=1:dot
    dtknowx=355;
    if x(i)>=dtknowx && l(i)==100
        l(i)=103;
    end
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
        elseif x(i)>=xr(j) && j<5  && x(i)<xl(j+1)
            Ta(i)=T_set(j);
        elseif x(i)>=xr(j)
            Ta(i)=T_set(j);
        end
    end
end
%% k的分区
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
    end
end
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
result=[t' pT'];
title={'时间(s)','温度(摄氏度)'};
result_table=table(result(:,1),result(:,2),'VariableNames',title);
writetable(result_table,'result.csv');
[ys,re]=happier(vm,pT);re