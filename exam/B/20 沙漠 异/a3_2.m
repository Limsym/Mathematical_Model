%���ֱ�ӵ��յ�����
clc
clear
weather = randsrc(100, 30, [1 2 3; 0.55 0.35 0.1]);
l1=8;%��㵽�յ����
resource=[3 9 10;4 9 10];%��ͬ������ͬ��Դ������
cz=10000;%��ʼ�ʽ�
M=1200;%����
pw=5;
pf=10;
i=1;S=0;
for ii=1:100
while i<=l1
    if weather(ii,i)==3
       l1=l1+1;
       w=resource(1,3);   %ˮ���������䣩
       f=resource(2,3);   %ʳ�����������䣩
    elseif weather(ii,i)==2
       w=resource(1,2)*2;   %ˮ���������䣩
       f=resource(2,2)*2;   %ʳ�����������䣩
    else
       w=resource(1,1)*2;   %ˮ���������䣩
       f=resource(2,1)*2;   %ʳ�����������䣩
    end
       w1(i)=w;%ˮ������
       f1(i)=f;%ʳ��������
       i=i+1;
end  
c=sum(w1)*pw+sum(f1)*pf;%�ܳɱ�
S=cz-c+S;
end
S=S/ii;