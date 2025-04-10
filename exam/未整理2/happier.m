% I really wish this program could make you happier,and I hope sinceresly.
function [ys,report]=happier(vm,pT)
dt=0.5; v=vm/60;length=435.5;dot=fix(length/(v*dt)+1);
for i=1:dot-1;dT(i)=(pT(i+1)-pT(i))/dt;
    if abs(dT(i))>3;y1(i)=0;else y1(i)=1;end
    if pT(i+1)>=150 && pT(i+1)<=190 && dT(i)>0;y2(i)=1;else y2(i)=0;end
end
Y(1)=sum(y1);if Y(1)<dot-1;Y(1)=0;else Y(1)=1;end
Y(2)=sum(y2);if Y(2)>=60/dt+1 && Y(2)<=120/dt+1;Y(2)=1;else Y(2)=0;end
for i=1:dot;if pT(i)>=217;y3(i)=1;else y3(i)=0;end;end
Y(3)=sum(y3);if Y(3)>=(40/dt+1) && Y(3)<=(90/dt+1);Y(3)=1;else Y(3)=0;end;
y4=max(pT);
if y4>=240 && y4<=250;Y(4)=1;else Y(4)=0;end
if sum(Y)==4;ys=1;else ys=0;end
report=1000*Y(1)+100*Y(2)+10*Y(3)+1*Y(4);
end