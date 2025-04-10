clear; clc;
load K;
T_set=[182 203 237 254 25];
% maxv = 77.7067
%% 未知区
vmin=65;vmax=100;
buchang=[0.1,0.05,0.025,0.00125,0.0001];
for times=1:size(buchang,2)
    bc=buchang(times);
    i=1;
    for vm=vmin:bc:vmax; % 设定v值 m/min
        clear pT;clear ys
        clear V;clear I
        [ys]=happier(vm,Tv2p(T_set,vm));
        if ys==1
            vv(i)=vm;
            i=i+1;
        end
    end
    %%
    [V,I]=sort(vv,'descend');
    %  scatter(t(39:746),pT(39:746),5,'r','filled');xlabel('时间(s)');ylabel('T_{air}(℃)');hold on;grid on
    vmin=min(V(1:50)-1*bc);
    vmax=max(V(1:50)+1*bc);
end
maxv=V(1,1)
[pT,t]=Tv2p(T_set,maxv);
figure
scatter(t,pT,5,'r','filled');xlabel('时间(s)');ylabel('T(℃)');hold on;grid on