%% get_insurance.m —— 保险费计算
function insPrem = get_insurance(selPri,Incoterms)
if Incoterms=="CFR" || Incoterms=="FOB"
    insPrem = 0;
else
    insPrem = selPri*0.0008*(1+0.1)*(1-1); % specialbonus=1
end
end
