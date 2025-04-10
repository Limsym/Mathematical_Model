% A01
function [K,pT,R]=Ar2K(Area)
load('A01','T','Ta','k','nowt','dot','dt','t')
pT(1)=25;
nArea=size(Area,1);
ksl=1*10^(-5);                  % k step length
k1=min(k)*1.1;k2=max(k)*1.1;
for iArea=1:nArea
    for k_test=k1:ksl:k2
        for i=Area(iArea,1):Area(iArea,2)
            if i>Area(iArea,1)
                pT(i)=Ta(i)+(pT(i-1)-Ta(i))*exp(-k_test*dt);
                pc(iArea,i)=(pT(i)-T(i))^2;
                if T(i)==0
                    pc(iArea,i)=0;
                end
            end
        end
        PC(iArea)=sum(pc(iArea,:));
        if k_test==min(k)*1.1
            minPC(iArea)=PC(iArea);
            K(iArea)=k_test;
        elseif PC(iArea)<minPC(iArea)
            minPC(iArea)=PC(iArea);
            K(iArea)=k_test;
        end
    end
    for i=Area(iArea,1):Area(iArea,2)
        if i>Area(iArea,1)
            pT(i)=Ta(i)+(pT(i-1)-Ta(i))*exp(-K(iArea)*dt);
        end
    end
end
Q=sum((pT(nowt:dot)-T(nowt:dot)).^2);
X=sum(T(nowt:dot).^2);
R=1-(Q/X)^(1/2);
end