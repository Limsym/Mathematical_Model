clear;clc
tic
load K;
T_set0=[175 195 235 255 25];
T_set1=[174 194 227 263];v1=91;
T_set2=[178 198 231 265];v2=94;
vbc=      0.5  *   2    ;                   % m/min
Tbc=       0.5  *   2    ;                   % ℃
for T1=T_set1(1):Tbc:T_set2(1)
    for T2=T_set1(2):Tbc:T_set2(2)
        for T3=T_set1(3):Tbc:T_set2(3)
            for T4=T_set1(4):Tbc:T_set2(4)
                T_set=[T1 T2 T3 T4 25];
                length=435.5; % cm
                dt=0.5;
                for vm=v1:vbc:v2; % 设定v值
                    i5=(vm-v1)/vbc+1;% if it's the 1st 'for'
                    v=vm/60;                                                    % m/s
                    clear pT;clear Ta;clear t;clear x;clear p;clear l;clear V;clear H;clear S
                    [pT]=Tv2p(T_set,vm);
                    dot=length/(v*dt)+1;
                    %% 约束
                    ys=happier(dot,pT);
                    %% 计算 S
                    clear h;clear zT;clear tTT
                    i6=1;
                    [none,tTT]=find(pT==max(pT));
                    for i=1:dot
                        if pT(i)>217 && i<=tTT
                            h(i6)=pT(i)-217;zT(i6)=pT(i);
                            i6=i6+1;
                        end
                    end
                    th=(i6-1)*dt;
                    S=sum(h)*dt*ys;
                    if T1+T2+T3+T4+i5==sum(T_set1)+1
                        result(1,:)=[S,T1,T2,T3,T4,vm,th];
                    elseif ys==1 && S<550
                        result=[result;S,T1,T2,T3,T4,vm,th];
                    end
                end
            end
        end
    end
end
%% 排序
[~,index]=sort(result(:,1));
sresult=result(index,:);
toc
%% putout
quhang=100;
sampleT_set=[sresult(2:1+quhang,2:5)];
samplevm=[sresult(2:1+quhang,2:5)];
save ('data2.mat','sampleT_set','samplevm'); %表示将内存变量data, x, y, z 保存到当前路径下的datas.mat文件，其它程序若要载入这几个变量的数据，只需前面路径下执行
