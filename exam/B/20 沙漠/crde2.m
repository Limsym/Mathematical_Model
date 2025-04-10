% function [ds]=crde2(x)
% ds = zeros(4,5);
% ds(1,1)=130 + round(20*rand(1));        % 130
% ds(1,2)=400 + round(20*rand(1));        % 405
% ds(1,3)=12;
% % 矿场
% ds(2,1)=0;
% ds(2,2)=0;
% ds(2,3)=23;
% d1 = 3 ;
% ds(2,4)=d1 + round((8-d1).*rand(1));            % 3~6
% ds(2,5)=ds(2,4) - round( 3 * rand(1) );   	% 2~5
% % 村庄
% ds(3,1) = round(100*rand(1));
% ds(3,2) = round(100*rand(1));
% ds(3,3) = 34;
% % 矿场
% ds(4,3) = 46;
% d2 = 6 ;
% ds(4,4) = d2 + round((10-d2).*rand(1)) ;
% ds(4,5) = ds(4,4) - round( 3 * rand(1) ) ;
% end
function [ds]=crde2(x)
ds = zeros(2,5);
ds(1,1)=round(300*rand(1));        % 130
ds(1,2)=round(300*rand(1));        % 405
ds(1,3)=12;
% 矿场
ds(2,1)=0;
ds(2,2)=0;
ds(2,3)=23;
d1 = 3 ;
ds(2,4)=d1 + round((5-d1).*rand(1));            % 3~6
ds(2,5)=ds(2,4) - round( 4 * rand(1) );   	% 2~5
if ds(2,5)<0
    ds(2,5)=1;
end
end

