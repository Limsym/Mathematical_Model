clear;clc;tic
load K;
T_set0=[175 195 235 255 25];        %加减10
% 可行最大范围
% minT1=165;      maxT1=185;
% minT2=185;      maxT2=205;
% minT3=225;      maxT3=245;
% minT4=245;      maxT4=265;
% vmmin=65;       vmmax=100;
%% 输入
T_set1=[176.25 186.25 235 264.5];   %v1=90;
% T_set2=T_set1;
T_set2=[176.75 186.75 237.5 265];   %v2=92;
% vmmin=60;       vmmax=100;
vm_set=[65 100];
BC=[0.025]*20;%,0.05,0.025,0.00125,0.0001
Better=15;
%%
for times=1:size(BC,2)
    step=BC(times)*0;
    jzbc=BC(times);
    vbc=jzbc*1;
    Tbc=jzbc*1;
%     T_set1=[minT1 minT2 minT3 minT4];   %v1=90;
%     T_set2=[maxT1 maxT2 maxT3 maxT4];   %v2=92;
    for vm=vm_set(1):vbc:vm_set(2)
        T1=T_set1(1);
        T2=T_set1(2);
        T3=T_set1(3);%:Tbc:T_set2(3)
        T4=T_set1(4);%:Tbc:T_set2(4)
        if vm==vm_set(1) i5=1;end
        T_set=[T1 T2 T3 T4 25];
        clear pT;clear Ta;clear t;clear x;clear p;clear l;clear V
        % 约束
        [pT]=Tv2p(T_set,vm);
        ys=happier(vm,pT);
        % 计算 S
        clear h;clear zT;clear tTT;clear H;clear S
        i6=1;
        [none,tTT]=find(pT==max(pT));
        length=435.5;v=vm/60;dt=0.5;dot=fix(length/(v*dt))+1; % cm
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

% 排序 确定较优区间
[~,index]=sort(result(:,1));
sresult=result(index,:);
sresult(1,:)=[];
[aaa dtca]=size(result);
if aaa<=Better
    better=aaa;
else better=Better;
end
resS=[min(result(:,1)) max(result(:,1))];
%     Smin=min(sresult(:,1));
%     Smax=max(sresult(:,1));
% T1min=min(sresult(1:better,2)-step);
% T1max=max(sresult(1:better,2)+step);
% T2min=min(sresult(1:better,3)-step);
% T2max=max(sresult(1:better,3)+step);
% T3min=min(sresult(1:better,3)-step);
% T3max=max(sresult(1:better,4)+step);
% T4min=min(sresult(1:better,4)-step);
% T4max=max(sresult(1:better,5)+step);
% vm_set=[min(sresult(1:better,6)-step) max(sresult(1:better,6)+step)]
% vmmin=min(sresult(1:better,6)-step);
% vmmax=max(sresult(1:better,6)+step);
% if times==1
%     RES=[vbc Tbc T1min T1max T2min T2max T3min T3max T4min T4max vmmin vmmax resS];
% else RES=[RES;vbc Tbc T1min T1max T2min T2max T3min T3max T4min T4max vmmin vmmax resS];
% end

toc
%% putout
% [n,m]=size(sresult);
% if n>=1000
%     quhang=1000;
% else quhang=n;
% end
% dtca=ones(quhang,1)*25;
% sampleT_set=[sresult(1:quhang,2:5),dtca];
% samplevm=[sresult(1:quhang,6)];
% sampleS=[sresult(1:quhang,7)];
% save ('data3.mat','sampleT_set','samplevm','sampleS');
% scatter best
% T_set=sampleT_set(1,:);vm=samplevm(1);
[pT,t]=Tv2p(T_set,vm);
figure;scatter(t,pT,'fill')