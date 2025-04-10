%% Q1
clear;clc
pass0=importdata('pass.txt');
taxi=importdata('taxi.txt');
n=size(pass0,1);
% 检验修改数据
p1=pass0(:,1:2);p2=pass0(:,3:4);
pass=pass0;
for i=1:n
    if pass0(i,1)==pass0(i,3) && pass0(i,2)==pass0(i,4)
        pass(i,:)=[];
    end
end
% epass=pass(:,1:4);
% save('epass')
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
be0=mean([-73.928465 -73.928908])+0.009;            % 东边界
fb=-0.008;bw=-74.029;be=be0+fb;                     % 边界修正
a0=(40.778714-40.778117)/(-73.977852-(-73.978328)); % 南北边界斜率
fa=1+0.05;a=a0*fa;                                  % 斜率修正
b1=40.69+0.005-a*(-74)-0.007;                       % 下界
b2=40.78-0.005-a*(-74)+0.008;                       % 上界
y1=a*bw+b1;y2=a*be+b1;                              % 下界端点
y3=a*bw+b2;y4=a*be+b2;                              % 上界端点
% 现在，绘制市区界限
plot([bw bw],[y3 y1],'-.','LineWidth',3,'Color',[0.29,0.88,0.29]);hold on;
plot([be be],[y4 y2],'-.','LineWidth',3,'Color',[0.29,0.88,0.29]);
plot([bw be],[y1 y2],'-.','LineWidth',3,'Color',[0.29,0.88,0.29]);
plot([bw be],[y3 y4],'-.','LineWidth',3,'Color',[0.29,0.88,0.29]);
legend('乘客位置','出租车位置','市区边界');
axis([-74.1 -73.85 40.625 40.9])
% set(gca,'xTick',-74.1:0.05:-73.85);set(gca,'yTick',40.625:0.05:40.9);
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
%% 市区出租车数量
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
%% 分析市区特征（无效）
% dx=l2s([bw mean([y1,y3])],[be mean([y2,y4])]);
% dy=l2s([bw y3],[bw y1]);
% num=fix(dx/dy);
%% 划区求乘客、出租车分布
if size(pass,2)==5
    pass=[pass zeros(n_p,3)];
    taxi=[taxi zeros(n_t,3)];
end
n_a=70;
d1=(be-bw)/n_a;
d2=(b1-b2)/n_a;
index=1;
index_h=0;
index_l=0;
p{n_a^2}=[0 0 0];
t{n_a^2}=[0 0 0];
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
%% 最小
tic
op=[1,0];
time=0;
for i=1:n_a
    for j=1:n_a
        k=(i-1)*n_a+j;
        ar_1=min([ar_p(i,j),ar_t(i,j)-0.1]);
        ar_2=max([ar_p(i,j),ar_t(i,j)-0.1]);
        if op(2)==1
            if ar_1<=8 && ar_2<=8   % && size(p{k},2)>4   % 保存数据下次不算
                [p{k},t{k},minS]=dtbt(8,p{k},t{k});
                S{1,k}=[minS];
            end
        end
        if op(1)==1
            if (ar_1>8 || ar_2>8)  && size(p{k},2)>4   % 保存数据下次不算
                [p{k},t{k},minS]=dtbt2(p{k}(:,:),t{k}(:,:));
                S{1,k}=[minS];
            end
        end
        if mod(k,10)==0
            disp(k)
        end
    end
end
toc
%%
% save('Q1','p','S')%% 给定数据
v_u=25;  % 公里/小时，市区均速
v_s=40;  % 公里/小时，郊区均速
t_r=2;   % 分钟，接单响应时间上限
t_w=10;  % 分钟，候车时间上限