%�ڶ��ؾ�����ɽ2ȥ�յ㣬��������Դ
clc
clear
weather=[2;2;1;3;1;2;3;1;2;2;3;2;1;2;2;2;3;3;2;2;1;1;2;1;3;2;1;1;2;2];%���������1Ϊ���ʣ�2Ϊ���£�3Ϊɳ��
resource=[5 8 10;7 6 10];%��ͬ������ͬ��Դ������
w0=156;%�ߵ���ɽ�����ĵ�ˮ���䣩
f0=144;%�ߵ���ɽ�����ĵ�ʳ��䣩
W1=0;
for i=13:26
        w=w0+sum(resource(1,weather(13:i,1))*3);%����ˮ
        f=f0+sum(resource(2,weather(13:i,1))*3);%����ʳ��
        mw=w*3;%����ˮ����
        mf=f*2;%����ʳ������
        m=mw+mf;%����������
        zq=1000*(i-12);%ÿ��Ļ�������
        if m<=1200
            n=i;
            for j=1:2
                if weather(n+j,1)==3
                    w=w+resource(1,weather(n+j,1))+resource(1,weather(n+1+j,1))*2;
                    f=f+resource(2,weather(n+j,1))+resource(2,weather(n+1+j,1))*2;
                    mw=w*3;%����ˮ����
                    mf=f*2;%����ʳ������
                    m=mw+mf;%����������
                    n=n+1;
                else
                    w=w+resource(1,weather(i+j,1))*2;
                    f=f+resource(2,weather(i+j,1))*2;
                    mw=w*3;%����ˮ����
                    mf=f*2;%����ʳ������
                    m=mw+mf;%����������
                end
            end
            if m<=1200&n<=30
                W=zq+10000-w*5-f*10;
                if W>W1
                    W1=W;
                    w1=w;
                    f1=f;
                end
            end
        else
            break
        end  
end