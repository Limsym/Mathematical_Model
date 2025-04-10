function [ds]=crde(x)
ds=zeros(6,5);
ds(1,1)=170 + round(20*rand(1));%+round((150-0).*rand(1));%98 + round((200-98).*rand(1));%98-400
ds(1,2)=330 + round(20*rand(1));%98 + round((350-98).*rand(1));%98-453
ds(1,3)=12;
ds(2,1)=165 + round(20*rand(1));%0-453
ds(2,2)=0;
ds(2,3)=23;
ds(3,3)=32;
min=5;max=10;
ds(3,4)=min + round((max-min)*rand(1));%5 + round((9-5).*rand(1));%0-5
ds(3,5)=ds(3,4) + round(-ds(3,4)*rand(1));%5 + round((ds(3,4)-6).*rand(1));%0-5
ds(6,1)=30 + round(20*rand(1));%0-453
ds(6,2)=10 + round(20*rand(1));%0-453
ds(6,3)=24;
r=0 + round((1-0).*rand(1));%0-1
if r==1
    ds(4,1)=0;
    ds(4,2)=0;
    ds(4,3)=0;
    ds(5,3)=0;
    ds(5,4)=0;
end
end
