%% updated at 0516
function w=cengci1(A)
%% lambda=eigenvalue of maximum
[VA,DA]=eig(A);
[sA,tA]=find(DA==max(max(DA)));
lambdaA=DA(sA,tA);
%一致性检验 for lambda
nA=length(A);
CIA=(lambdaA-nA)/(nA-1);
RI0=[0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45 1.49 1.51];
RIA=RI0(1,nA);
CRA=CIA/RIA;
%custom CR limitation,CRl
CRAL=0.1;
if CRA<=CRAL
    textA1=['CRA=',num2str(CRA),'<=CRAl    √'];%New Function
else textA1=['CRA=',num2str(CRA),'>CRAl    ×'];
end
disp(textA1)
%Eigenvector 特征向量
eigenvectorA=VA(:,sA);
%guiyihuachuli
number1A=sum(eigenvectorA);
w=eigenvectorA/number1A;