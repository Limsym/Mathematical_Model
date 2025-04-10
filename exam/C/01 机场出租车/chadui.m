function [ptw0,ptw,chaduihao]=chadui(s2,pipy)
% clear;clc
load('C1_Q1','N');dot=1440;
t1=39;
s1=29;
% s2=5;
t2=t1/s1*s2;
% pipy=98238;
fucm=7.1;                                                                   % fuel_consumption
proi=7.03;                                                                  % oil pricing
ptw0=(s2pi(s2)-s2*fucm/100*proi)/(pipy/12/30/12/60)-t2
ptw=round(ptw0)                                                             % Co=s2*fucm/100*proi;
% ppi1=(t2+tw)*pipy/12/30/12/60;
% ppi2=s2pi(s2)-Co;
%% Now Tell Me The Number
dengdai=N(2,:);
for i=1:dot
    if i<=dot-ptw
        chaduihao(i)=sum(dengdai(i:i+ptw));
    elseif i>dot-ptw
        chaduihao(i)=sum(dengdai(i:dot))+sum(dengdai(1:ptw-dot+i+1));
    end
end
for i=1:dot
    if N(3,i)==0
        chaduihao(i)=0;
    end
end
chaduihao=chaduihao+1;

% for i=1:dot
%     sumleft=0;
%     for j=i:dot
%         sumleft=sumleft+Time_left(j);
%         if sumleft>=Num_Car(i)
%             t_wait(i)=j-i+1;                                                % min
%             break
%         elseif j==dot && sumleft<Num_Car(i)
%             for k=1:dot
%                 sumleft=sumleft+Time_left(k);
%                 if sumleft>=Time_left(i)
%                     t_wait(i)=j-i+k+1;
%                     break
%                 end
%             end
%         end
%     end
% end
end
