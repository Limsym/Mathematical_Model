% Q4
clear;clc;cd 'D:\Program Files\Polyspace\R2021a\bin\win64\C\03 材料订购运输'
rs_ow=xlsread('Q4','sheet6','D2:AA403');
[pa,pc,RL,na,nc,rs_st,G]=fx3(rs_ow);
sum_columns=sum(rs_st)
sum(sum(rs_st))
%%
load('index')
%% RL
w=1:24;
lps=[1.90476916700000,0.921370417000000,0.186055556000000,1.57048235300000,...
    2.88982530100000,0.543761111000000,2.07883333300000,1.01028275900000]/100;
for i=1:8
    id1=i+(w-1)*8;
    l(i,:)=sum(sum(rs_st(:,id1)))*lps(i);
end
Los=sum(l);             % 损耗量
Spl=sum(sum(rs_st));    % 发货量
RL=Los/Spl;          	% 损耗率
Get=Spl-Los;          	% 收货量

w=1:24;
lps=[1.90476916700000,0.921370417000000,0.186055556000000,1.57048235300000,...
    2.88982530100000,0.543761111000000,2.07883333300000,1.01028275900000]/100;
aaa=[0.6 0.66 0.72];
for j=1:8
    for i=1:402
        id1=j+(w-1)*8;
        sp(i,j)=sum(rs_st(i,id1))/aaa(index{1,1}(i,1))*(1-lps(j));
    end
end
mMaxS=sum(sum(sp));
mMaxS-28200;
for j=1:1:192
    for i=1:402
        if mod(j,8)==0
            jj=8;
        else jj=mod(j,8);
        end
        w=ceil(j/8);
        sp(i,w)=sum(rs_st(i,1+8*(w-1):8*w))/aaa(index{1,1}(i,1))*(1-lps(jj));
    end
end
SP=sum(sp)-28200;
