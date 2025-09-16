%% quotation_main.m —— 主调度
function [result, detail] = quotation_main(param)

% === 运费 ===
frghts = calc_freight(param);

% === 表格预处理 ===
npro = length(param.tuPrices);
nqty = numel(param.days);
ii = (1:nqty*npro)';

iPro = table(floor((ii-1)/nqty)+1, 'VariableNames',"Product");
M = table(param.weight(iPro.Product), 'VariableNames',"Qty");
Pay = table(param.Pay(mod(ii-1,nqty)+1)', 'VariableNames',"Payment");
Day = table(param.days(mod(ii-1,nqty)+1)', 'VariableNames',"Day");
Frght = table(repmat(frghts/param.er, numel(ii),1), 'VariableNames',"E_tp");
ProfMargin = table(zeros(numel(ii),1),'VariableNames',"Prof(%)");

% === 初始化结果表 ===
Prof = []; Expns=[]; InsPrem=[]; Int=[]; Misc=[]; Commission=[]; TotPri=[]; UTCost=[]; UniPriRmb=[];

% === 多项式折扣函数 ===
poly_IperN = poly_func();

% === 循环计算每个方案 ===
for k=1:numel(ii)
    [res,detail_k] = calc_profit( ...
        iPro.Product(k), ...
        param, ...
        Pay.Payment(k), ...
        Day.Day(k), ...
        Frght.E_tp(k)*param.er, ...
        poly_IperN ...
    );
    % 结果收集
    Prof = [Prof; res.Profit];
    Expns = [Expns; res.TotalExpenses];
    InsPrem = [InsPrem; res.InsurancePremium];
    Int = [Int; res.Interest];
    Misc = [Misc; res.MiscExpenses];
    Commission = [Commission; res.Commission];
    TotPri = [TotPri; res.TotalPrice];
    UTCost = [UTCost; res.UntaxedCost];
    UniPriRmb = [UniPriRmb; res.UnitPrice];
    ProfMargin.("Prof(%)")(k) = res.ProfitMargin;
    detail(k) = detail_k; %#ok<AGROW>
end

% === 单价 ===
UniPri = table(TotPri.("TotalPrice")./M.("Qty"), 'VariableNames',"Unit Price");

% === 汇总表 ===
result = [iPro M Pay Day round(TotPri,2) round(UniPri,2) Prof ProfMargin UTCost Expns Frght InsPrem Int Misc Commission];

end