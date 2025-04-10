clear,clc 
% 04.09 for first paper
seat=100;% 席位数
n=3;% 团体数
fa0=[15 10  5
    10 10 10
     5 10 15 ];%factors 客观因素值
w0=[0.6 0.3 0.1];% 各因素值影响力比值
x=length(w0);
for nb1=1:n;
    for nb2=1:x;
        fa1(nb1,nb2)=seat*fa0(nb1,nb2)*w0(nb2);
    end
end
for j=1:x
    fa1(n+1,j)=sum(fa1(:,j));
end
fa2=sum(fa1(n+1,:));
for j=1:x;
    we(j)=fa1(n+1,j)/fa2;
end
for i=1:n
    for j=1:x
    S1(i,j)=seat*we(i,j);
    end
end
fak=100/sum(S1);%因素值补偿系数
for i=1:n
    for j=1:x
        S(i,j)=S1(i,j)*fak;
    end
    S(i,x+1)=sum(S(i,1:x));%理论总席位数1
    S(i,x+2)=fix(S(i,x+1));
    S(i,x+3)=S(i,x+2)+1;
end

for nb2=x+1:x+2;
    for nb2=x+1:x+2;
        for nb4=x+1:x+2;
            if S(1,nb2)+S(2,nb2)+S(3,nb4)==S;
                nb2=nb2-x;nb2=nb2-x;nb4=nb4-x;
                f1(nb2,nb2,nb4)=(S(1,nb2)-S(1,x+1))^2+(S(2,nb2)-S(2,x+1))^2+(S(3,nb2)-S(3,x+1))^2;
                f2(nb2,nb2,nb4)=(S(1,nb2)-S(1,x+1))^2/S(1,x+1)+(S(2,nb2)-S(2,x+1))^2/S(2,x+1)+(S(3,nb2)-S(3,x+1))^2/S(3,x+1);
                f3(nb2,nb2,nb4)=(S(1,nb2)-S(1,x+1))^2/S(1,nb2)+(S(2,nb2)-S(2,x+1))^2/S(1,nb2)+(S(3,nb2)-S(3,x+1))^2/S(1,nb4);
            else f1(nb2,nb2,nb4)=nan;
                f2(nb2,nb2,nb4)=nan;
                f3(nb2,nb2,nb4)=nan;
        end
    end
    end
end
min(min(f1)),[s,t,z]=find(f1==min(min(f1)));y1=[S(1,x+1+s),S(2,x+1+s),S(3,x+1+s)]
min(min(f2)),[s,t,z]=find(f2==min(min(f1)));y2=[S(1,x+1+s),S(2,x+1+s),S(3,x+1+s)]
min(min(f3)),[s,t,z]=find(f3==min(min(f1)));y3=[S(1,x+1+s),S(2,x+1+s),S(3,x+1+s)]