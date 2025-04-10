%第二关经过矿山2去终点，不补充资源
clc
clear
weather=[2;2;1;3;1;2;3;1;2;2;3;2;1;2;2;2;3;3;2;2;1;1;2;1;3;2;1;1;2;2];%天气情况，1为晴朗，2为高温，3为沙暴
resource=[5 8 10;7 6 10];%不同天气不同资源所需量
w0=156;%走到矿山所消耗的水（箱）
f0=144;%走到矿山所消耗的食物（箱）
W1=0;
for i=13:26
        w=w0+sum(resource(1,weather(13:i,1))*3);%消耗水
        f=f0+sum(resource(2,weather(13:i,1))*3);%消耗食物
        mw=w*3;%消耗水重量
        mf=f*2;%消耗食物重量
        m=mw+mf;%总消耗质量
        zq=1000*(i-12);%每天的基础收益
        if m<=1200
            n=i;
            for j=1:2
                if weather(n+j,1)==3
                    w=w+resource(1,weather(n+j,1))+resource(1,weather(n+1+j,1))*2;
                    f=f+resource(2,weather(n+j,1))+resource(2,weather(n+1+j,1))*2;
                    mw=w*3;%消耗水重量
                    mf=f*2;%消耗食物重量
                    m=mw+mf;%总消耗质量
                    n=n+1;
                else
                    w=w+resource(1,weather(i+j,1))*2;
                    f=f+resource(2,weather(i+j,1))*2;
                    mw=w*3;%消耗水重量
                    mf=f*2;%消耗食物重量
                    m=mw+mf;%总消耗质量
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