tm=111;
x=Rop2op1;
y=zeros(1,tm);
for i=1:tm
    for j=1:tm
        t=y(j);
        if t>0
            x(j,:)=x(j,:)+x(i,:);
        end
        if x(i,j)==1
            y(j)=i;
        end
    end
end
san=B(:,4,7,9,11,93,96,99,102,105,108:111);
lan=B(:,8,19:25,27,29,34,38,42,46,54,58,62,67);
qian=B(:,16:18);
lv=B(:,48,51,60,61,63);
hong=(:,1:3,5,6,12:15,28,30:33,35:37,39:41,43:45,47,52,53,55:57,59,64:66,68:89,91,92,94,95,97,98,100,101,103,104,106,107);
%%
[s,t]=find(b2T2==min(min(b2T2)));
b2T2(s,t)=b2T2(s-1,t);
%% delta_bianliang_to_T;db2T;用和描述   1
a=2901;d=3550;b=(c+a-1)/2;c=b+1;
db2T=zeros(5000,153);
for j=1:153
    db2T(1,j)=sum(b2T2(a:b,j));
    db2T(2,j)=sum(b2T2(c:d,j));
    db2T(3,j)=db2T(2,j)-db2T(1,j);
end
plot(db2T(3,:))
[s,t]=find(db2T==max(max(db2T(3,:))))
%% 1
%% 计算SB(i,j)对于T10的贡献值
% SB,PV;beta,beta0
beta0=424.909;
for j=1:153
    for k=1:8
        kb2T(j,k)=PV(j,k)*beta(k);
    end
end
for j=1:153
    k(j)=sum(kb2T(j,:));
end
for i=1:5000
    for j=1:153
        Tf(i,j)=SB(i,j)*k(j);
    end
end
for i=1:5000
    T(i)=sum(Tf(i,:))+beta0;
end
%% 绘制T曲线
plot(T)
