function pc=symmetry(condition)
ys=happier(condition);
if ys==0
    pc=nan;
else [pT]=Tv2p(condition);
    h=pT-217;h(find(h<0))=nan;
    [~,index]=sort(h);
    h2=h(index);
    if index(1)<=index(2)
        if abs(index(2)-index(3))>10 && abs(index(1)-index(2))<10 index(2)=index(3);end
        if abs(pT(index(1))-pT(index(2)))<=abs(pT(index(1)+1)-pT(index(2)))
            l=index(1);
            r=index(2);
        else l=index(1)+1;r=index(2);
        end
    else
        if abs(index(2)-index(3))>10 && abs(index(1)-index(2))<10 index(2)=index(3);end
        if abs(pT(index(1))-pT(index(2)))<=abs(pT(index(1)+1)-pT(index(2)))
            l=index(2);
            r=index(1);
        else l=index(2)+1;r=index(1);
        end
    end
    dot2=r-l+1;
    if mod(dot2,2)==0
        for i=1:dot2/2
            dy2(i)=(pT(l+i-1)-pT(r-i+1))^2;
        end
    elseif mod(dot2,2)==1
        for i=1:(dot2-1)/2
            dy2(i)=(pT(l+i-1)-pT(r-i+1))^2;
        end
    end
    pc=sum(dy2.^2);
end
end