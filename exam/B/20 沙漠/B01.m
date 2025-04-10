clear;clc;
whe = ...
    [2	2	1	3	1	2	3	1	2	2 ...
    3	2	1	2	2	2	3	3	2	2 ...
    1	1	2	1	3	2	1	1	2	2]; % wheather
M = 1200;           % 负重上限
C0 = 10^4;
W = 10^3;           % 挖矿收益
T = 30;             % 限制时间
m = [3 ; 2];        % 单位资源质量
p = [5 10];         % 单位资源基准价格
c = [5	8	10
    7	6	10];	% 不同天气下资源基准消耗量
dist = ...
    [0  6   8   3
    0   0   2   3
    0   2   0   5
    0   0   0   0];
for j=1:4
    if dist(1,j)~=0
        dist(1,j)=dist(1,j)-1;
    end
end
stay = 1;
walk = 2;
dig  = 3;
sure = 0;if sure ==1 save('B01.mat','c','C0','dig','dist','m','M','p','stay','T','W','walk','whe');clear sure;end