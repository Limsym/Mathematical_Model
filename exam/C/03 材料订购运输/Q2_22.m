%% Q2_2

close all;clear;clc;cd 'D:\Program Files\Polyspace\R2021a\bin\win64\C\03 材料订购运输'

load("Q2_1.mat",'Prod','index','spo')
% choose1
for i=1:50
    if isok([1:i])==1
        chooset=[1:i];
        break
    end
end
j=0;
for i=1:size(chooset,2)
    x=chooset;x(i)=[];
    if isok(x)==1
        j=j+1;
        chooset2(j,:)=x;
    end
end
j=0;
for i=1:size(chooset2,2)
    x=chooset2;x(i)=[];
    if isok(x)==1
        j=j+1;
        chooset3(j,:)=x;% []
    end
end
nt=size(chooset2,1);
choose1=chooset2(nt,:)';
choose0=index{7,5}(choose1,1);
obj=Prod(choose1,:);
ppm=[0.6 0.66 0.72];
cate=index{1}(choose0,1);
for i=1:size(choose1,1)
    s(i,:)=round(obj(i,:)*ppm(cate(i)));
end
[n,m]=size(obj);
lr=0.01368943163;
Rb=28820;
N0=2*Rb;
qw=sum(obj);                % plot(1:24,qw);
syms uk;need=ceil(vpasolve(uk*spo*(1-lr)-Rb,uk));
tmdt=find(qw<need);         % 寻找时间节点

%% solve plan

for i=1:3
    id=intersect(find(index{1}(:,1)==i),choose1);
    num=size(id,1);
    for j=1:num
        ca{i}(j)=find(choose1==id(j));
    end
end
plan{1,2}='gou mai wu zi';
plan{2,2}='zhe he gong neng liang'
ys=0;kk=[ones(2,1) zeros(2,2)];
ar=4;
while ys==0
    disp(kk)
    for j=1:m
        for i=1:n
            ch=ceil(j/12);
            k=kk(ch,:);
            plan{1}(i,j)=round(s(i,j)*k(cate(i)));
            plan{2}(i,j)=plan{1}(i,j)/ppm(cate(i));
        end
        for l=1:3
            plan{3,1}(l,j)=sum(plan{1}(ca{l},j));
        end
        over=sum(plan{3,1}(:,j))*spo-6000*8;
        if over>0
            pd3=1;
            if over<=plan{3,1}(2,j)
                d2=over;pd2=over/d2
                plan{3,1}(2,j)=plan{3,1}(2,j)-over;
            elseif over>plan{3,1}(2,j) && over<=plan{3,1}(3,j)
                d2=plan{3,1}(2,j);pd2=1;
                plan{3,1}(2,j)=0;
                d3=over-plan{3,1}(2,j);
                pd3=(plan{3,1}(3,j)-d3)/plan{3,1}(3,j);
                plan{3,1}(3,j)=plan{3,1}(3,j)-(plan{3,1}(2,j)-over);
            end
            pd=[1 pd2 pd3];
            for i=1:n
                ch=ceil(j/12);
                k=kk(ch,:);
                plan{1}(i,j)=round(s(i,j)*k(cate(i)))*pd(cate(i));
                plan{2}(i,j)=plan{1}(i,j)/ppm(cate(i));
            end
            for l=1:3
                plan{3,1}(l,j)=sum(plan{1}(ca{l},j));
            end
        end
        N(1,j)=sum(plan{1}(:,j))*spo*(1-lr);
        N(2,j)=Rb;
        if j==1
            N(3,j)=N0+N(1,j)-N(2,j);
        else N(3,j)=N(3,j-1)+N(1,j)-N(2,j);
        end
        if ch==2 && j==m
                warning('uexp')
                ys=1;
        end
        if N(3,j)<2*Rb
            if kk(ch,3)+0.1<1
                kk(ch,3)=kk(ch,3)+0.1;break
            elseif kk(ch,2)+0.1<1
                kk(ch,2)=kk(ch,2)+0.1;break
            elseif ch>1 && kk(ch-1,3)+0.1<1
                kk(ch-1,3)=kk(ch-1,3)+0.1;break
            elseif ch==2 && j==m
                warning('uexp')
                ys=1;
            end
        end
    end
    if min(N(3,:))>=2*Rb
        ys=1;
    end
end
% plot(1:24,N(3,:));xlabel('周（W）');ylabel('原材料购买量（m^3）')
% legend('A类原材料','B类原材料','C类原材料');
plot(1:24,N(3,:));xlabel('周（W）');ylabel('库存可供产能量（m^3）')
% legend('产能大小');