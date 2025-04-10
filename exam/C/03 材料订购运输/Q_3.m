%% Q3
clear;clc;cd 'D:\Program Files\Polyspace\R2021a\bin\win64\C\03 材料订购运输'
load('Q2_1','index')
nodk=0;
while nodk<15
    tic
    if nodk==0
        x0=1:19;
        if isok(x0)==1
        odk=1;disp('good'),disp(nodk)
        nodk=nodk+1;
        crt{nodk,1}=x0;
        [N rs]=fx22(x0);
        [pa pc RL na nc]=fx3(x0,rs);
        crt{nodk,2}=[pa pc na nc N RL];
        break
        end
    else
        sjs=randperm(50);
        sjs2=round(rand(1)*8)+17;
        x0=[sjs(1:sjs2)];% 17-25 家
        if isok(x0)==1
            odk=1;disp('good'),disp(nodk)
            nodk=nodk+1;
            crt{nodk,1}=x0;
            [N rs]=fx22(x0);
            [pa pc RL na nc]=fx3(x0,rs);
            crt{nodk,2}=[pa pc na nc N RL];
        end
    end
    toc
end
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
        [pa pc RL na nc]=fx3(x0,rs);
        crt{nodk,2}=[pa pc na nc N RL];
    end
    toc
end
%% 预处理
for ii=1:30
    for jj=1:4
        crti{1}(ii,:)=crt{ii,2};
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
[v,i]=sort(crti{3,2},'descend')
%% 评分
v1=guiyi(v,1,60,100);
crti{4,1}=[i' v1'];











