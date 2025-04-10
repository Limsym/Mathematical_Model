function [pi,R,C]=s2pi(s)
if s>=29 g=1;else g=0;end
sqb=3;Rqb=11;
scc=10;Rcc=3.75;
prtl=20;
C0=2;
if s<=sqb
    R=Rqb;
elseif s>sqb && s<=scc
    R=s*Rqb/sqb;
else R=10*Rqb/sqb+(s-scc)*Rcc;
end
R=R+prtl*g;Ct=prtl*g;
fucm=7.10;               % fuel_consumption
proi=7.03;              % oil pricing
Co=s*fucm/100*proi;
C=Co+Ct+C0;
pi=R-C;
end
