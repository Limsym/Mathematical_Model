%% get_creditcost.m —— 信用成本计算
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
