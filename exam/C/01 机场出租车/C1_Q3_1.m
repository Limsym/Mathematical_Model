clear;clc
tc_range=[0.52 1.34];       
tc=mean(tc_range)/60/60;  	% h
k=0.00019;                 % h
L=200/1000;               	% km
l=2.5/1000;
t2=30/60/60;           	    % h
i=1;
for vc=15:0.01:30
    Q=2*L/((tc*t2+t2*k)*vc+(L*tc+L*k+t2*l)+l*L/vc);
    if i==1
        maxQ=Q;
        bestvc=vc;
    elseif Q>maxQ
        maxQ=Q;
        bestvc=vc;
    end
end
bestvc,maxQ
D=bestvc*(tc+k)
n=L/(l+D)