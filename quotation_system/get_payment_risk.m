%% 其他工具函数
function pma = get_payment_risk(pay)
switch pay
    case "TT", pma=0;
    case "LC", pma=0.05;
    case "DP", pma=0.15;
    case "DA", pma=0.2;
    otherwise, pma=0;
end
end


function insPrem = get_insurance(selPri,Incoterms)
if Incoterms=="CFR" || Incoterms=="FOB"
    insPrem = 0;
else
    insPrem = selPri*0.0008*(1+0.1)*(1-1); % specialbonus=1
end
end

function credCost = get_creditcost(pay,er)
if contains(pay,["LC","DA"])
    docDispFee = max(300,0.00125*10000); % 简化示例
    credCost = (300+125+0+docDispFee+75*er+75+300*er);
elseif contains(pay,"DP")
    credCost = 180;
else
    credCost = 0;
end
end

function fee = get_clearance(tp)
if tp=="EXP"
    fee = 0;
else
    fee = 350;
end
end


