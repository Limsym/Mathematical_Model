function [pa pc RL na nc rs_st Get]=fx3(rs_ow)
sum_ow=sum(rs_ow);
sum_o=sum(sum_ow);
spo=0.7848;
rs_sw=round(rs_ow*spo);
sum_sw=sum(rs_sw);
sum_s=sum(sum_sw);
% spo1pspo0=sum_s/sum_o/spo;% 这是一个小检验，意义不大
term=24;
S=[1:402];
ind=zeros(420,term);
ind(S,:)=ones(402,24).*S';
load('index');
%%
for jj=1:term
    w=rs_sw(:,jj)';cg=index{1}(:,1)';
    [~,S_great]=find(w>6000);
    if isempty(S_great)==0
        for i_S_great=1:length(S_great)
            t_need(i_S_great)=ceil(w(S_great(i_S_great))/6000);
            for i_t_need=1:t_need(i_S_great)
                row = 402 + sum(t_need(1:i_S_great))-(t_need(i_S_great)-i_t_need);
                if i_t_need < t_need(i_S_great)
                    w(row)=6000;
                else
                    w(row)=mod(w(S_great(i_S_great)),6000);
                end
                rs_sw(row,jj)=w(row);
                cg(row)=cg(S_great(i_S_great));
                ind(row,jj)=S_great(i_S_great)*1000+i_t_need;
            end
        end
    end
    w(S_great)=0;
    rs_sw(S_great,jj)=0;
    for i_tr=1:8
        if i_tr==1;
            v=cg2v(w,cg,0);
            [product_N sum_W sum_V]=fx23(v,w,6000);
        else
            clear w2 cg2
            for remain=1:size(record2{i_tr-1,jj},1)
                w2(remain)=rs_sw(find(ind(:,jj)==record2{i_tr-1,jj}(remain)),jj);
                cg2(remain)=cg(find(ind(:,jj)==record2{i_tr-1,jj}(remain)));
            end
            v2=cg2v(w2,cg2,0);
            [product_N sum_W sum_V]=fx23(v2,w2,6000);
        end
        record11{i_tr,jj}=[sum_W sum_V];
        if i_tr==1;
            record1{i_tr,jj}=ind(product_N',jj);
        elseif i_tr>1
            for remain=1:size(product_N',1)
                record1{i_tr,jj}(1,remain)= ind(find(ind(:,jj)==record2{i_tr-1,jj}(product_N(remain))),jj);
            end
        end
        record0{i_tr,jj}=ind(:,jj);
        if i_tr==1
            [record2{i_tr,jj},i_nt]=setdiff(record0{i_tr,jj},record1{i_tr,jj});   % 待转运材料
        else
            [record2{i_tr,jj},i_nt]=setdiff(record2{i_tr-1,jj},record1{i_tr,jj});
        end
        if isempty(record2{i_tr,jj})==1                                     % 全部打包好
            break
        elseif i_tr==8 && isempty(record2{i_tr,jj})~=1
            warning('订购方案过大，无法完全转运，请重新制定')
            return
        end
        if record2{i_tr,jj}(1)==0
            record2{i_tr,jj}(1)=[];
            i_nt(1)=[];
        end
    end
end
%%
idtr=[6 3 1 5 8 2 7 4];
rs_st=zeros(402,24*8);
[n,m]=size(record1);
for i=1:n
    for j=1:m
        [n2,m2]=size(record1{i,j});
        for k=1:n2
            for l=1:m2
                obj=record1{i,j}(k,l);
                if obj==0
                    continue
                elseif obj<=402
                    x=obj;
                else
                    x=fix(obj/1000);
                end
                if x>402 || x<1
                    warning('unexpected')
                    return
                end
                [xnew,~] = find(ind(:,j)==record1{i,j}(k,l));
                y=rs_sw(xnew,j);
                tj=(j-1)*8+idtr(i);
                rs_st(x,tj)=y;
            end
        end
    end
end
%% na nb
ida=find(index{1}(:,1)==1);
idb=find(index{1}(:,1)==2);
idc=find(index{1}(:,1)==3);

na=sum(sum(rs_st(ida,:)));
nb=sum(sum(rs_st(idb,:)));
nc=sum(sum(rs_st(idc,:)));
nn=na+nb+nc;
pa=na/nn;
pb=nb/nn;
pc=nb/nn;
% nc=nc;
%% RL
week=1:24;
lps=[1.90476916700000,0.921370417000000,0.186055556000000,1.57048235300000,...
    2.88982530100000,0.543761111000000,2.07883333300000,1.01028275900000]/100;
for i=1:8
    id1=i+(week-1)*8;
    lose(i,:)=round(sum(sum(rs_st(:,id1)))*lps(i));
end
Ord=sum_o;
ESp=sum_s;
Los=sum(lose);      	% 损耗量
Spl=sum(sum(rs_st));  	% 发货量
Get=Spl-Los;          	% 收货量
RL=Los/Spl;          	% 损耗率
end
