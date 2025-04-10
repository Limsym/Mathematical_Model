tic;clear;clc
load('B01','C0','c','dig','dist','m','M','p','stay','T','W','walk','whe')
bs=[1 2 3];
time=0;x=0;
CC=zeros(1,2);nn=1;record(:,:,2)=zeros(2,5);
for aaa=1:1*10^4
    for i=1:30
        x=rand(1);
        if x<=6/30 && i>10
            whe(i)=3;               % 生成天气
        elseif x>=1-9/30
            whe(i)=1;
        else whe(i)=2;
        end
    end
    time=time+1;
    [ds]=crde2(x);
    % 开始求解
    day=1;ys=1;
    for hang=1:size(ds,1)
        if ds(hang,3)==0
            C(hang)=0;
            dC(hang)=0;
            dN1(hang,:)=0;
            dN2(hang,:)=0;
            N(hang,:)=[0 0];
        else [day,ncs,dN,dCt,report]=BetaGo3(ds(hang,3),day,whe);
            if report~=[1 1] ys=0;end
            dN1(hang,:)=dN;
            day=day+1;          % 下次行动的起始时间
            if ds(hang,3) == 12
                N0=[ds(1,1),ds(1,2)];
                dC(hang)=-sum (( p .* ds(hang,1:2) ) * bs(1));
            elseif ds(hang,3)>30 && ds(hang,3)<40   % 经村庄旅行（含返程）
                dN2(hang,:)=ds(hang,1:2);
                dC(hang)=-sum (( p .* ds(hang,1:2) ) * bs(2));
            elseif ds(hang,3)>40 || ds(hang,3)==23                  % 采矿
                if day+ds(hang,4)>30
                    ys=0;
                    break
                end
                dN1(hang,:)=dN;
                [dN2m]=Mine(day,ds(hang,4),ds(hang,5));
                dN2(hang,:)=dN2m;
                day=day+ds(hang,4);
                dC(hang)=W*ds(hang,5);
            else report=[hang,ds(hang,3)],ys=0      % disp('ERROR2')
            end
        end
        if hang==1
            C(1,hang)=C0+dC(1,hang);
            N=N0+dN;
        else C(1,hang)=C(1,hang-1)+dC(1,hang);
            for i=1:2
                N(hang,i)=N(hang-1,i)+dN1(hang,i)+dN2(hang,i);
            end
        end
        if n2we(N(hang,:)) ~= 1
            ys=0;
            %disp('超重行');disp(hang)
            break
        end
    end
    if min(N)<0
        ys=0;
    end
    if size(N,1)==6
        if N(6,1)~=N(6,2) && N(6,1)~=0
            ys=0;
        end
    end
    if C(size(C,2))>11000 %|| C(size(C,2))<10000
        ys=0;
    end
    if mod(ds(hang,3),10)==4
        C(hang) = C(hang) + sum (( p .* N(hang,1:2) ) * bs(1) );	% 待计算
        N(hang) = 0;
    end
    if ys==1
        if time < 100
            record(:,:,time)=ds;    % record2(:,:,time)=ds;
            CC(time,:)=C(:);
        elseif C(2) > CC(nn,2) 
            record(:,:,nn)=ds;
            CC(nn,:)=C(:);
        end
        [CC,index]=sortrows(CC,-2);
        record=record(:,:,index);
        [nn,mm]=size(CC);
        if nn>100 nn=100;end
    end
end;toc