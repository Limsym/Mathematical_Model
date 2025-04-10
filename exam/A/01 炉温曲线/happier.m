function [ys,re]=happier(condition)
[pT,t]=Tv2p(condition);
dot=size(pT,2);
% 第一二约束
YS(1)=1;
for i=1:dot-1
    dT=abs(pT(i+1)-pT(i));
    if dT>3
        YS(1)=0;
        break
    end
end
% 第三约束
dt=1/2;
for i=1:dot
   if pT(i)>=150 && pT(i)<=190
       ys2(i)=1*dt;
   elseif pT(i)>=217
       ys3(i)=1*dt;
   end
end

if sum(ys2)>=60 && sum(ys2)<=190
    YS(2)=1;
else YS(2)=0;
end
% 第四约束
if sum(ys3)>=40 && sum(ys3)<=90
    YS(3)=1;
else YS(3)=0;
end
% 第五约束
if max(pT)>=240 && max(pT)<250
    YS(4)=1;
else YS(4)=0;
end
ys=floor(sum(YS)/4);
re=[YS(1)*1000+YS(2)*100+YS(3)*10+YS(4)];
end
