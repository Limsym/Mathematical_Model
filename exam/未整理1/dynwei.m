% x=[1 2;3 4]
function wei=dynwei(x)
% yuchuli
x=g
w=1./(1+exp(-x))-1/2;
k=[1./sum(w,2)];
wei=w.*k

end