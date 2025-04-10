clear;clc
tic
load datas;
T_set0=[175 195 235 255 25];
% T_set1=[175 195 235 255 25]-10;T_set1(5)=25;
% T_set1=[167 185 185 264];v1=77; 
% T_set2=[183 201 193 265];v2=79;
T_set1=[170 185 225 260];v1=65; 
T_set2=[185 205 240 265];v2=99;
vbc=      0.5  *   4     ;                   % m/min
bc=       0.5  *   10    ;                   % ℃
for T1=T_set1(1):bc:T_set2(1)
    for T2=T_set1(2):bc:T_set2(2)
        for T3=T_set1(3):bc:T_set2(3)
            for T4=T_set1(4):bc:T_set2(4)
                T_set=[T1 T2 T3 T4 25];
                %% 位置/cm
                length=435.5; % cm
                dt=0.5;x(1)=0;p(1)=1;
                for vm=v1:vbc:v2; % 设定v值
                    i5=(vm-v1)/vbc+1;
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
                            Ta(i)=T1;
                        elseif p(i) == 12                   % 6
                            Ta(i)=T2;
                        elseif p(i) == 14                   % 7
                            Ta(i)=T3;
                        elseif p(i) >= 16 && p(i)<=18       % 89
                            Ta(i)=T4;
                        elseif p(i) >= 20                   % 1011
                            Ta(i)=25;
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
                    a2=T_set(4)-25/(30.5+10/v);
                    for i=1:dot
                        if x(i)>=339.5 && x(i)<=380
                            Ta(i)=-5.68*x(i)+2183.36;
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
                    %% 约束
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
                    if Y(3)>=40/dt+1 && Y(3)<=90/dt+1
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
                    else ys=0;
                        vv=0;
                    end
                    clear h;clear zT;clear tTT
                    i6=1;
                    pTT=max(pT);
                    [none,tTT]=find(pT==pTT);
                    for i=1:dot
                        if pT(i)>217 && i<=tTT
                            h(i6)=pT(i)-217;zT(i6)=pT(i);
                            i6=i6+1;
                        end
                    end
                    th=(i6-1)*dt;
                    S=sum(h)*dt*ys;
                    if T1+T2+T3+T4+i5==sum(T_set1)+1
                        result(1,:)=[S,T1,T2,T3,T4,vv,th];
                    elseif ys==1 S<550
                        result=[result;S,T1,T2,T3,T4,vv,th];
                    end
                end
            end
        end
    end
end
%%
[~,index]=sort(result(:,1));
sresult=result(index,:);
toc