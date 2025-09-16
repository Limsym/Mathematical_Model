%% calc_profit.m —— 成本与利润计算函数
% 功能：计算产品的成本、利润和各项费用，确定最终销售价格
% 输入：
%   proIdx      - 产品索引
%   param       - 参数结构体
%   pay         - 付款条件 ("TT", "DP", "LC", "DA")
%   day         - 付款天数
%   frght       - 运费（人民币）
%   poly_IperN  - 数量折扣函数句柄
% 输出：
%   res         - 结果结构体，包含各项价格信息
%   detail      - 详细信息结构体

function [res, detail] = calc_profit(proIdx, param, pay, day, frght, poly_IperN)

%% ===== 基础参数提取 =====
productWeight = param.weight(proIdx);           % 产品重量 (kg)
unitPriceWithTax = param.tuPrices(proIdx);      % 含税单价 (元/kg)

%% ===== 成本计算 =====
% 含税总成本
totalCostWithTax = unitPriceWithTax * productWeight;

% 不含税成本（考虑退税）
untaxedCost = totalCostWithTax * (1 - param.taxAddValue / (1 + param.taxRetRate));

%% ===== 利润率计算 =====
% 基础利润率：1.25% + 0.25% × (天数/30)
baseProfitMargin = 0.0125 + 0.0025 * day / 30;

% 付款风险调整
paymentRiskFactor = get_payment_risk(pay);
profitMargin = baseProfitMargin * (1 + paymentRiskFactor) * poly_IperN(productWeight);

% 如果设置了固定利润率，则使用固定值
if param.profMargin0 ~= 0
    profitMargin = param.profMargin0;
end

% 注意：利润现在将在方程组中基于销售价格计算

%% ===== 方程组求解 =====
% 定义符号变量
syms insurancePremium interest miscExpenses totalExpenses sellingPrice commission profit

% 贷款天数调整
loanDays = adjust_loandays(day, pay);
interestRate = 0.045;  % 年利率 4.5%

% 方程组定义
% eqn0: 销售价格 = 不含税成本 + 利润 + 总费用 + 委托费
equation0 = sellingPrice == untaxedCost + profit + totalExpenses + commission;

% eqn1: 保险费 = 根据贸易术语计算
equation1 = insurancePremium == get_insurance(sellingPrice, param.Incoterms);

% eqn2: 利息费用 = (含税成本+运费+保险费+杂费) × 利率 × 贷款天数/365
equation2 = interest == (totalCostWithTax + frght + insurancePremium + miscExpenses) * interestRate * loanDays / 365;

% eqn3: 杂项费用 = (含税成本+运费+保险费) × 0.45% + 信用成本 + 清关费
equation3 = miscExpenses == (totalCostWithTax + frght + insurancePremium) * 0.0045 + get_creditcost(pay, param.er) + get_clearance(param.tp);

% eqn4: 委托费 = 销售价格 × 委托费比例
equation4 = commission == sellingPrice * param.CommissionRate;

% eqn5: 利润 = 销售价格 × 利润率（不低于最低利润）
% 使用条件表达式：如果售价×利润率 >= 最低利润，则利润=售价×利润率，否则利润=最低利润
equation5 = profit == sellingPrice * profitMargin;

% eqn9: 总费用 = 保险费 + 运费 + 利息 + 杂费
equation9 = totalExpenses == insurancePremium + frght + interest + miscExpenses;

% 求解方程组
solution = vpasolve([equation0, equation1, equation2, equation3, equation4, equation5, equation9]);

%% ===== 结果打包 =====
% 转换为数值并转换为美元
exchangeRate = param.er;

% 创建结果表格
res.Profit = table(double(solution.profit) / exchangeRate, 'VariableNames', "Profit");
res.TotalExpenses = table(double(solution.totalExpenses) / exchangeRate, 'VariableNames', "TotalExpenses");
res.InsurancePremium = table(double(solution.insurancePremium) / exchangeRate, 'VariableNames', "InsurancePremium");
res.Interest = table(double(solution.interest) / exchangeRate, 'VariableNames', "Interest");
res.MiscExpenses = table(double(solution.miscExpenses) / exchangeRate, 'VariableNames', "MiscExpenses");
res.Commission = table(double(solution.commission) / exchangeRate, 'VariableNames', "Commission");
res.TotalPrice = table(double(solution.sellingPrice) / exchangeRate, 'VariableNames', "TotalPrice");
res.UntaxedCost = table(untaxedCost / exchangeRate, 'VariableNames', "UntaxedCost");

% 计算单价和利润率
res.UnitPrice = res.TotalPrice ./ productWeight;
% 利润率现在是基于售价计算的
res.ProfitMargin = double(solution.profit) / double(solution.sellingPrice);

% 详细信息
detail = struct(...
    'productIndex', proIdx, ...
    'paymentTerm', pay, ...
    'paymentDays', day, ...
    'profitMargin', res.ProfitMargin ...
);

end