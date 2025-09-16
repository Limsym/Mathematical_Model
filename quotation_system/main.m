%% main.m  —— 入口脚本
clear; clc; tic; format compact;

% ===== 输入参数 =====
param = struct();
param.Name = ""; 
param.er = 7 + mean([050]) / 1000;             % 汇率
param.days = [0 0 90 180] + 5;                 % 借款到到港时间
param.Pay = ["TT" "DP" "LC" "DA"];             % 付款条件
param.Incoterms = "CIF";                       % 贸易术语
param.taxRetRate = .13;                        % 出口退税率
param.taxAddValue = .13;                       % 增值税
param.weight = [25]';                         % 重量
param.tuPrices = [4500];                        % 含税单价
param.profMargin0 = .005;                       % 固定利润率（可选）
param.CommissionRate = .0;                    % 佣金率
param.ExpUSDPri = 0;                           % 期望美元价格
param.profMin = 500;                           % 最低利润（单件）
param.tp = "air";                              % 运输方式

% ===== 主计算 =====
[result, detail] = quotation_main(param);

% ===== 输出结果 =====
disp(result) %[output:3bde2f19]
toc %[output:3c4f32a5]


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:3bde2f19]
%   data: {"dataType":"text","outputData":{"text":"    <strong>Product<\/strong>    <strong>Qty<\/strong>    <strong>Payment<\/strong>    <strong>Day<\/strong>    <strong>TotalPrice<\/strong>    <strong>Unit Price<\/strong>    <strong>Profit<\/strong>    <strong>Prof(%)<\/strong>    <strong>UntaxedCost<\/strong>    <strong>TotalExpenses<\/strong>     <strong>E_tp<\/strong>     <strong>InsurancePremium<\/strong>    <strong>Interest<\/strong>    <strong>MiscExpenses<\/strong>    <strong>Commission<\/strong>\n    <strong>_______<\/strong>    <strong>___<\/strong>    <strong>_______<\/strong>    <strong>___<\/strong>    <strong>__________<\/strong>    <strong>__________<\/strong>    <strong>______<\/strong>    <strong>_______<\/strong>    <strong>___________<\/strong>    <strong>_____________<\/strong>    <strong>______<\/strong>    <strong>________________<\/strong>    <strong>________<\/strong>    <strong>____________<\/strong>    <strong>__________<\/strong>\n       1       25      \"TT\"        5      14448         577.92       72.24     0.005        13944          432.09        300.84           0              9.973        121.28           0     \n       1       25      \"DP\"        5      14475         579.01      72.377     0.005        13944          459.31        300.84           0             11.986        146.49           0     \n       1       25      \"LC\"       95      15138         605.52       75.69     0.005        13944          1118.7        300.84           0             209.57        608.32           0     \n       1       25      \"DA\"      185      15324         612.96       76.62     0.005        13944          1303.7        300.84           0             394.49        608.32           0     \n","truncated":false}}
%---
%[output:3c4f32a5]
%   data: {"dataType":"text","outputData":{"text":"Elapsed time is 45.356754 seconds.\n","truncated":false}}
%---
