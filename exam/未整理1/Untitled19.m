load('B.mat')
for i=1:153
    SB(:,i)=(B(:,i)-mean(B(:,i)))/std(B(:,i));%%%标准化处理
end
% sdb2T=zeros(1200,153);
% for i=1:1200
%     for j=1:153
%         sdb2T(i+1,j)=sdb2T(i,j)+db2T(i+2800,j);
%     end
% end
% sdb2T(1,:)=db2T(2800,:);
% plot(sdb2T(1201,:))



for i=1:4999
    for j=1:153
        db2T(i,j)=b2T(i+1,j)-b2T(i,j);
    end
end