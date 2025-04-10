clear,clc
load('A01','t','T')
%% k的连续分区夹逼拟合
tic
neb=2;          % Num_External_Boundary
eb=[1 747];     % External_Boundary
nib=4;          % Num_Internal_Boundary
% for i=1:nib
%     iib(i)=eb(1)+sl*(i);            % Min_Internal_Boundary
%     aib(i)=eb(2)-sl*(nib-(i-1));    % Max_Internal_Boundary
% end
iib=[25 50 500 600];
aib=[100 150 600 700];
time2=1;
%% 开始遍历
time=0;
sl=fix(50/2^(3));          % Step_Length
for ib1=iib(1):sl:aib(1)
    for ib2=iib(2):sl:aib(2)
        if ib2<=ib1
            ib2=ib1+sl;
        end
        for ib3=iib(3):sl:aib(3)
            if ib3<=ib2
                ib3=ib2+sl;
            end
            for ib4=iib(4):sl:aib(4)
                if ib4<=ib3
                    ib4=ib3+sl;
                end
                ib=[ib1,ib2,ib3,ib4];
                A=[eb(1) 	ib(1)
                    ib(1)	ib(2)
                    ib(2)	ib(3)
                    ib(3) 	ib(4)
                    ib(4)	eb(2)];         % 构建 Area
                [Kt,pTt,Rt]=Ar2K(A);
                if time==0
                    K=Kt;pT=pTt;R=Rt;
                    bib=ib;                 % Best_Internal_Boundary
                    bA=A;
                elseif Rt>R
                    K=Kt;pT=pTt;R=Rt;
                    bib=ib;
                    bA=A;
                end
                time=time+1;
                if mod(time,50)==0 disp(time);end
            end
        end
    end
end
iib=floor(bib-sl*0.5);     % 调整下次夹逼的下限
if iib(1)==0 iib(1)=eb(1)+1;end
if time2==1
    aib=ceil(bib+sl*0.5);          % 调整下次夹逼的上限
end
Bib(2*time2-1:2*time2,:)=[iib;aib]      % 历次夹逼的范围
time2=time2+1;
time,R
vm=70;%[ys,re]=happier(vm,pT);re
figure;scatter(t(39:746), T(39:746),5,'r','filled');xlabel('时间(s)');ylabel('T(℃)');hold on;grid on;
scatter(t(39:746),pT(39:746),5,'b','filled');xlabel('时间(s)');ylabel('T(℃)');legend('实验曲线','拟合曲线');
% BA=[eb(1) bib(1)
%     bib(1) bib(2)
%     bib(2) bib(3)
%     bib(3) bib(4)
%     bib(4) eb(2)];	% Best_Area 最佳的分区方案
%% 是否保留结果：K（较优）
sure=0;
if sure==1
    save('K.mat','K');
end
toc