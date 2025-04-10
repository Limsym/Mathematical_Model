clear ;clc
tic
load datas;
T_set=[182 203 237 254 25];

%% 位置/cm
bian=25;xi=5;xiao=30.5;n_bian=2;n_xiao=11;n_xi=n_xiao-1;length=bian*n_bian+xiao*n_xiao+xi*n_xi;         % 435.5 cm
dt=0.5;                                         % /s
x(1)=0;
p(1)=1;
%% 未知区
buchang=     1    *    0.00001           ;
k=1
for vm=78.892:buchang:78.894; % 设定v值
    clear pT;clear Ta;clear t;clear x;clear p;clear l;clear V
    [pT]=Tv2p(T_set,vm);
    ys=happier(vm,pT);
if ys==1
    vv(k)=vm;k=k+1;
% else vv(i)=0;
end
end
%%
[V,I]=sort(vv,'descend');

toc




