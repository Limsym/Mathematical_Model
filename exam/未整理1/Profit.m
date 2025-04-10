clear,clc
t=1:110;%约束条件，第t天
n=length(t);
for i=1:n
    r(i)=0.2.*i;        %r*         每天增加的质量
    w(i)=8+r(i);        %weight     质量
    g(i)=0.1*i;         %g*         每天下降的单价
    p(i)=11-g(i);       %price      单价
    R(i)=w(i)*p(i);     %Revenue    收入
    C(i)=0.4*i;         %Cost       成本
    Q(i)=R(i)-C(i)-88;  %Profit     相对利润，因为原始利润未知
    if Q(i)<=0
        t=1:i
        Q(i+1)=0;t(i+1)=0;%补上零点
        break
    end
end
[s,t0]=find(Q==max(Q));
t0,Q(1,t0),
plot(t,Q)