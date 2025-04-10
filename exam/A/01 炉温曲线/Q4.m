clear;clc;tic
condition0=[167.5208 192.0511 232.8122 264.9383 89.8653];
num=1;
dc(1,:)=-0.5:0.1:0.5;
for i1=-0.5:0.1:0.5
    for i2=-0.5:0.1:0.5
        for i3=-0.5:0.1:0.5
            for i4=-0.5:0.1:0.5
                for i5=-0.5:0.1:0.5
                    condition=[condition0(1)+i1 condition0(2)+i2 condition0(3)+i3 condition0(4)+i4 condition0(5)+i5];
                    S = sharea(condition);
                    pc = symmetry(condition);
                    if num==1
                        result=[condition S pc];
                    else result=[result;condition S pc];
                    end
                    num=num+1;if mod(num,100)==0 disp(num);end
                end
            end
        end
    end
end
toc
save('result')
%% 熵权法赋权
zhibiao=result(:,6:7);
[w,s]=shang(zhibiao);
reshum=[result s];
% rresult2 = mapminmax(result2', 60, 100)';
% rresult4 = sum(rresult2');
% rresult4 = rresult4';
[~,index]=sort(reshum(:,6),'descend');
result_shang=reshum(index,:);
%% 功效系数法赋权
SCORE=reshum(hang,2)
T_set=sampleT_set(hang,:)
vm=samplevm(hang)
figure
[pT,t]=Tv2p(T_set,vm);
scatter(t, pT,5,'r','filled');;grid on;xlabel('时间(s)');ylabel('T(℃)');