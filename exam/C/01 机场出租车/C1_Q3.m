clear;clc
tc_range=[0.52 1.34];       
tc=mean(tc_range)/60/60;  	% h
k=0.019/50;                 % h
L=200/1000;               	% km
l=2.5/1000;
t2=30/60/60;           	    % h
i=1;
for vc=10:1/100:20
    Q=2*L/(tc*t2*vc+L*tc+L+l*L/vc);
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