function S=sharea(condition)
pT=Tv2p(condition);
ys=happier(condition);
if ys==0
    S=10^4;
else for i=1:find(pT==max(pT))
        if pT(i)>217
            h(i)=pT(i)-217;%zT(numh)=pT(i);
        end
    end
    dt=0.5;S=sum(h)*dt;
end