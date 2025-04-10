clc
clear
B1=[1 5 6 13 0 0 1];B2=[1 4 6 13 0 0 2];B3=[1 4 3 9 10 13 3];
B4=[1 2 3 9 10 13 4];B5=[1 2 3 9 11 13 5];B6=[1 4 3 9 11 13 6];
miu1=0;miu2=0;miu3=0;miu4=0;miu5=0;miu6=0;miu7=0;miu8=0;miu9=0;miu10=0;
miu11=0;miu12=0;miu13=0;miu14=0;
for i=1:6
   if B1(1,i)==B3(1,i)&&B1(1,i+1)==B3(1,i+1)
       miu1=miu1+1;
   end
   if B1(1,i)==B4(1,i)&&B1(1,i+1)==B4(1,i+1)
        miu2=miu2+1;
   end
   if B1(1,i)==B5(1,i)&&B1(1,i+1)==B5(1,i+1)
        miu3=miu3+1;
   end
   if B1(1,i)==B6(1,i)&&B1(1,i+1)==B6(1,i+1)
        miu4=miu4+1;
   end
   if B2(1,i)==B3(1,i)&&B2(1,i+1)==B3(1,i+1)
        miu5=miu5+1;
   end
   if B2(1,i)==B4(1,i)&&B2(1,i+1)==B4(1,i+1)
        miu6=miu6+1;
   end
   if B2(1,i)==B5(1,i)&&B2(1,i+1)==B5(1,i+1)
        miu7=miu7+1;
   end
  if B2(1,i)==B6(1,i)&&B2(1,i+1)==B6(1,i+1)
        miu8=miu8+1;
  end
  if B3(1,i)==B4(1,i)&&B3(1,i+1)==B4(1,i+1)
        miu9=miu9+1;
  end
  if B3(1,i)==B5(1,i)&&B3(1,i+1)==B5(1,i+1)
         miu10=miu10+1;
  end
   if B3(1,i)==B6(1,i)&&B3(1,i+1)==B6(1,i+1)
        miu11=miu11+1;
   end
   if B4(1,i)==B5(1,i)&&B4(1,i+1)==B5(1,i+1)
         miu12=miu12+1;
   end
  if B4(1,i)==B6(1,i)&&B4(1,i+1)==B6(1,i+1)
        miu13=miu13+1;
  end
   if B5(1,i)==B6(1,i)&&B5(1,i+1)==B6(1,i+1)
        miu14=miu14+1;
   end
end
