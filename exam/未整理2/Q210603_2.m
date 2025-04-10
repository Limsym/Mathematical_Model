clear;clc;tic
load K;
T_set0=[175 195 235 255 25];
% T_set1=[177.5 196 230 265];v1=91;
% T_set2=[178.8 198 232 265];v2=92;
% vbc=      0.25  *   1    ;                   % m/min
% Tbc=      0.25  *   1    ;                   % ℃
% vbc=      0.25  *   4    ;                   % m/min
% Tbc=      0.25  *   4    ;                   % ℃
minT1=165;      maxT1=185;
minT2=185;      maxT2=205;
minT3=225;      maxT3=245;
minT4=245;      maxT4=265;
vmmin=60;       vmmax=100;
buchang=[0.05,0.025]*100;%,0.05,0.025,0.00125,0.0001
shaixuan=20;
% maxtimes=size(buchang,2);
for times=1:size(buchang,2)
    step=buchang(times)*0;
    bc=buchang(times);
    i=1;
    vbc=bc*1;
    Tbc=bc*1;
    T_set1=[minT1 minT2 minT3 minT4];   %v1=90;
    T_set2=[maxT1 maxT2 maxT3 maxT4];   %v2=92;
    for vm=vmmin:vbc:vmmax; % 设定v值 m/min
        for T1=T_set1(1):Tbc:T_set2(1)
            for T2=T_set1(2):Tbc:T_set2(2)
                for T3=T_set1(3):Tbc:T_set2(3)
                    for T4=T_set1(4):Tbc:T_set2(4)
                        T_set=[T1 T2 T3 T4 25];
                        length=435.5; % cm
                        dt=0.5;
                        %                         for vm=v1:vbc:v2; % 设定v值
                        i5=(vm-vmmin)/vbc+1;% if it's the 1st 'for'
                        v=vm/60;                                                    % m/s
                        clear pT;clear Ta;clear t;clear x;clear p;clear l;clear V;clear H;clear S
                        [pT]=Tv2p(T_set,vm);
                        dot=fix(length/(v*dt))+1;
                        %% 约束
                        ys=happier(vm,pT);
                        %% 计算 S
                        clear h;clear zT;clear tTT
                        i6=1;
                        [none,tTT]=find(pT==max(pT));
                        for i=1:dot
                            if pT(i)>217 && i<=tTT
                                h(i6)=pT(i)-217;zT(i6)=pT(i);
                                i6=i6+1;
                            end
                        end
                        th=(i6-1)*dt;
                        S=sum(h)*dt*ys;
                        S0=sum(h)*dt;
                        if T1+T2+T3+T4+i5==sum(T_set1)+1
                            result(1,:)=[S,T1,T2,T3,T4,vm,S0,th];
                        elseif ys==1 && S<550
                            result=[result;S,T1,T2,T3,T4,vm,S0,th];
                        end
                    end
                end
            end
        end
    end
    %% 排序
    [~,index]=sort(result(:,1));
    sresult=result(index,:);
    sresult(1,:)=[];
    [aaa bbb]=size(result);
    if aaa>=shaixuan
        T1min=min(sresult(1:shaixuan,2)-step*bc);
        T1max=max(sresult(1:shaixuan,2)+step*bc);
        T2min=min(sresult(1:shaixuan,3)-step*bc);
        T2max=max(sresult(1:shaixuan,3)+step*bc);
        T3min=min(sresult(1:shaixuan,3)-step*bc);
        T3max=max(sresult(1:shaixuan,4)+step*bc);
        T4min=min(sresult(1:shaixuan,5)-step*bc);
        T4max=max(sresult(1:shaixuan,5)+step*bc);
        vmmin=min(sresult(1:shaixuan,6)-step*bc);
        vmmax=max(sresult(1:shaixuan,6)+step*bc);
        Smin=min(sresult(:,1));
        Smax=max(sresult(:,1));
    else
        T1min=min(sresult(1:aaa,2)-step*bc);
        T1max=max(sresult(1:aaa,2)+step*bc);
        T2min=min(sresult(1:aaa,3)-step*bc);
        T2max=max(sresult(1:aaa,3)+step*bc);
        T3min=min(sresult(1:aaa,3)-step*bc);
        T3max=max(sresult(1:aaa,4)+step*bc);
        T4min=min(sresult(1:aaa,4)-step*bc);
        T4max=max(sresult(1:aaa,5)+step*bc);
        vmmin=min(sresult(1:aaa,6)-step*bc);
        vmmax=max(sresult(1:aaa,6)+step*bc);
        Smin=min(sresult(:,1));
        Smax=max(sresult(:,1));
    end
    if times==1
        RES=[vbc Tbc T1min T1max T2min T2max T3min T3max T4min T4max vmmin vmmax Smin Smax];
    else RES=[RES;vbc Tbc T1min T1max T2min T2max T3min T3max T4min T4max vmmin vmmax Smin Smax];
    end
end

toc
%% putout
[n,m]=size(sresult);
if n>=1000
    quhang=1000;
else quhang=n;
    for i=1:quhang;dtca(i,1)=25;end
    sampleT_set=[sresult(1:quhang,2:5),dtca];
    samplevm=[sresult(1:quhang,6)];
    sampleS0=[sresult(1:quhang,7)];
    save ('data3.mat','sampleT_set','samplevm','sampleS0'); %表示将内存变量data, x, y, z
    %保存到当前路径下的datas.mat文件，其它程序若要载入这几个变量的数据，只需前面路径下执行
    %% scatter best
    vm=samplevm(1);T_set=sampleT_set(1,:);
    [pT,t]=Tv2p(T_set,vm);
    figure;scatter(t,pT,'fill')
end
