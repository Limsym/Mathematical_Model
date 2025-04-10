clear
z(1)=0;
for x=1:1000
    y(x)=x/6;
    if y(x)==fix(y(x))
        y(x)=x;
        z(x+1)=z(x-5)+y(x);
    else y(x)=0;
    end
end
max(z)