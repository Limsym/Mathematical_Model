tic;clear;clc
load('B01','C0','c','dig','dist','m','M','p','stay','T','W','walk','whe')
bs=[1 2 3];
time=0;none=0;
re2=7;C2=zeros(1,re2);nn=1;             % record(:,:,2)=zeros(6,5);
for aaa=1:1.0*10^4
    time=time+1;
    [ds]=crde(none);
    day=1;ys=1;
    keep = 100 ;    % 结果（最多）保留最佳的 keep 组
    % 开始求解
    for hang=1:size(ds,1)                                           % 计算方案的第 hang 行
        if ds(hang,3)==0
            dC(hang)=0;C(hang)=0;dN1(hang,:)=0;dN2(hang,:)=0;N(hang,:)=[0 0];
        else 
            if ds(hang,3) == 12
                N0=[ds(1,1),ds(1,2)];
                dC(hang)=-sum (( p .* ds(hang,1:2) ) * bs(1));
                [day,ncs,dN,dCt,report]=BetaGo(ds(hang,3),day);     % 第 day 天抵达目标地点
                dN1(hang,:)=dN;
                day=day+1;
            elseif ds(hang,3)>20 && ds(hang,3)<30 && mod(ds(hang,3),10)~=4 % 经村庄旅行（不含返程）
                [day,ncs,dN,dCt,report]=BetaGo(ds(hang,3),day);     % 第 day 天抵达目标地点
                dN1(hang,:)=dN;
                dN2(hang,:)=ds(hang,1:2);
                dC(hang)=-sum (( p .* ds(hang,1:2) ) * bs(2));
                day=day+1;
            elseif ds(hang,3)>30                                 	% 采矿
                [dN_M,day_M]=Mine(day,ds(hang,4),ds(hang,5),whe);
                dN2(hang,:)=dN_M;
                day=day_M+1;                                     	% 准备出发前往村庄的那一天
                [day,ncs,dN,dCt,report]=BetaGo(ds(hang,3),day);     % 第 day 天抵达目标地点
                dN1(hang,:)=dN;
                day=day+1;
                dC(hang)=W*ds(hang,5);
            elseif mod(ds(hang,3),10)==4
                [day,ncs,dN,dCt,report]=BetaGo(ds(hang,3),day);     % 第 day 天抵达目标地点
                dN1(hang,:)=dN;
                dN2(hang,:)=ds(hang,1:2);
                dC(hang)=-sum (( p .* ds(hang,1:2) ) * bs(2));
            else report=[hang,ds(hang,3)],ys=0                      % disp('ERROR2')
            end
        end
        if hang==1
            C(1,hang)=C0+dC(1,hang);
            N=N0+dN;
        else C(1,hang)=C(1,hang-1)+dC(1,hang);
            N(hang,:)=N(hang-1,:)+dN1(hang,:)+dN2(hang,:);
        end
        if n2we(N(hang,:))==0 ys=0;break                       % disp('超重行'),disp(hang)
         elseif min(min(N))<0 ys=0;break
        elseif min(C)<0 ys=0;break
        end
    end
%     if size(N,1)==6
%         if N(6,1)~=N(6,2) && N(6,1)~=0    % 恰好耗尽所有资源
%             ys=0;
%         end
%     end
    if mod(ds(hang,3),10) == 4                                      % 该步骤走向终点
        C(hang) = C(hang) + sum (( p .* N(hang,1:2) ) * bs(1)/2 );	% 
        N(hang) = 0;
    end
    if ys==1
        if size(C2,1) < keep
            result(:,:,size(C2,1)+1)=[ds,C',dC',N,dN1,dN2];
            C2(size(C2,1)+1,:)=[C day];
        elseif C(6) > C2(keep,6) && C(6)>=10000
            result(:,:,keep)=[ds,C',dC',N,dN1,dN2];
         	C2(keep,:)=[C day];
        end
        [C2,index]=sortrows(C2,-6);                                 % 按照第 6 列降序排列
        result=result(:,:,index);
    end
end;toc