%���-��ɽ-��ׯ-��ɽ-��ׯ-�յ� ����
clc
clear
weather = randsrc(100, 30, [1 2 3; 0.55 0.35 0.1]);
%�ؿ���
l1=8;%��㵽�յ����
l2=5;%��㵽��ׯ����
l3=5;%��㵽��ɽ����
l4=2;%��ׯ����ɽ����
l5=3;%��ׯ���յ����
l6=3;%��ɽ���յ���� 
T1=l1;T2=l2;T3=l3;T4=l4;T5=l5;T6=l6;T61=l6;T41=l4;T42=l4;T43=l4;
resource=[3 9 10;4 9 10];%��ͬ������ͬ��Դ������
cz=10000;%��ʼ�ʽ�
js=1000;%��������
M=1200;%����
pw=5;
pf=10;
Td=30;%��ֹʱ��
S1=0;bw01=0;bw11=0;bw21=0;bf01=0;bf11=0;bf21=0;t=0;T=0;
v=0;
for ii=1:100
i=1;
while i<=T3
    if weather(ii,i)==3
       T3=T3+1;
       w=resource(1,3);   %ˮ���������䣩
       f=resource(2,3);   %ʳ�����������䣩
    elseif weather(ii,i)==2
       w=resource(1,2)*2;   %ˮ���������䣩
       f=resource(2,2)*2;   %ʳ�����������䣩
    else
       w=resource(1,1)*2;   %ˮ���������䣩
       f=resource(2,1)*2;   %ʳ�����������䣩
    end
       w1(i)=w;
       f1(i)=f;
       i=i+1;
end
a1=i;
for j=(Td-3*l4-l5):-1:a1
    for b1=a1:j
    w1(b1)=resource(1,weather(ii,b1))*3;   %ˮ���������䣩
    f1(b1)=resource(2,weather(ii,b1))*3;   %ʳ�����������䣩
    end
    i=j+1;
        while i<=j+T4
        if weather(ii,i)==3
           T4=T4+1;
           T41=T4;
           w=resource(1,3);   %ˮ���������䣩
           f=resource(2,3);   %ʳ�����������䣩
        elseif weather(ii,i)==2
           w=resource(1,2)*2;   %ˮ���������䣩
           f=resource(2,2)*2;   %ʳ�����������䣩
        else
           w=resource(1,1)*2;   %ˮ���������䣩
           f=resource(2,1)*2;   %ʳ�����������䣩
        end
           w1(i)=w;
           f1(i)=f;
           i=i+1;
        end
        T4=l4;
       if sum(w1(1:i-1))*3+sum(f1(1:i-1))*2<=1200
           w1(i:Td)=0;
           f1(i:Td)=0;
          break
       end
end


while i<=j+T41+T42
    if weather(ii,i)==3
       T42=T42+1;
       w=resource(1,3);   %ˮ���������䣩
       f=resource(2,3);   %ʳ�����������䣩
    elseif weather(ii,i)==2
       w=resource(1,2)*2;   %ˮ���������䣩
       f=resource(2,2)*2;   %ʳ�����������䣩
    else
       w=resource(1,1)*2;   %ˮ���������䣩
       f=resource(2,1)*2;   %ʳ�����������䣩
    end
       w1(i)=w;
       f1(i)=f;
       i=i+1;
end

a2=i;
for k=(Td-l4-l5):-1:a2
    for b2=a2:k
    w1(b2)=resource(1,weather(ii,b2))*3;   %ˮ���������䣩
    f1(b2)=resource(2,weather(ii,b2))*3;   %ʳ�����������䣩
    end
    i=k+1;
        while i<=k+T4&&k+T4<=Td
        if weather(ii,i)==3
           T4=T4+1;
           T43=T4;
           w=resource(1,3);   %ˮ���������䣩
           f=resource(2,3);   %ʳ�����������䣩
        elseif weather(ii,i)==2
           w=resource(1,2)*2;   %ˮ���������䣩
           f=resource(2,2)*2;   %ʳ�����������䣩
        else
           w=resource(1,1)*2;   %ˮ���������䣩
           f=resource(2,1)*2;   %ʳ�����������䣩
        end
           w1(i)=w;
           f1(i)=f;
           i=i+1;
        end
        T4=l4;
       if sum(w1(j+T42+1:i-1))*3+sum(f1(j+T42+1:i-1))*2<=1200
           w1(i:Td)=0;
           f1(i:Td)=0;
           break
       end
end

while i<=k+T43+T5&k+T43+T5<=Td
    if weather(ii,i)==3
       T5=T5+1;
       w=resource(1,3);   %ˮ���������䣩
       f=resource(2,3);   %ʳ�����������䣩
    elseif weather(ii,i)==2
       w=resource(1,2)*2;   %ˮ���������䣩
       f=resource(2,2)*2;   %ʳ�����������䣩
    else
       w=resource(1,1)*2;   %ˮ���������䣩
       f=resource(2,1)*2;   %ʳ�����������䣩
    end
       w1(i)=w;
       f1(i)=f;
       i=i+1;
end

wz=sum(w1);
fz=sum(f1);

bf0=fix((M-sum(w1(1:j+T41))*3)/2);
bf1=sum(f1(j+T41+1:k+T43))-(bf0-sum(f1(1:j+T41)));
bf2=fz-bf1-bf0;
bw0=sum(w1(1:j+T41));
bw2=sum(w1(k+T43+1:Td));
bw1=wz-bw0-bw2;

C=bw0*pw+bf0*pf+bw1*pw*2+bf1*pf*2+bw2*pw*2+bf2*pf*2;%�ܳɱ�
W=js*(j-a1+1)+js*(k-a2+1);%������
% W=js*(j-a1+1-5)+js*(k-a2+1-4)+0.5*9*js;%������
S=cz+W-C;%�������
T1=l1;T2=l2;T3=l3;T4=l4;T5=l5;T6=l6;T61=l6; T41=l4;T42=l4;T43=l4; 
if size(S)==1
S1=S+S1;
bw01=bw0+bw01;
bw11=bw1+bw11;
bw21=bw2+bw21;
bf01=bf0+bf01;
bf11=bf1+bf11;
bf21=bf2+bf21;
t=j-a1+1+k-a2+1+t;
T=i-1+T;
v=v+1;
end
end
S1=S1/v;
bw01=bw01/v;bw11=bw11/v;bw21=bw21/v;
bf01=bf01/v;bf11=bf11/v;bf21=bf21/v;
t=t/v;T=T/v;




