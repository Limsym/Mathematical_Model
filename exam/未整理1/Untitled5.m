[n,m]=size(A);
%% 计算被减数/和
for j=1:m
    aveA(j)=sum(A(:,j))/n;
end
% 计算差1
for i=1:n
    for j=1:m
        cha(i,j)=A(i,j)-aveA(j);
    end
end
% 计算积1
for i=1:n
    for k=1:m
        for l=1:m
            ji1(i,k,l)=cha(i,k)*cha(i,l);
        end
    end
end
% 计算除数：和1
for k=1:m
    for l=1:m
        he1(k,l)=sum(ji1(:,k,l));
    end
end
%% 计算 被除数/根
% 计算 平方
pingfang=cha.^2;
% 计算 和2
for i=1:m
    he2(1,i)=sum(pingfang(1,:));
end
% 计算积2、根、商/相关系数
for k=111:153
    for l=1:42
        ji2(k,l)=he2(1,k)*he2(1,l);
        gen(k,l)=sqrt(ji2(k,l));
        R(k,l)=he1(k,l)/gen(k,l);
    end
end