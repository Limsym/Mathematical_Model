load('B01','C0','c','dig','dist','m','M','p','stay','T','W','walk','whe')

decision=[ 1 0 1000 1000 ]; % sample
gouru=[             ]
bs=[1 2 3];
bs1=[1 2];
day=0;
for j=1:30
    if j==1
        
    end
    if j>1
        % 挖矿
        if wakuang(j)==1
            for i=1:2
                dN(i,j)=-c(i,whe(j))*bs(3);
                dC(j)=0;
            end
        end
        % 停留（不挖矿）
        if tingliu(j)==1
            for i=1:2
                dN(i,j)=-c(i,whe(j))*bs(1);
                dC(j)=0;
            end
        end
        % 补给
        if buji(j)==1
            for i=1:2
                dN(i,j)=c(i,whe(j))*gouru(i,j);
                dC(i,j)= (p(i) * gouru(i,j)) * beishu(2);
            end
        end
        % 旅行
        if
            
            
        end
        
        
        C(j)=C(j-1)+dN(i,j)+dN1(i,j);
        for i=1:2
            N(i,j)=N(i,j-1)+dN(i,j);
        end
        break
    end
    day=day+1;
end
C