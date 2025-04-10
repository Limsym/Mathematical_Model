function [ds]=crde(x)
[130 405     ]
ds = zeros(3,5);
ds(1,1)=130 + round((150-100).*rand(1));
ds(1,2)=405 + round((350-98).*rand(1));
ds(1,3)=12;
d1 = 3;
ds(1,4)=d1 + round((6-d1).*rand(1));          % 3~6
ds(1,5)=2 + round((ds(1,4)-d1).*rand(1));    % 2~5
ds(2,1)=0;
ds(2,2)=0;
ds(2,3)=23;
ds(3,4)=1 + round((6-1).*rand(1));
ds(3,5)=1 + round((ds(3,4)-2).*rand(1));
end
