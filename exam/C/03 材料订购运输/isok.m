function [ok,er,c3]= isok(x)
% save('fcd1','Prod','idpr','spo')
% example
% x=[1 2 3];
load('fcd1','Prod','idpr','spo')
% [1,m]=size(x);
Rb=28820;
R0=2*Rb;
lr=0.01368943163;
Prod_new = Prod(idpr{1}(:,2),:);
uniq=length(x)-length(unique(x));
ok=0;er=9;
c3=0;
if sum(idpr{1}(x,3))<2.88*10^4
    ok=0;er=1;return
elseif uniq~=0
    ok=0;er=2;return
else
    for jj=1:24
        pro_real(jj)=sum(Prod_new(x,jj))*spo*(1-lr)*0.94;%0.67
        dR(jj)=pro_real(jj)-Rb;
        if jj==1;R(jj)=R0+dR(jj);
        else R(jj)=R(jj-1)+dR(jj);
        end
        if R(jj)<R0
            ok=0;er=3;
            return
        end
    end
end
ok=1;er=0;c3=sum(sum(Prod_new(:,:)))*spo*(1-lr)/24;