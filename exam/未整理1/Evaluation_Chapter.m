%--------2.aaaa--------
%lambda=eigenvalue of maximum
[Vaaaa,Daaaa]=eig(aaaa);
[saaaa,taaaa]=find(Daaaa==max(max(Daaaa)));
lambdaaaaa=Daaaa(saaaa,taaaa);
    %一致性检验 for lambda
    naaaa=length(aaaa);
    CIaaaa=(lambdaaaaa-naaaa)/(naaaa-1);
    RI0=[0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45 1.49 1.51];
    RIaaaa=RI0(1,naaaa);
    CRaaaa=CIaaaa/RIaaaa;
    CRlaaaa=0.1;    %custom CR limitation,CRl
    if CRaaaa<=CRlaaaa
        text1aaaa=['CRaaaa<=CRl   √    ',num2str(CRaaaa)];
    else text1aaaa=['CRaaaa>CRl   ×    ',num2str(CRaaaa)];
    end
    disp(text1aaaa)
%Eigenvector & guiyihuachuli
eigenvectoraaaa=Vaaaa(:,saaaa);
number1aaaa=sum(eigenvectoraaaa);
Waaaa=eigenvectoraaaa/number1aaaa;
