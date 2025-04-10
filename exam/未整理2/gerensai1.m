% 输入变量
n=30;
% 求解过程
A=n;
B=0;
plan=zeros(1,30);
%% m
m=;
for i=1:fix(m/2)
    for 
        
    end
end
%%
for i=1:n
    for j=plan
        % 计算 d
        if A(i,j)>=3 && B(i,j)=0
            d(i,j)=1;
        else d(i,j)=0;
        end
        % 计算 e
        if B(i,j)=0 && d(i,j)=0
            e(i,j)=0;
        else e(i,j)=1;
        end
        % 计算 tp
        if d(i,j)=0
            tp(i,j)=0;
        else 
            tp(i,j)=
        end
        % 计算 A,B
        A(i+1,j)=A(i,j)-d(i,j)*tp(i,j)-d(i,j)+e(i,j)-1;
        B(i+1,j)=B(i,j)-e(i,j)+d(i,j)*tp(i,j);
        % 计算 f
        if e(i,j)=1
            f(i,j)=B(i,j);
        else f(i,j)=A(i,j)+B(i,j)*d(i,j);
        end
    end
end
% 计算 F
for j=1:plan
    F(1,j)=sum(f(:,j));
end
% 寻找min(F)
[s,t]=find(F==min(F))
    