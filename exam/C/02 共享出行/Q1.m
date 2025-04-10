%% Q1
cd 'D:\Program Files\Polyspace\R2021a\bin\win64\C\02 共享出行'
clear;clc
pass0=importdata('pass.txt');
taxi=importdata('taxi.txt');
n=size(pass0,1);
v_u=25;  v_s=40;  % 公里/小时，郊区均速
t_r=2;   t_w=10;  % 分钟，候车时间上限
% 检验并修正数据
p1=pass0(:,1:2);p2=pass0(:,3:4);
pass=pass0;
for i=1:n
    if pass0(i,1)==pass0(i,3) && pass0(i,2)==pass0(i,4)
        pass(i,:)=[];
    end
end
% epass=pass(:,1:4);    save('epass')
%% 绘制起始点与目的地 pass
figure
scatter(pass0(:,2),pass0(:,1),1.5,'fill','b');hold on;
scatter(pass0(:,4),pass0(:,3),1.5,'fill','r');grid on;
legend('起始点','目的地');
xlabel('经度(度)');ylabel('纬度(度)');
set(gca,'xTick',-74.4:0.1:-73.4);set(gca,'yTick',40.5:0.1:41.2);
%% 划定市区
% 绘制乘客、出租车位置
figure
c1=scatter(pass0(:,2),pass0(:,1),1.5,'fill','b');hold on;
c2=scatter(taxi(:,2),taxi(:,1),1.5,'fill','r');
legend('乘客位置','出租车位置');
xlabel('经度(度)');ylabel('纬度(度)');
set(gca,'child',[c1 c2])
set(gca,'xTick',-74.2:0.1:-73.4);set(gca,'yTick',40.5:0.1:41.2);grid on;
% 然后划定市区
bw0=mean([-74.009109 -74.015725]);                  % 西边界
be0=mean([-73.928465 -73.928908]);                  % 东边界
fb=-0.008;bw=-74.029;be=be0+fb+0.009;           	% 边界修正
a0=(40.778714-40.778117)/(-73.977852-(-73.978328)); % 南北边界斜率
fa=1+0.05;a=a0*fa;                                  % 斜率修正
b1=40.69-a*(-74)+0.005-0.007;                       % 下界
b2=40.78-a*(-74)-0.005+0.008;                       % 上界
y1=a*bw+b1;y2=a*be+b1;                              % 下界端点
y3=a*bw+b2;y4=a*be+b2;                              % 上界端点
% 现在，绘制市区界限
plot([bw bw],[y3 y1],'-.','LineWidth',3,'Color',[0.29,0.88,0.29]);hold on;
plot([be be],[y4 y2],'-.','LineWidth',3,'Color',[0.29,0.88,0.29]);
plot([bw be],[y1 y2],'-.','LineWidth',3,'Color',[0.29,0.88,0.29]);
plot([bw be],[y3 y4],'-.','LineWidth',3,'Color',[0.29,0.88,0.29]);
legend('乘客位置','出租车位置','市区边界');
axis([-74.1 -73.85 40.625 40.9]);           % set(gca,'xTick',-74.1:0.05:-73.85);set(gca,'yTick',40.625:0.05:40.9);
%% 计算市区人数
n_p=size(pass,1);
for i=1:n_p
   if  pass(i,2)>=bw && pass(i,2)<=be && pass(i,1)>=a*pass(i,2)+b1 && pass(i,1)<=a*pass(i,2)+b2
       pass(i,5)=1;
   else pass(i,5)=0;
   end
end
n_p_urban=sum(pass(:,5));
l_p_urban=find(pass(:,5)==1);
figure;scatter(pass(l_p_urban,2),pass(l_p_urban,1),1)
% 以及 市区出租车数量
n_t=size(taxi,1);
for i=1:n_t
   if  taxi(i,2)>=bw && taxi(i,2)<=be && taxi(i,1)>=a*taxi(i,2)+b1 && taxi(i,1)<=a*taxi(i,2)+b2
       taxi(i,3)=1;
   else taxi(i,3)=0;
   end
end
n_t_urban=sum(taxi(:,3));
l_t_urban=find(taxi(:,3)==1);
figure;scatter(taxi(l_t_urban,2),taxi(l_t_urban,1),1)
%% 划区求 乘客、出租车 分布
n_a=5;
n_p=size(pass,1);
n_t=size(taxi,1);
for i=1:n_p
   if  pass(i,2)>=bw && pass(i,2)<=be && pass(i,1)>=a*pass(i,2)+b1 && pass(i,1)<=a*pass(i,2)+b2
       pass(i,5)=1;
   else pass(i,5)=0;
   end
end
n_p_urban=sum(pass(:,5));
l_p_urban=find(pass(:,5)==1);
figure;scatter(pass(l_p_urban,2),pass(l_p_urban,1),1)
%% 在市区的出租车数量
n_t=size(taxi,1);
for i=1:n_t
   if  taxi(i,2)>=bw && taxi(i,2)<=be && taxi(i,1)>=a*taxi(i,2)+b1 && taxi(i,1)<=a*taxi(i,2)+b2
       taxi(i,3)=1;
   else taxi(i,3)=0;
   end
end
n_t_urban=sum(taxi(:,3));
l_t_urban=find(taxi(:,3)==1);
figure;scatter(taxi(l_t_urban,2),taxi(l_t_urban,1),1)
if size(pass,2)==5
    pass=[pass zeros(n_p,3)];
    taxi=[taxi zeros(n_t,3)];
end
d1=(be-bw)/n_a;
d2=(b1-b2)/n_a;
index=1;
index_h=0;
index_l=0;
p{n_a^2}=[0 0 0];
t{n_a^2}=[0 0 0];
op=[0,1,0,1];
for i=bw:d1:be-d1
    index_h=index_h+1;
    bwa=i;
    bea=bwa+d1;
    for j=b2:d2:b1-d2
        index_l=round((j-b2)/d2+1);
        b2a=j;
        b1a=b2a+d2;
        k2=1;
        for k=1:n_p
            if  pass(k,2)>bwa && pass(k,2)<=bea && pass(k,1)>a*pass(k,2)+b1a && pass(k,1)<=a*pass(k,2)+b2a
                pass(k,6)=index_h;
                pass(k,7)=index_l;
                pass(k,8)=index;
                if isequal(p{index},[0 0 0])
                    p{index}=[k k2 pass(k,1) pass(k,2)];
                else p{index}=[p{index};k k2 pass(k,1) pass(k,2)];
                end
                k2=k2+1;
            end
        end
        k2=1;
        for k=1:n_t
            if  taxi(k,2)>bwa && taxi(k,2)<=bea && taxi(k,1)>a*taxi(k,2)+b1a && taxi(k,1)<=a*taxi(k,2)+b2a
                taxi(k,3)=index_h;
                taxi(k,4)=index_l;
                taxi(k,5)=index;
                if isequal(t{index},[0 0 0])
                    t{index}=[k k2 taxi(k,1) taxi(k,2)];
                else t{index}=[t{index};k k2 taxi(k,1) taxi(k,2)];
                end
                k2=k2+1;
            end
        end
        ar_p(index_h,index_l)=size(find(pass(:,8)==index),1);
        ar_t(index_h,index_l)=size(find(taxi(:,5)==index),1);
        if index<n_a^2
            index=index+1;
        end
    end
end
% 检验
sum(sum(ar_t));sum(sum(ar_p));
n_A_ar_p=max(max(ar_p));
n_A_ar_t=max(max(ar_t));
k=1;
%% 贪心算法 求市区
tic
op=[0,1,0,1];
time=0;
for i=1:n_a
    for j=1:n_a
        k=(i-1)*n_a+j;
        ar_1=min([ar_p(i,j),ar_t(i,j)-0.1]);
        ar_2=max([ar_p(i,j),ar_t(i,j)-0.1]);
        if op(2)==1
            if ar_1>8 || ar_2>8     % && size(p{k},2)>4   % 保存数据下次不算
                [p{k},t{k},minS]=dtbt2(p{k},t{k},1);
                S{k}=[minS];
            end
        end
        if mod(k,1)==0
            disp(k);
        end
    end
end
toc
%% 评价 市区匹配效果
if op(2)==1;
    n_matching_urban=0;
    for i=1:n_a^2
        n_matching_urban = n_matching_urban + size(find(S{i}>0),1);
    end
    disp('市区匹配成功人数为');disp(n_matching_urban);disp('市区出行人数为');disp(n_p_urban);
    lv=n_matching_urban/n_p_urban;disp('匹配成功率为');disp(lv);
end
%% 绘制 市区匹配方案
paint(1);
for i=1:n_a^2
    if isempty(p(i))==0 && size(p{i},2)==5
        n_test=size(p{i},1);
        for j=1:n_test
            if p{i}(j,5)~=0
                x=[p{i}(j,4) t{i}(p{i}(j,5),4)];
                y=[p{i}(j,3) t{i}(p{i}(j,5),3)];
                plot(x,y,'-.','color','[0.2 0.3 0.8]');hold on
                legend('乘客位置','出租车位置')
            end
        end
    end
    disp(i);
end
%% 统计
n_p_urban=size(find(pass(:,5)==1),1);
n_t_urban=size(find(taxi(:,3)==1),1);
n_p_suburb=size(find(pass(:,5)==0),1);
n_t_suburb=size(find(taxi(:,3)==0),1);
%% ***** 郊区匹配 ******
n_a=5;
bws=min([min(pass(:,2)) min(taxi(:,2))]);          	% 西边界
bes=max([max(pass(:,2)) max(taxi(:,2))]);          	% 东边界
bss=min([min(pass(:,1)) min(taxi(:,1))]);         	% 下界
bns=max([max(pass(:,1)) max(taxi(:,1))]);         	% 上界
%% 在郊区的出租车数量
djs=(bes-bws)/n_a;
dws=(bss-bns)/n_a;
index=1;
index_h=0;
index_l=0;
ps{n_a^2}=[0 0 0];
ts{n_a^2}=[0 0 0];
op(2,:)=[0,1,0,1];
for i=bws:djs:bes-djs
    index_h=index_h+1;
    bwa=i;
    bea=bwa+djs;
    for j=bns:dws:bss-dws
        index_l=round((j-bns)/dws+1);
        b2a=j;
        b1a=b2a+dws;
        k2=1;
        for k=1:n_p
            if  pass(k,5)==0 && pass(k,2)>=bwa && pass(k,2)<=bea &&...
                    pass(k,1)>=b1a && pass(k,1)<=b2a
                pass(k,9)=index_h;
                pass(k,10)=index_l;
                pass(k,11)=index;
                if isequal(ps{index},[0 0 0])
                    ps{index}=[k k2 pass(k,1) pass(k,2)];
                else ps{index}=[ps{index};k k2 pass(k,1) pass(k,2)];
                end
                k2=k2+1;
            end
        end
        k2=1;
        for k=1:n_t
            if taxi(k,3)==0 && taxi(k,2)>=bwa && taxi(k,2)<=bea && ...
                    taxi(k,1)>=b1a && taxi(k,1)<=b2a
                if isequal(ts{index},[0 0 0])
                    ts{index}=[k k2 taxi(k,1) taxi(k,2)];
                else ts{index}=[ts{index};k k2 taxi(k,1) taxi(k,2)];
                end
                k2=k2+1;
            end
        end
        if index<n_a^2
            index=index+1;
        end
    end
end
% 检验
n_ps=0;n_ts=0;
for i=1:n_a^2
    n_ps=n_ps+size((ps{i}),1);
    n_ts=n_ts+size((ts{i}),1);
end
%% 郊区匹配区块
tic
op=[0,1,0,1];
time=0;
for i=1:n_a
    for j=1:n_a
        k=(i-1)*n_a+j;
        [ps{k},ts{k},minSs]=dtbt2(ps{k},ts{k},2);
        Ss{k}=[minSs];
        if mod(k,1)==0;disp('已分配区块数为');disp(k);end
    end
end
toc
% 匹配成功总数
n_matching_suburb=0;
for i=1:n_a^2
    n_matching_suburb = n_matching_suburb + size(find(Ss{i}>0),1);
end
disp('郊区匹配成功人数为');disp(n_matching_suburb);disp('郊区出行人数为');disp(n_p_suburb)
lv=n_matching_suburb/n_p_suburb;disp('匹配成功率为');disp(lv);
%% 绘制郊区分配
figure(2);
paint(1);hold on
for i=1:n_a^2
    if isempty(ps(i))==0 && size(ps{i},2)==5
        n_tests=size(ps{i},1);
        for j=1:n_tests
            if ps{i}(j,5)~=0
                xs=[ps{i}(j,4) ts{i}(ps{i}(j,5),4)];
                ys=[ps{i}(j,3) ts{i}(ps{i}(j,5),3)];
                plot(xs,ys,'-.','color','[0.25 0.5 0.125]');hold on
                legend('乘客位置','出租车位置','市区匹配路线','郊区匹配路线')
            end
        end
    end
    disp('已绘区块数为');disp(i);
end
%% 随机取出 10 人
% fix p
for i=1:n_a;
    if size(p{i},2)<5
        [n,m]=size(p{i});
        if m==0
            p{i}=zeros(1,5);
        else p{i}(:,5)=zeros(n,1);
        end
    end
end
% fix ps
for i=1:n_a;
    if size(ps{i},2)<5
        [n,m]=size(ps{i});
        if m==0
            ps{i}=zeros(1,5);
        else ps{i}(:,5)=zeros(n,1);
        end
    end
end
v_u=25;v_s=40;
% 人号 纬度 经度 在市区 车号 纬度 经度 在市区 距离 等待时间
time=1;
for j=1:n_p
%     j=round(rand(1)*n_p);
    if pass(j,5)==1                                 % 市区乘客
        p_h=find(p{pass(j,8)}(:,1)==j);             % ta 在 p 的索引
        if p{pass(j,8)}(p_h,5)~=0                   % 打上车了
            t_index=t{pass(j,8)}(p{pass(j,8)}(p_h,5),1);
            S_index=S{pass(j,8)}(p_h,1);
            if time==1
                result=[j pass(j,1:2) 1 t_index t{pass(j,8)}(p{pass(j,8)}(p_h,5),3:4) 1 ...
                    S_index S_index/v_u ];
            else result=[result;j pass(j,1:2) 1 t_index t{pass(j,8)}(p{pass(j,8)}(p_h,5),3:4) 1 ...
                    S_index S_index/v_u ];
            end
        elseif p{pass(j,8)}(p_h,5)==0               % 没打上车
            if time==1
                result=[j pass(j,1:2) 1 t_index zeros(1,5)];
            else
                result=[result;j pass(j,1:2) 1 t_index zeros(1,5)];
            end 
        end
    elseif pass(j,5)==0                             % 郊区乘客
        p_h=find(ps{pass(j,11)}(:,1)==j);
        if ps{pass(j,11)}(p_h,5)~=0
            t_index=ts{pass(j,11)}(ps{pass(j,11)}(p_h,5),1);
            S_index=Ss{pass(j,11)}(p_h,1);
            if time==1
                result=[j pass(j,1:2) 0 t_index t{pass(j,11)}(ps{pass(j,11)}(p_h,5),3:4) 0 ...
                    S_index S_index/v_u ];
            else result=[result;j pass(j,1:2) 0 t_index t{pass(j,11)}(ps{pass(j,11)}(p_h,5),3:4) 0 ...
                    S_index S_index/v_u ];
            end
        else if time==1 
                result=[j pass(j,1:2) 0 zeros(1,6)];
            else result=[result;j pass(j,1:2) 0 zeros(1,6)];
            end
        end
    end
    time=time+1;
end
%% 保存数据
% save('Q1','p','t','S','ps','ts','Ss','result')