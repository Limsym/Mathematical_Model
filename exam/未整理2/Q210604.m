clear;clc;tic
load K;
load data2;
[n,m]=size(samplevm);dt=0.5;
for hang=1:n
    T_set=sampleT_set(hang,:);
    vm=samplevm(hang);  % m/s
    [pT,t]=Tv2p(T_set,vm);
    %%
    clear h;clear phT;
    bian=25;xi=5;xiao=30.5;n_bian=2;n_xiao=11;n_xi=n_xiao-1;length=bian*n_bian+xiao*n_xiao+xi*n_xi;         % 435.5 cm
    dt=0.5;                                         % /s
    v=vm/60;dot=fix(length/(v*dt)+1);
    for i=1:dot
        h(i)=abs(pT(i)-217);
    end
    h=h';
    [~,index]=sort(h);
    sh=h(index,:);
    sh=sh';
    clear h,clear sh
    if index(1)<=index(2)
        l=index(1);
        r=index(2);
    else l=index(2);
        r=index(1);
    end
    clear index
    for i=1:dot
        if pT(i)==max(pT)
            tmax=t(i);
        end
    end
    PC2=((t(r)-t(l))/2-tmax)^2;
    PC2=10^10-PC2;
    %     for i=l:r
    %         newh(i)=newh(l+i-1);
    %     end
    %     [dtca,dot2]=size(newh);
    dot2=r-l+1;
    if mod(dot2,2)==0
        for i=l:dot2/2
            dy2(i)=(pT(l+i-1)-pT(r-i+1))^2;
        end
    elseif  mod(dot2,2)==1
        for i=1:(dot2-1)/2
            dy2(i)=(pT(l+i-1)-pT(r-i+1))^2;
        end
    end
    dY2=dy2.^dy2;
    A2=sum(dY2);
    A2=10^10-A2;
    if hang==1
        result=[hang n-hang+1  A2];
    else result=[result;hang n-hang+1  A2];
    end
end
toc
%%
result2=result(:,2:3);
rresult2 = mapminmax(result2', 60, 100)';
rresult4 = sum(rresult2'); 
rresult4 = rresult4';
rresult=[result(:,1) rresult4];
[~,index]=sort(rresult(:,2),'descend');
sresult=rresult(index,:);
%%
hang=55;
SCORE=rresult(hang,2)
T_set=sampleT_set(hang,:)
vm=samplevm(hang)
figure
[pT,t]=Tv2p(T_set,vm);
scatter(t, pT,5,'r','filled');;grid on;xlabel('时间(s)');ylabel('T(℃)');