%% Q3
% clear;clc;cd 'D:\Program Files\Polyspace\R2021a\bin\win64\C\03 材料订购运输'
load('Q2_1','index')    
% 模拟前15家数据
if 1/0==1;nodk=0;end            % 出错就重新选取数据，因为约束难满足
while nodk<15
    tic
    if nodk==0
        x0=1:19;
    else
        sjs=randperm(50);
        sjs2=round(rand(1)*8)+17;
        x0=[sjs(1:sjs2)];% 17-25 家
    end
    if isok(x0)==1
        odk=1;disp('good'),disp(nodk)
        nodk=nodk+1;
        crt{nodk,1}=x0;
        [N rs]=fx22(x0);
        [pa pc RL na nc]=fx3(rs);
        crt{nodk,2}=[pa pc na nc N RL];
    end
    toc
end
%% 模拟后15组数据
while nodk>=15 && nodk<30
    tic
    sjs=randperm(50);
    sjs2=round(rand(1)*24)+26;
    x0=[sjs(1:sjs2)];% 17-25 家
    if isok(x0)==1
        odk=1;disp('good'),disp(nodk)
        nodk=nodk+1;
        crt{nodk,1}=x0;
        [N rs]=fx22(x0);
        [pa pc RL na nc]=fx3(rs);
        crt{nodk,2}=[pa pc na nc N RL];
    end
    toc
end
%% 单独重新生成模拟数据
nodk=12;
while nodk==12
    tic
    if nodk==0
        x0=1:19;
    else
        sjs=randperm(50);
        sjs2=round(rand(1)*8)+17;
        x0=[sjs(1:sjs2)];% 17-25 家
    end
    if isok(x0)==1
        odk=1;disp('good'),disp(nodk)
        nodk=nodk+1;
        crt{nodk,1}=x0;
        [N rs]=fx22(x0);
        [pa pc RL na nc]=fx3(rs);
        crt{nodk,2}=[pa pc na nc N RL];
    end
    toc
end
%% 预处理
for ii=1:30
    for jj=1:4
        crti{1}(ii,:)=crt{ii,2}(:,3:6);
    end
end
for jj=1:4
    if jj~=1 && jj~=4
        crti{1}(:,jj)=-crti{1}(:,jj);
    end
end
% for ii=1:10
%     
%     nodk=nodk+1;
%     crt{nodk,1}=x0;
%     [pa pc RL]=fx3(x0);
%     N=fx22(x0);
%     crt{nodk,2}=[pa pc N RL];
% end
crti{2}=guiyi(crti{1},1,0,1);
%% 赋权
[w s]=shang(crti{2});
crti{3,1}=w;
crti{3,2}=s;
%% 排序
[v,i]=sort(crti{3,2},'descend');
%% 评分
v1=guiyi(v',1,60,100);
crti{4,1}=[i' v1];
% best=18
x0=crt{i(16),1};            % 
% [aa re22]=fx22(x0)
[N rs kk]=fx22(x0);kk       % 人工检查发现前四名部分周库存较少 
% re 为 购买方案
[pa pc RL na nc re3]=fx3(x0,rs);hold on
% re3 为转运方案
ida=find(index{1}(:,1)==1);
sa=sum(re3(ida,:));ssa=sum(sa)
idb=find(index{1}(:,1)==2);
sb=sum(re3(idb,:));ssb=sum(sb)
idc=find(index{1}(:,1)==3);
sc=sum(re3(idc,:));ssc=sum(sc)




