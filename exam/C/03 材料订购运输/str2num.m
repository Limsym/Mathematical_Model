% clear;clc;cd D:\information\数学建模\暑期集训\A
% [~,data]=xlsread('附件3.csv','A2:C4301');% 以字符串形式读取表格
function N  = str2num(data)
[n,m]=size(data);
for ii=1:n
    for jj=1:m
        obj=data{ii,jj};    % 研究对象
        n0=length(obj);     % 对象的字符串长度
        for kk=1:n0
            id(kk)=uint8(obj)-64;	% 判断该字母的序号：'A' -> 1; 'AA'->27; 'AB'->28;
            N(ii,jj)=double(id(kk));       % 将uint转double
        end
    end
end
end