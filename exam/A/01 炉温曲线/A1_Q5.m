for testk=min(k):1/1000:max(k)       %min(k)-0.1:0.00001:max(k)+0.1                    % 设定初值
    for i=qu(hf,1):qu(hf,2)                           % 取值范围
        if i==1
            pT(1)=25;
        else
            pT(i)=Ta(i)+(pT(i-1)-Ta(i))*exp(-testk*dt);
        end
        wc(i-qu(hf,1)+1)=(pT(i)-T(i))^2;
        if T(i)==0
            wc(i-qu(hf,1)+1)=0;
        end
    end
    WC=sum(wc);
    if testk==min(k)
        minwc=WC;
        K(hf)=testk;
    elseif WC<minwc
        minwc=WC;
        K(hf)=testk;
    end
end