%% ***** 郊区匹配 ******
n_a=5;
bws=min([min(pass(:,2)) min(taxi(:,2))]);          	% 西边界
bes=max([max(pass(:,2)) max(taxi(:,2))]);          	% 东边界
bss=min([min(pass(:,1)) min(taxi(:,1))]);         	% 下界
bns=max([max(pass(:,1)) max(taxi(:,1))]);         	% 上界
%% 在市区的出租车数量
clear ar_ps;clear ar_ts;clear ps;clear ts
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
            if  taxi(k,3)==0 && taxi(k,2)>=bwa && taxi(k,2)<=bea && ...
                    taxi(k,1)>=b1a && taxi(k,1)<=b2a
                if isequal(ts{index},[0 0 0])
                    ts{index}=[k k2 taxi(k,1) taxi(k,2)];
                else ts{index}=[ts{index};k k2 taxi(k,1) taxi(k,2)];
                end
                k2=k2+1;
            end
        end
%         ar_ps(index_h,index_l)=size(find(pass(:,8)==index),1);
%         ar_ts(index_h,index_l)=size(find(taxi(:,5)==index),1);
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
%% 贪心算法 0
tic
op=[0,1,0,1];
time=0;
for i=1:n_a
    for j=1:n_a
        k=(i-1)*n_a+j;
        if op(2)==1
            % && size(p{k},2)>4   % 保存数据下次不算
            [ps{k},ts{k},minSs]=dtbt2(ps{k},ts{k},2);
            Ss{k}=[minSs];
        end
        if mod(k,1)==0
            disp(k);
        end
    end
end
toc
% 匹配成功总数
if op(2)==1;
    n_matching_suburb=0;
    for i=1:n_a^2
        n_matching_suburb = n_matching_suburb + size(find(Ss{i}>0),1);
    end
    disp('郊区匹配成功人数为');disp(n_matching_suburb);disp('郊区出行人数为');disp(n_p_suburb)
    lv=n_matching_suburb/n_p_suburb;disp('匹配成功率为');disp(lv);
end
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
v_u=25;v_s=40;
% 人号 纬度 经度 在市区 车号 纬度 经度 在市区 距离 等待时间
time=1;
for i=1:10
    j=round(rand(1)*n_p);
    if pass(j,5)==1                                 % 市区乘客
        p_h=find(p{pass(j,8)}(:,1)==j);             % ta 在 p 的索引
        if p{pass(j,8)}(p_h,5)~=0                   % 打上车了
            t_index=t{pass(j,8)}(p{pass(j,8)}(p_h,5),1);
            S_index=S{pass(j,8)}(p{pass(j,8)}(p_h,5),1);
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
        if p{pass(j,8)}(p_h,5)~=0
            t_index=ts{pass(j,11)}(ps{pass(j,11)}(p_h,5),1);
            S_index=Ss{pass(j,11)}(ps{pass(j,11)}(p_h,5),1);
            if time==1
                result=[j pass(j,1:2) 1 t_index t{pass(j,11)}(ps{pass(j,11)}(p_h,5),3:4) 1 ...
                    S_index S_index/v_u ];
            else result=[result;j pass(j,1:2) 1 t_index t{pass(j,11)}(p{pass(j,11)}(p_h,5),3:4) 1 ...
                    S_index S_index/v_u ];
            end
        else if time==1 
                result=[j pass(j,1:2) 1 t_index zeros(1,5)];
            else result=[result;j pass(j,1:2) 1 t_index zeros(1,5)];
            end
        end
    end
    time=time+1;
end

%% trs
figure(2);plot([0 1],[1 1],'-','color','[0.25 0.5 0.125]','LineWidth',2.5)