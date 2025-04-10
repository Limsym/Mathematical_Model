clear;clc;cd 'D:\Program Files\Polyspace\R2021a\bin\win64\C\03 材料订购运输'
O=xlsread('附件1 近5年402家供应商的相关数据','企业的订货量（m³）');
S=xlsread('附件1 近5年402家供应商的相关数据','供应商的供货量（m³）');
[n1,m1]=size(O);
[id1,id2]=find(O>=1000)
ii=1;
while ii<=402
    if abs(O(id1(ii),id2(ii))-S(id1(ii),id2(ii)))>=500
        O(id1(ii),id2(ii))=0;S(id1(ii),id2(ii))=0;
    end
    ii=ii+1;
end

period=10;
term=m1/period;
round(1,:)=([1:period]-1)*term+1;
round(2,:)=[1:period]*term;
bizhi = S./O;
c=max([1-min(bizhi(bizhi~=0)) max(bizhi)-1]);
for ii=1:n1
    for jj=1:m1
        if O(ii,jj)>0
            n(ii,jj)=1;
        else n(ii,jj)=0;
        end
        if bizhi(ii,jj)==1
            id40(ii,jj)=1;
        elseif bizhi(ii,jj)<1
            id40(ii,jj)=1-(1-bizhi(ii,jj))/c;
        elseif bizhi(ii,jj)>1
            id40(ii,jj)=1-(bizhi(ii,jj)-1)/c;
        elseif isnan(bizhi(ii,jj))==1
            id40(ii,jj)=nan;
        else warning('unexpected situation')
            return
        end
    end
end
id40=nan2zero(id40);
for ii=1:n1
    for jj=1:period
        o(ii,jj) = sum(O(ii,round(1,jj):round(2,jj)));
        s(ii,jj) = sum(S(ii,round(1,jj):round(2,jj)));
        N(ii,jj) = sum(n(ii,round(1,jj):round(2,jj)));
        M(ii,jj) = (s(ii,jj)-o(ii,jj))/N(ii,jj);
        for kk=1:term
            if O(ii,round(1,jj)+kk-1)==0
                obj(kk)=0;
            else obj(kk)=M(ii,jj);
            end
        end
        S2(ii,jj) = sum((S(ii,round(1,jj):round(2,jj))- ...
            O(ii,round(1,jj):round(2,jj))-obj).^2)/N(ii,jj);% 方差
        id4(ii,jj)=mean(id40(ii,round(1,jj):round(2,jj)));
    end
end
id3=-S2;
id3=nan2zero(id3);
id1=s;id2=N;
[~,id0]=xlsread('附件1 近5年402家供应商的相关数据','B2:B403');
id0 = str2num(id0);
id0=[id0 id0 id0 id0 id0 id0 id0 id0 id0 id0];
index={id0 id1 id2 id3 id4};
obj=index(1,:);
for ii=1:402% 对供货种类赋值
    for jj=1:10
        if index{1}(ii,jj)==1
            obj{1}(ii,jj)=3;
        elseif index{1}(ii,jj)==2
            obj{1}(ii,jj)=1;
        else obj{1}(ii,jj)=2;
        end
    end
end
for ii=1:5
    index{2,ii}=guiyi(obj{1,ii},1,0,1); % 归一化
end
for jj=1:10% 年份
    for kk=1:5 % 指标
        index{3,jj}(:,kk) = index{2,kk}(:,jj);
    end
end
for ii=1:period
    [w,s]=shang(index{3,ii});       % 熵权法赋权重
    index{4,ii}=w;index{5,ii}=s';
end
figure
x=1:10;
y=log(x*20+1);
y=(1-0)*(y-min(y))/(max(y)-min(y))+0;
y=y*0.4+0.6;
plot(x,y,'--','linewidth',1.1);hold on;scatter(x,y,'fill');
xlabel('周期');ylabel('权重');grid on;
legend('各周期的综合得分权重','FontSize',11,'Location','NorthWest');
axis([-inf inf 0.6 1])
for ii=1:10
    index{6,ii}=index{5,ii}*y(ii);
end
for ii=1:10
    index{7,1}(:,ii)=index{6,ii};
end
index{7,1}=guiyi(index{7,1},1,60,100);
index{7,2}='总分';
index{7,3}=sum(index{7,1},2);
index{7,4}='排名';
[id2 id1]=sort(index{7,3},'descend');
index{7,5}=[id1 id2 index{7,1}(id1,:)];
if 1/0==1
    data = [index{7,5}(1:50,:)];                    % 将数据组集到data
    [m, n] = size(data);
    data_cell = mat2cell(data, ones(m,1), ones(n,1));   % 将data切割成m*n的cell矩阵
    title = {'供应商编号','保障企业生产重要性总得分','第一周期得分','第二周期得分' '第三周期得分' '第四周期得分' '第五周期得分' '第六周期得分' '第七周期得分' '第八周期得分' '第九周期得分' '第十周期得分'};
    % 添加变量名称
    result = [title; data_cell];            % 将变量名称和数值组集到result
    s = xlswrite('ip_pr.xls', result);      % 将result写入文件中
end
%% 重要供应商供应量比重

obj=index{7,5}(1:402,1);
for ii=1:402
    iii=obj(ii);
    for jj=1:240
        if id0(iii,1)==1
            cs=0.6;
        elseif id0(iii,1)==2
            cs=0.66;
        elseif id0(iii,1)==3
            cs=0.72;
        else warning('uexp')
        end
        ji0(iii,jj)=S(iii,jj)/cs;
    end
end
he0=sum(sum(ji0))/240;
obj=index{7,5}(1:50,1);
for ii=1:50
    iii=obj(ii);
    for jj=1:240
        if id0(iii,1)==1
            cs=0.6;
        elseif id0(iii,1)==2
            cs=0.66;
        elseif id0(iii,1)==3
            cs=0.72;
        else warning('uexp')
        end
        prod(ii,jj)=S(iii,jj)/cs;
        pera(ii)=prod(ii,jj)/he0;
        if ii==1
            he(1)=prod(ii,jj);
            per(ii)=he(1)/he0;
        else he(ii)=prod(ii,jj)+he(ii-1);
            per(ii)=he(ii)/he0;
        end
    end
end
scatter(1:50,per,30,'fill');hold on;plot(1:50,per);grid on

%% 结果 229#


id=229;
% re=[id id0(id,1)];
obj=index{7,5}(1:50,1);
for ii=1:50
    id=obj(ii);
    re(ii,:) = [id id0(id,1) index{1,2}(id,(1:2:end)) index{1,3}(id,(1:2:end))...
        index{1,4}(id,(1:2:end)) id4(id,(1:2:end))];
end
figure;scatter(1:240,O(229,:),70,'.');hold on;grid on;scatter(1:240,S(229,:),70,'.');
plot(1:240,O(229,:));plot(1:240,S(229,:))
axis=([0 240 -inf +inf]);xlabel('周数(W)');ylabel(['原材料量(m^3)']);
legend('订货量','供货量')
%% 50优

if 1/0==1
    code=index{7,5}(1:50,1);
    data = O(code,:);                    % 将数据组集到data
    [m, n] = size(data);
    data_cell = mat2cell(data, ones(m,1), ones(n,1));   % 将data切割成m*n的cell矩阵
%     title = {'供应商编号','保障企业生产重要性总得分','第一周期得分','第二周期得分' '第三周期得分' '第四周期得分' '第五周期得分' '第六周期得分' '第七周期得分' '第八周期得分' '第九周期得分' '第十周期得分'};
    % 添加变量名称
    result = [data_cell];            % 将变量名称和数值组集到result
    s = xlswrite('hhha.xls', result);      % 将result写入文件中
end
if 1/0==1
    for ii=1:10
        data(:,ii) = index{4,ii}';
    end
    [m, n] = size(data);
    data_cell = mat2cell(data, ones(m,1), ones(n,1));   % 将data切割成m*n的cell矩阵
%     title = {'供应商编号','保障企业生产重要性总得分','第一周期得分','第二周期得分' '第三周期得分' '第四周期得分' '第五周期得分' '第六周期得分' '第七周期得分' '第八周期得分' '第九周期得分' '第十周期得分'};
    % 添加变量名称
    result = [data_cell];            % 将变量名称和数值组集到result
    s = xlswrite('ahhha.xls', result);      % 将result写入文件中
end
save index
%% Q2-2