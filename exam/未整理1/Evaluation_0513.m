%% custom matrices
A=[1 1/2 4 3 3
    2 1 7 5 5
    1/4 1/7 1 1/2 1/3
    1/3 1/5 2 1 1
    1/3 1/5 4 1 1];
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
    textA1=['CRA<=CRAL   √','   ',num2str(CRA)];%New Function
else textA1=['CRA>CRAL   ×','   ',num2str(CRA)]; 
end
disp(textA1)
%Eigenvector 特征向量
eigenvectorA=VA(:,sA);
%guiyihuachuli
number1A=sum(eigenvectorA);
w=eigenvectorA/number1A;
%% --------2222--------
%Custom matrices B
B1=[1 2 5
    1/2 1 2
    1/5 1/2 1];
B2=[1 1/3 1/8
    3 1 1/3
    8 3 1];
B3=[1 1 3
    1 1 3
    1/3 1/3 1];
B4=[1 3 4
    1/3 1 1
    1/4 1 1];
B5=[1 1 1/4
    1 1 1/4
    4 4 1];
%--------2.B1--------
%lambda=eigenvalue of maximum
[VB1,DB1]=eig(B1);
[sB1,tB1]=find(DB1==max(max(DB1)));
lambdaB1=DB1(sB1,tB1);
    %一致性检验 for lambda
    nB1=length(B1);
    CIB1=(lambdaB1-nB1)/(nB1-1);
    RI0=[0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45 1.49 1.51];
    RIB1=RI0(1,nB1);
    CRB1=CIB1/RIB1;
    CRlB1=0.1;    %custom CR limitation,CRl
    if CRB1<=CRlB1
        text1B1=['CR<=CRl   √    ',num2str(CRB1)];
    else text1B1=['CR>CRl   ×    ',num2str(CRB1)];
    end
    disp(text1B1)
%Eigenvector & guiyihuachuli
eigenvectorB1=VB1(:,sB1);
number1B1=sum(eigenvectorB1);
WB1=eigenvectorB1/number1B1;
%--------2.B2--------
%lambda=eigenvalue of maximum
[V,DB2]=eig(B2);
[sB2,tB2]=find(DB2==max(max(DB2)));
lambdB2a=DB2(sB2,tB2);
    %一致性检验 for lambda
    nB2=length(B2);
    CIB2=(lambdB2a-nB2)/(nB2-1);
    RI0=[0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45 1.49 1.51];
    RIB2=RI0(1,nB2);
    CRB2=CIB2/RIB2;
    CRlB2=0.1;    %custom CR limitation,CRl
    if CRB2<=CRlB2
        text1B2=['CR<=CRl   √    ',num2str(CRB2)];
    else text1B2=['CR>CRl   ×    ',num2str(CRB2)];
    end
    disp(text1B2)
%Eigenvector & guiyihuachuli
eigenvectorB2=V(:,sB2);
number1B2=sum(eigenvectorB2);
WB2=eigenvectorB2/number1B2;
%--------2.B3--------
%lambda=eigenvalue of maximum
[VB3,DB3]=eig(B3);
[sB3,tB3]=find(DB3==max(max(DB3)));
lambdB3a=DB3(sB3,tB3);
    %一致性检验 for lambda
    nB3=length(B3);
    CIB3=(lambdB3a-nB3)/(nB3-1);
    RI0=[0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45 1.49 1.51];
    RIB3=RI0(1,nB3);
    CRB3=CIB3/RIB3;
    CRlB3=0.1;    %custom CR limitation,CRl
    if CRB3<=CRlB3
        text1B3=['CRB3<=CRl   √    ',num2str(CRB3)];
    else text1B3=['CRB3>CRl   ×    ',num2str(CRB3)];
    end
    disp(text1B3)
%Eigenvector & guiyihuachuli
eigenvectorB3=VB3(:,sB3);
number1B3=sum(eigenvectorB3);
WB3=eigenvectorB3/number1B3;
%--------2.B4--------
%lambda=eigenvalue of maximum
[VB4,DB4]=eig(B4);
[sB4,tB4]=find(DB4==max(max(DB4)));
lambdB4a=DB4(sB4,tB4);
    %一致性检验 for lambda
    nB4=length(B4);
    CIB4=(lambdB4a-nB4)/(nB4-1);
    RI0=[0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45 1.49 1.51];
    RIB4=RI0(1,nB4);
    CRB4=CIB4/RIB4;
    CRlB4=0.1;    %custom CR limitation,CRl
    if CRB4<=CRlB4
        text1B4=['CRB4<=CRl   √    ',num2str(CRB4)];
    else text1B4=['CRB4>CRl   ×    ',num2str(CRB4)];
    end
    disp(text1B4)
%Eigenvector & guiyihuachuli
eigenvectorB4=VB4(:,sB4);
number1B4=sum(eigenvectorB4);
WB4=eigenvectorB4/number1B4;
%--------2.B5--------
%lambda=eigenvalue of maximum
[VB5,DB5]=eig(B5);
[sB5,tB5]=find(DB5==max(max(DB5)));
lambdB5a=DB5(sB5,tB5);
    %一致性检验 for lambda
    nB5=length(B5);
    CIB5=(lambdB5a-nB5)/(nB5-1);
    RI0=[0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45 1.49 1.51];
    RIB5=RI0(1,nB5);
    CRB5=CIB5/RIB5;
    CRlB5=0.1;    %custom CR limitation,CRl
    if CRB5<=CRlB5
        text1B5=['CRB5<=CRl   √    ',num2str(CRB5)];
    else text1B5=['CRB5>CRl   ×    ',num2str(CRB5)];
    end
    disp(text1B5)
%Eigenvector & guiyihuachuli
eigenvectorB5=VB5(:,sB5);
number1B5=sum(eigenvectorB5);
WB5=eigenvectorB5/number1B5;
%% --------3W&P--------
W=[WB1 WB2 WB3 WB4 WB5];
for i=1:3
    P(i,:)=W(i,:)*w;
end
textP=['P^T=   ',num2str(P')];
disp(textP)
[smaxP tmaxP]=find(P==max(P));
if smaxP==1
    textP='st';
elseif smaxP==2
    textP=='nd';
elseif smaxP==3
    textP='rd';
else
    textP='th';
end

textmaxP=['the P of maximum is the ',num2str(smaxP),num2str(textP),' one,',num2str(P(smaxP,tmaxP))];
disp(textmaxP)