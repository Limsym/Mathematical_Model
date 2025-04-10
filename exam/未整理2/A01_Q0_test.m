clear,clc
load('A01','t','T')
%% k的连续分区夹逼拟合
tic
neb=2;          % Num_External_Boundary
eb=[1 747];     % External_Boundary
nib=4;          % Num_Internal_Boundary
sl=50;          % Step_Length
% for i=1:nib
%     iib(i)=eb(1)+sl*(i);            % Min_Internal_Boundary
%     aib(i)=eb(2)-sl*(nib-(i-1));	% Max_Internal_Boundary
% end
iib=[25 50 500 600];
aib=[100 150 600 700];
time=0;
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
                    ib(4)	eb(2)];         % Area
                [Kt,pTt,Rt]=Ar2K(A);
                time=time+1;
                if mod(time,50)==0
                    disp(time);
                end
                if time==1
                    K=Kt;pT=pTt;R=Rt;
                    bib=ib;             % Best_Internal_Boundary
                elseif Rt>R
                    K=Kt;pT=pTt;R=Rt;
                    bib=ib;
                end
            end
        end
    end
end
iib=floor(bib-sl*0.5);
aib=ceil(bib+sl*0.5);
bib(3:4,:)=[iib;aib]
time,R
vm=70;[ys,re]=happier(vm,pT);re
figure;scatter(t(39:746), T(39:746),5,'r','filled');xlabel('时间(s)');ylabel('T(℃)');hold on;grid on;
scatter(t(39:746),pT(39:746),5,'b','filled');xlabel('时间(s)');ylabel('T(℃)');legend('实验曲线','拟合曲线');
BA=[eb(1) bib(1)
    bib(1) bib(2)
    bib(2) bib(3)
    bib(3) bib(4)
    bib(4) eb(2)];	% Best_Area
toc
%%
sure=0;
if sure==1
    save('K.mat','K');
end