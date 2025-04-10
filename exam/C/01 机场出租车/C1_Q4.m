clear;clc
load('C1_Q1','N','minu','nc');
s2=[4 5 6 7 8];
pipy=98238;
hours=minu/60;
% h=              	;
% t=                  ;                     % min
% t=h*60;
for i=2
    [ptw0,ptw,thing2]=chadui(s2(i),pipy);
    plot(hours,thing2,'LineWidth',3);hold on;
    xlabel('时间/小时');ylabel('插队序号');grid on
end
legend('短程4km','短程5km','短程6km','短程7km','短程8km')
% hing2(t);
% scatter(hours,thing2,'fill');hold on;
% plot(hours,thing2,'LineWidth',3);hold on;
% plot(hours,thing2,'LineWidth',3);hold on;
% plot(hours,thing2,'LineWidth',3);hold on;
% plot(hours,thing2,'LineWidth',3);
