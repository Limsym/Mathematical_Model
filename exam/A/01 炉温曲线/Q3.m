clear;clc;tic;load K;
T_set0=[175 195 235 255 25];        %加减10
% vm_set0=[65 100];
%% 输入
% T_set1=[176.25 186.25 235 265];   %v1=90;
% T_set2=[177.25 187.25 236 266];   %v2=92;
% T_set1=[170 187.5 235 260];
% T_set2=[172.5 192.5 237.5 265];
T_set1=[170 187.5 235 260];
T_set2=[172.5 192.5 237.5 265];vm_set=[70 80];
BC=[2.5 1.25 1 0.5 0.25];% 2.5  1 0.5 0.25 0.125 0.0125 0.00625 0.001 0.0005,0.05,0.025,0.00125,0.0001
Better=5;
%%
for times=1:size(BC,2)
    bcv=BC(times)*1;
    bcT=BC(times)*1;
    stepv=bcv*1/2;
    stepT=bcT*1/2;
    for vm=vm_set(1):bcv:vm_set(2)
        for T1=T_set1(1):bcT:T_set2(1)
            for T2=T_set1(2):bcT:T_set2(2)
                for T3=T_set1(3):bcT:T_set2(3)
                    for T4=T_set1(4):bcT:T_set2(4)
                        if vm==vm_set(1) i5=1;end
                        T_set=[T1 T2 T3 T4 25];
                        clear pT
                        pT=Tv2p(T_set,vm);
                        ys=happier(vm,pT);
                        % 计算 S
                        clear h;clear zT;clear tTT;clear S
                        [none,tTT]=find(pT==max(pT));
                        length=435.5;v=vm/60;dt=0.5;dot=fix(length/(v*dt))+1; % cm
                        numh=1;
                        for i=1:dot
                            if pT(i)>217 && i<=tTT
                                h(numh)=pT(i)-217;%zT(numh)=pT(i);
                                numh=numh+1;
                            end
                        end
                        S=sum(h)*dt*ys;
%                         S0=sum(h)*dt;
                        if T1+T2+T3+T4+i5==sum(T_set1)+1
                            result(1,:)=[S,T1,T2,T3,T4,vm];
                        elseif ys==1 % && S<550
                            result=[result;S,T1,T2,T3,T4,vm];
                        end
                    end
                end
            end
        end
    end
    % 排序 确定较优区间
    [~,index]=sort(result(:,1));result=result(index,:);if result(1,1)==0;result(1,:)=[];end
    if size(result,1)>2000
        result=result(1:2000,:);
    end
    [aaa none]=size(result);
    if aaa<=Better;better=aaa;else better=Better;end
    roundS=[min(result(:,1)) max(result(:,1))];
    T_set1=[min(result(1:better,2)-stepT) min(result(1:better,3)-stepT)-stepT min(result(1:better,4)-stepT) min(result(1:better,5)-stepT)];   %v1=90;
    T_set2=[max(result(1:better,2)+stepT) max(result(1:better,3)+stepT)+stepT max(result(1:better,4)+stepT) max(result(1:better,5)+stepT)];   %v2=92;
    vm_set=[min(result(1:better,6)-stepv) max(result(1:better,6)+stepv)];
    if times==1
        RES=[bcv bcT T_set1 T_set2 vm_set roundS];
    else RES=[RES;bcv bcT T_set1 T_set2 vm_set roundS];
    end
end
toc
%% putout
[n,m]=size(result);
if n>=1000
    quhang=1000;
else quhang=n;end
none=ones(quhang,1)*25;
sampleT_set=result(1:quhang,2:5);sampleT_set=[sampleT_set none];
samplevm=result(1:quhang,6);
sampleS=result(1:quhang,7);
sure=0;if sure==1;
    save ('data3.mat','sampleT_set','samplevm','sampleS','result')
end
% scatter best
sample=1;
[pT,t]=Tv2p(sampleT_set(sample,:),samplevm(sample));
[ys,re]=happier(samplevm(sample),pT);re
figure;scatter(t,pT,'fill');