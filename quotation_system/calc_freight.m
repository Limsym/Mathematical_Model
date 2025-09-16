%% calc_freight.m —— 运费计算
function frghts = calc_freight(param)
switch param.tp
    case "sea"
        frghts = 0 + param.er*20*0 + (110+param.er*0)*0 + 100 + param.er*4150 + 4500; 
    case "air"
        packWeightRate = .05;% 包装重量率（估计）
        unitPrice = 0;         % 每千克运费
        combinedPrice = 1700;      % 直接给出总价（不按千克计费，通常用于少量货物）
        misc = 0;            % 杂费
        JianDing = 384 * 1;     % 鉴定费用
        ZhengBen = 64  * 1;     % 正本费用
        Rigister = 90 * 0;      % 录入费用（危险品）
        UNBox = 80 * 0;         % UN箱费用（危险品）
        frghts = param.weight.*(1+packWeightRate)*unitPrice + combinedPrice + misc + JianDing + ZhengBen + Rigister + UNBox;
    case "exp"
        frghts = 152*param.weight*1.1;
        param.taxRetRate = 0; % 取消退税
    otherwise
        frghts = 0;
end
if param.Incoterms=="FOB"; frghts=0; end
end
