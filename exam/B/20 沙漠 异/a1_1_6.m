%���-��ɽ-��ׯ-��ɽ-��ׯ-�յ� ����
clc
clear
%�ؿ�����ׯ2��ɽ2
l1=12;%��㵽�յ����
l2=9;%��㵽��ׯ����
l3=9;%��㵽��ɽ����
l4=1;%��ׯ����ɽ����
l5=2;%��ׯ���յ����
l6=2;%��ɽ���յ����
T1=l1;T2=l2;T3=l3;T4=l4;T5=l5;T6=l6;T61=l6;T41=l4;T42=l4;T43=l4;
weather=[2;2;1;3;1;2;3;1;2;2;3;2;1;2;2;2;3;3;2;2;1;1;2;1;3;2;1;1;2;2];%���������1Ϊ���ʣ�2Ϊ���£�3Ϊɳ��
resource=[3 9 10;4 9 10];%��ͬ������ͬ��Դ������
cz=10000;%��ʼ�ʽ�
js=1000;%��������
M=1200;%����
mw=0;mf=0;
pw=5;
pf=10;
Td=30;%��ֹʱ��
i=1;
while i<=T3
    if weather(i,1)==3
       T3=T3+1;
       w=resource(1,3);   %ˮ���������䣩
       f=resource(2,3);   %ʳ�����������䣩
    elseif weather(i,1)==2
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
% for j=(Td-3*l4-l5):-1:a1
% %     j=13;
%     for b1=a1:j
%     w1(b1)=resource(1,weather(b1,1))*3;   %ˮ���������䣩
%     f1(b1)=resource(2,weather(b1,1))*3;   %ʳ�����������䣩
%     end
%     i=j+1;
%         while i<=j+T4
%         if weather(i,1)==3
%            T4=T4+1;
%            T41=T4;
%            w=resource(1,3);   %ˮ���������䣩
%            f=resource(2,3);   %ʳ�����������䣩
%         elseif weather(i,1)==2
%            w=resource(1,2)*2;   %ˮ���������䣩
%            f=resource(2,2)*2;   %ʳ�����������䣩
%         else
%            w=resource(1,1)*2;   %ˮ���������䣩
%            f=resource(2,1)*2;   %ʳ�����������䣩
%         end
%            w1(i)=w;
%            f1(i)=f;
%            i=i+1;
%         end
%         T4=l4;
%        if sum(w1(1:i-1))*3+sum(f1(1:i-1))*2<=1200
%            w1(i:Td)=0;
%            f1(i:Td)=0;
%           break
%        end
% end

    j=14;
    for b1=a1:j
    w1(b1)=resource(1,weather(b1,1))*3;   %ˮ���������䣩
    f1(b1)=resource(2,weather(b1,1))*3;   %ʳ�����������䣩
    end
    i=j+1;
        while i<=j+T4
        if weather(i,1)==3
           T4=T4+1;
           T41=T4;
           w=resource(1,3);   %ˮ���������䣩
           f=resource(2,3);   %ʳ�����������䣩
        elseif weather(i,1)==2
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

while i<=j+T41+T42
    if weather(i,1)==3
       T42=T42+1;
       w=resource(1,3);   %ˮ���������䣩
       f=resource(2,3);   %ʳ�����������䣩
    elseif weather(i,1)==2
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
    w1(b2)=resource(1,weather(b2,1))*3;   %ˮ���������䣩
    f1(b2)=resource(2,weather(b2,1))*3;   %ʳ�����������䣩
    end
    i=k+1;
        while i<=k+T4
        if weather(i,1)==3
           T4=T4+1;
           T43=T4;
           w=resource(1,3);   %ˮ���������䣩
           f=resource(2,3);   %ʳ�����������䣩
        elseif weather(i,1)==2
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

while i<=k+T43+T5
    if weather(i,1)==3
       T5=T5+1;
       w=resource(1,3);   %ˮ���������䣩
       f=resource(2,3);   %ʳ�����������䣩
    elseif weather(i,1)==2
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
S=cz+W-C;%�������
   
    