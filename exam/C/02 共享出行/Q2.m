%% Q2
cd 'D:\Program Files\Polyspace\R2021a\bin\win64\C\02 共享出行'
clear;clc;tic
load('Q1');load('epass','pass')
n_p=size(result,1);
j=1;k=1;
for i=1:n_p
    if result(i,7)~=0
        p1(j,:)=[result(i,:) pass(i,3:4)];
        p11(j,:)=[i,1,result(i,4)];
        j=j+1;
    elseif result(i,7)==0
        p2(k,:)=[result(i,:) pass(i,3:4)];
        p22(k,:)=[i,0,result(i,4)];
        k=k+1;
    end
end
r0 = 0.004 ; dr = r0 ; v = 0 ; rmax = [25 40]*10/60/111;
n2=size(p2,1);toc
%% 
tic
time = 0;
while v < n2
    v = v+1;
    nr = 0;
    done = 0;
    while done==0
        if mod(time,20);disp('正在分配剩余乘客序号 及 次数');disp(v);disp(time);end
        clear angle;clear dist;
        r = r0 + nr * dr ;
        w = p2(v,3) - r; e = p2(v,3) + r; s = p2(v,2) - r; n = p2(v,2) + r;
        [a,~] = find( p1(:,2)<=n & p1(:,2)>=s & p1(:,3)<=e & p1(:,3)>=w & p11(:,2)==1);
        na=size(a,1);
        if na>=1
            for i=1:na
                angle(i)=acos(dot([p1(a(i),12)-p1(a(i),3),p1(a(i),11)-p1(a(i),2)], ... 
                    [p2(v,12)-p2(v,3),p2(v,11)-p2(v,2)])/( ...
                    norm([p1(a(i),12)-p1(a(i),3),p1(a(i),11)-p1(a(i),2)])* ...
                    norm([p2(v,12)-p2(v,3),p2(v,11)-p2(v,2)])) ) *180/pi;
                if angle(i)>30 || angle(i)<0
                    angle(i)=inf;
                end
            end
            [~,ind]=find(angle<=30 & angle>=0);
            na=size(ind,2);
            if na>=1                               % 已经发现顺风乘客
%                 angle(1)=min(angle);
                lin=p1(a(ind),:);
                % 距离更短 p1(a(indd),:)
                for i=1:na
                    dist(i)=l2s([p2(v,2:3)],[p1(a(ind(i)),2:3)]);
                end
                [~,indd]=find(dist==min(dist));
%                 indd=ind(indd);
                if size(indd,2)==1
                    p11(a(ind(indd)),2:3)=[2 p22(v)];
                    p22(v,2:3)=[1 p11(a(ind(indd)))];
                else disp('WARNING!!! ERROR')
                    pause('on')
                    return
                end
            else na=0;
            end
            done=1;
        else if p2(v,3)==1 && r>=rmax(1)
                done=1;
            elseif p2(v,3)==0 && r>=rmax(2)
                done=1;
            end
        end
        nr = nr + 1;
        time = time+1;
    end
end
n_p_wind=size(find(p11(:,2)==2),1);
n_t_wind=size(find(p22(:,2)==1),1);
disp('搭上顺风车的乘客数量为');disp(n_p_wind)
disp('搭上顺风车的司机数量为');disp(n_t_wind)
disp('搭上顺风车的概率为');disp(n_t_wind/size(p22,1))
toc
% fix p22
for i=1:size(p22,1)
    if p22(i,2)==0 
        p22(i,3)=0;
    end
end
%% 输出结果
time=0;
% 顺风车乘客序号 出发地 目的地 拼单乘客序号 出发地 目的地 乘客距离 司机 位置
for j=1:size(p22,1)
    time=time+1;
    if p22(j,2)==1                                  % 打上车了
        y=[p22(j,1) pass(p22(j,1),:) p22(j,3) pass(p22(j,3),:) ...
            l2s([pass(p22(j,1),1:2)],[pass(p22(j,3),1:2)]) result(p22(j,3),5:7)];
        if time==1
            result2=y;
        else result2=[result2;y];
        end
    elseif p22(j,2)==0               % 没打上车
        y=[p22(j,1) pass(p22(j,1),:) zeros(1,9)];
        if time==1
            result2=y;
        else
            result2=[result2;y];
        end
    end
end
% save('Q2','p11','p22','result2')