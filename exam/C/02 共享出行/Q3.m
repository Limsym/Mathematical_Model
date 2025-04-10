%% Q3
dbstop if error
cd 'D:\Program Files\Polyspace\R2021a\bin\win64\C\02 共享出行'
% 收集研究对象数据
clear;clc;load('Q1','p','t');load('epass','pass')
dt=1/60/60/2;                           % h
tmax=60/60;                             % h
nd=tmax/dt+1;                           % 有 nd 时间间隔
for area=1:25;                          % 仅以市中心第 7 区为研究对象
    data0={p{area}(:,1:4);t{area}(:,1:4)};	% 导入市中心第 7 区的数据
    if data0{1}(1,1)==0
        continue
    end
    for i=1:size(data0{1},1)
        data0{1}(i,5:6)=pass(data0{1}(i,1),3:4);    % 导入乘客的目的地位置
    end
    data0{1,2}={'乘客信息'};data0{2,2}={'出租车信息'};
    % bd=[min(data(:,4)) max(data(:,4)) min(data(:,3)) max(data(:,3))];
    n=round([size(data0{1},1) size(data0{2},1)]*tmax/1);    % 参与模拟的乘客、出租车数量
    data=zeros(nd,8);                                       % 生成初始数据
    for x=1:nd
        qu(x,:)=round(x*n/nd);
    end
    % dqu=qu(2:nd,:)-qu(1:nd-1,:);
    for x=1:nd-1
        if qu(x,1)~=qu(x+1,1)
            data(x,1:6)=data0{1}(qu(x+1,1),:);
        end
        if qu(x,2)~=qu(x+1,2)
            data(x,7:10)=data0{2}(qu(x+1,2),:);
        end
    end
    %
    clear pool
    tic;
    dp0=zeros(1,6);
    pool{1}=zeros(1,7);
    pool{2}=zeros(1,4);
    pool{3}=zeros(1,12);
    time=0;
    while time<=nd-1
        time=time+1;
        if mod(time,2*60*5)==0;disp('匹配时间（min），匹配区'),disp(time/2/60),disp(area);end
        if data(time,1)~=0
            dp1=[0 data(time,1:6)];
            pool{1}=[pool{1};dp1];
        end
        pool{1}(:,1)=pool{1}(:,1)+dt*60;
        n1=size(pool{1},1);
        if data(time,7)~=0
            dp2=[data(time,7:10)];
            pool{2}=[pool{2};dp2];
        end
        if data(time,1)~=0 || (data(time,7)~=0 && n1>=2)                              % 如果池新增个体
            n2=size(pool{2},1);
            clear tw;clear tr
            for i=1:n1
                for j=1:n2
                    tr(i,j)=pool{1}(i,1);                                     	% min
                    if tr(i,j)>2
                        tr(i,j)=inf;
                    end
                    tw(i,j)=(l2s([pool{1}(i,4:5)],[pool{2}(j,3:4)])/25*60+tr(i,j));	% min
                end
            end
            tw(1,:)=inf;tw(:,1)=inf;
            if min(min(tw))<=10
                [indi,indj]=find(tw==min(min(tw)));
                [h1,~]=find(data(:,1)==pool{1}(indi,2));
                % [h2,~]=find(data(:,8)==pool1(indj,2));
                data(h1,11:16)=[tw(indi,indj),tr(indi,indj),pool{2}(indj,1:4)];
                pool{3}=[pool{1,3}(:,:);tw(indi,indj),pool{1}(indi,:),pool{2}(indj,:)];
                pool{1}(indi,:)=[];
                pool{2}(indj,:)=[];
            end
        end
    end
    n_patched=[size(pool{3},1)-1,size(pool{3},1)-1,size(pool{1},1)-1, ...
        size(pool{2},1)-1,(size(pool{3},1)-1)/size(find(data(:,1)~=0),1)*100];
    time_re=[max(pool{1,3}(:,1)),sum(pool{1,3}(:,1))];
    disp('最长等待时间（min），累计等待时间（min）分别为');         disp(time_re);
    disp('匹配成功人数、车数，未匹配人数、车数，匹配成功率（%）分别为'); disp(n_patched);
    toc;
    re{1,area}=pool{3};re{2,area}=[n_patched,time_re];
end