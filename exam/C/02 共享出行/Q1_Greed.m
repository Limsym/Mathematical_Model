clear;clc
pass0=importdata('pass.txt');
taxi=importdata('taxi.txt');
n=size(pass0,1);
% 检验并修正数据
p1=pass0(:,1:2);p2=pass0(:,3:4);
pass=pass0;
for i=1:n
    if pass0(i,1)==pass0(i,3) && pass0(i,2)==pass0(i,4)
        pass(i,:)=[];
    end
end
% 然后划定市区
n_a=5;
bw0=mean([-74.009109 -74.015725]);                  % 西边界
be0=mean([-73.928465 -73.928908])+0.009;            % 东边界
fb=-0.008;bw=-74.029;be=be0+fb;                     % 边界修正
a0=(40.778714-40.778117)/(-73.977852-(-73.978328)); % 南北边界斜率
fa=1+0.05;a=a0*fa;                                  % 斜率修正
b1=40.69+0.005-a*(-74)-0.007;                       % 下界
b2=40.78-0.005-a*(-74)+0.008;                       % 上界
%

% 划区



% for i = 1:n_p
%     if pass(i,5)==0
%         find(abs(pass(:,3)))
%         
%         
%         
%     end
% end
for i = 1:n_t
    
end
n_matching_suburb=0;
if op(4)==[1];
    
    
    
    
end
