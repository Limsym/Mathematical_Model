%% Q2.3
% clear;clc
load("Q2_1.mat");
load('sQ22','result22');
term=24;
test=[1:402];
ind=zeros(500,24);
spo=0.7848;
result22=round(result22*spo);
result=result22;
%%
for jj=1:term
    for ii=1:402
        ind(ii,jj)=ii;
    end
    w=result22(:,jj)';cg=index{1}(:,1)';
    [h,l]=find(w>6000);
    if isempty(l)==0
        for kk=1:size(h,2)
            hadd(kk)=ceil(w(l(kk))/6000);
            for ll=1:hadd(kk)
                if ll<hadd(kk)
                    if kk==1
                        w(402+ll)=6000;
                        result(402+ll,jj)=6000;
                        cg(402+ll)=cg(l(kk));
                        ind(402+ll)=l(kk)*1000+ll;
                    else
                        w(402+hadd(kk-1)+ll)=6000;
                        result(402+ll,jj)=6000;
                        cg(402+hadd(kk-1)+ll)=cg(l(kk));
                        ind(402+hadd(kk-1)+ll)=l(kk)*1000+ll;
                    end
                else
                    if kk==1
                        w(402+ll)=mod(w(l(kk)),6000);
                        result(402+ll,jj)=mod(w(l(kk)),6000);
                        cg(402+ll)=cg(l(kk));
                        w(l(kk))=0;
                        ind(402+ll)=l(kk)*1000+ll;
                        result(l(kk),jj)=0;
                    else
                        w(402+hadd(kk-1)+ll)=mod(w(l(kk)),6000);
                        result(402+hadd(kk-1)+ll,jj)=mod(w(l(kk)),6000);
                        cg(402+hadd(kk-1)+ll)=cg(l(kk));
                        w(l(kk))=0;
                        ind(402+hadd(kk-1)+ll)=l(kk)*1000+ll;
                        result(l(kk),jj)=0;
                    end
                end
            end
        end
    end
    for kk=1:8
        if kk==1;
            v=cg2v(w,cg,0);
            [product_N sum_W sum_V]=fx23(v,w);
        else
            clear w2 cg2
            for ab=1:size(record2{kk-1,jj},1)
                w2(ab)=w(find(ind(:,jj)==record2{kk-1,jj}(ab)));
                %                 w2=w(record{kk-1,}ia);
                cg2(ab)=cg(find(ind(:,jj)==record2{kk-1,jj}(ab)));
            end
            v2=cg2v(w2,cg2,0);
            [product_N sum_W sum_V]=fx23(v2,w2);
        end
        record11{kk,jj}=[sum_W];
        record12{kk,jj}=[sum_V];
        if kk==1;
            record1{kk,jj}=ind(product_N',jj);
        elseif kk>1
            for ab=1:size(product_N',1)
                record1{kk,jj}(1,ab)= ind(find(ind(:,jj)==record2{kk-1,jj}(product_N(ab))),jj);
            end
        end
        record0{kk,jj}=ind(:,jj);
        if kk==1
            [record2{kk,jj},ia]=setdiff(record0{kk,jj},record1{kk,jj});
        else
            [record2{kk,jj},ia]=setdiff(record2{kk-1,jj},record1{kk,jj});
        end
        if isempty(record2{kk,jj})==1
            % quanbudabaohao
            break
        elseif kk==8 && isempty(record2{kk,jj})~=1
            warning(uep)
        end
        if record2{kk,jj}(1)==0
            record2{kk,jj}(1)=[];
            ia(1)=[];
        end
    end
end
%%
idtr=[6 3 1 5 8 2 7 4];
re23=zeros(402,24*8);
[n,m]=size(record1);
for i=1:n
    for j=1:m
        [n2,m2]=size(record1{i,j});
        for k=1:n2
            for l=1:m2
                obj=record1{i,j}(k,l);
                if obj==0
                    continue
                end
                if obj>1000 
                    x=fix(obj/1000);
                else
                    x=obj;
                end
                if x>402 || x<1
                    warning('uep')
                    return
                end
                y=result(x,j);
                tj=(j-1)*8+idtr(i);
                re23(x,tj)=y;
            end
        end
    end
end


% 
% maxn=inf;
% for i=1:n
%     for j=1:m
%         [n2,m2]=size(record1{i,j});
%         for k=1:n2
%             for l=1:m2
%                                     obj=record1{i,j}(k,l);
% 
%                 if obj<0
%                     continue
%                 end
%                 if obj<maxn
%                     maxn=obj;
%                     aaa=[i j k l];
%                 end
%                     
%             end
%         end
%     end
% end
lps=[1.90476916700000,0.921370417000000,0.186055556000000,1.57048235300000,...
    2.88982530100000,0.543761111000000,2.07883333300000,1.01028275900000]/100;
aaa=[0.6 0.66 0.72];
w=1:24;
for j=1:1:192
    for i=1:402
        if mod(j,8)==0
            jj=8;
        else jj=mod(j,8);
        end
        w=ceil(j/8);
        sp(i,w)=sum(re23(i,1+8*(w-1):8*w))*(1-lps(jj));
    end
end
S=sum(sum(sp));
S-sum(sum(re23))
%%
for ii=1:402
    ida=find(index{1}(:,1)==1)
    sa=sum(re23(ida,:));ssa=sum(sa)*1.2;
    idb=find(index{1}(:,1)==2)
    sb=sum(re23(idb,:));ssb=sum(sb)*1.1;
    idc=find(index{1}(:,1)==3)
    sc=sum(re23(idc,:));ssc=sum(sc);
end



%%

for j=1:8
    for i=1:402
        id1=j+(w-1)*8;
        sp(i,j)=sum(re23(i,id1))*(1-lps(j));% /aaa(index{1,1}(i,1)
    end
end
S=sum(sum(sp))/24;
1-S/sum(sum(re23));
