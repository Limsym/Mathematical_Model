function [y]=dist(l0,l2)
for i=1:n_n
    for j=1:n_m
        dist(i,j)=l2s(pass(i,1:2),taxi(j,1:2));
    end
end
save('dist.mat')