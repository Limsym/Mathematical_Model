function paint=paint(x)
if x==1
    %% Q1 市区打车
    load('p1','pass','taxi')
    figure
    c1=scatter(pass(:,2),pass(:,1),1.5,'fill','b');hold on;
    c2=scatter(taxi(:,2),taxi(:,1),1.5,'fill','r');
    legend('乘客位置','出租车位置');
    xlabel('经度(度)');ylabel('纬度(度)');
    set(gca,'child',[c1 c2]);
    x=[-74.05 -73.9];y=[40.6 40.9];
    set(gca,'xTick',x(1):0.05:x(2));set(gca,'yTick',y(1):0.05:y(2));
    axis([x y]);grid on;
    % 然后划定市区
    %     bw0=mean([-74.009109 -74.015725]);                  % 西边界
    %     be0=mean([-73.928465 -73.928908])+0.009;            % 东边界
    %     fb=-0.008;bw=-74.029;be=be0+fb;                     % 边界修正
    %     a0=(40.778714-40.778117)/(-73.977852-(-73.978328)); % 南北边界斜率
    %     fa=1+0.05;a=a0*fa;                                  % 斜率修正
    %     b1=40.69+0.005-a*(-74)-0.007;                       % 下界
    %     b2=40.78-0.005-a*(-74)+0.008;                       % 上界
    %     y1=a*bw+b1;y2=a*be+b1;                              % 下界端点
    %     y3=a*bw+b2;y4=a*be+b2;                              % 上界端点
end