function [p1,t1,minS]=dtbt(k,p0,t0)
% p0=p{1,1373};
% t0=t{1,1373};
if isempty(p0)==1 || isempty(t0)==1
    p1=p0;t1=t0;minS=0;
    return
end
n_p0=size(p0,1);
n_t0=size(t0,1);
k=8;
jihe1 = zeros(1,k);
for i=1:n_t0;jihe1(i)=i;end
index=1;

for i1=jihe1
    jihe2=jihe1;
    l=find(jihe1==i1);
    jihe2(l(1))=[];
    for i2=jihe2
        jihe3=jihe2;
        l=find(jihe2==i2);
        jihe3(l(1))=[];
        for i3=jihe3
            jihe4=jihe3;
            l=find(jihe3==i3);
            jihe4(l(1))=[];
            for i4=jihe4
                jihe5=jihe4;
                l=find(jihe4==i4);
                jihe5(l(1))=[];
                for i5=jihe5
                    jihe6=jihe5;
                    l=find(jihe5==i5);
                    jihe6(l(1))=[];
                    for i6=jihe6
                        jihe7=jihe6;
                        l=find(jihe6==i6);
                        jihe7(l(1))=[];
                        for i7=jihe7
                            jihe8=jihe7;
                            l=find(jihe7==i7);
                            jihe8(l(1))=[];
                            for i8=jihe8
                                
                                way(index,:)=[i1 i2 i3 i4 i5 i6 i7 i8];
                                
                                index=index+1;
                            end
                        end
                    end
                end
            end
        end
    end
end
n_w=size(way,1);
s=zeros(1,k);
for i=1:n_w
    for j=1:k
        if way(i,j)==0
            s(i,j)=0;
        elseif way(i,j)<=n_p0
            s(i,j)=l2s([p0(way(i,j),3) p0(way(i,j),4)],[t0(way(i,j),3) t0(way(i,j),4)]);
        end
    end
end

for i=1:n_w
    if way(i,min([n_p0 n_t0]))==0
        S1(i,1)=inf;
    else S1(i,1)=sum(s(i,:));
    end
end
minS=min(S1);
best_h=find(S1==min(S1));
best_h=best_h(1);
best_way=way(best_h,:);
if n_p0<k
    best_way=[best_way(1:n_p0)];
end
% for i=1:k
%     if i<=n_p0
%         real_way(i)=p0{};
%     else real_way(i)=0;
% end
for i=1:k
    if isempty(find(best_way==i))==1
        best_way2(i)=0;
    else best_way2(i)=find(best_way==i);
    end
end
if n_t0<k
    best_way2=[best_way2(1:n_t0)];
end
p1=[p0,best_way'];
t1=[t0,best_way2'];
end