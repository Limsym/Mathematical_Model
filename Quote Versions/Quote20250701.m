clear, clc, 
tic, 
format compact
%%
%[text] ## 输入参数
Name = ""; % optional
er = mean([150]) / 1000 + 7;         % 汇率
days = [0 0 90 180] + 5;  % 参数2：从 借款 到 货物到港装运 的时间
Pay = ["TT" "DP" "LC" "DA"];
Incoterms = "CIF";
taxRetRate = .13;       % 出口退税率
taxAddValue = .13;
weight = [25]';         % 重量
tuPrices = [3000];      % 含税单价
profMargin0 = .005 * 1; % 给定利润比例
CommissionRate = .03        % 佣金比例 %[output:7f0093e8]
ExpUSDPri = [2900];
if ExpUSDPri>0; ExpRMBPri = er* ExpUSDPri /(1+taxRetRate); disp(["期望人民币价" ExpRMBPri]); end %[output:51deb364]
n = length(weight);
profMin = ones(n,1)*[500];          % 最低利润（预留空间）考虑了支出少算的情况
tp = "air";
switch tp
    case "sea"
        % 运费(海) = 进仓费 + 立方费(汇率*单价*立方) + 打托费[(单价1+单价2)*打托次数] + 每票 + 整柜费用 + 港杂费
        % m3 = []; % 立方
        frghts = 0 + er*20*0 + (110 + er*0)*0 + 100 + er*4150 + 4500; 
    case "air"
        KGex = 1600;
        kgex = [0]';
        miscex = 0;
        JianDing = 384;
        EnableJianDing = 1;
        ZhengBen = 64;
        EnableZhengBen = 1;
        frghts = [ KGex + weight.*kgex + miscex + JianDing * EnableJianDing + ZhengBen * EnableZhengBen ]; % 运费(空) 重量 鉴定(北京) 正本
    case "exp"
        frghts = 152*weight*1.1;
        taxRetRate = 0;         % 取消退税
end
if Incoterms == "FOB"; tp=0; frghts=0; end
% 默认参数
lcbRatio = 1;           % 信用证承担比例
%% 预处理
npro = length(tuPrices);
nqty = size(days,2);
ii = 1:(nqty*npro);
ipro = [floor((ii-1)/nqty) + 1]';
% 预分配内存
iPro = table(ipro, 'VariableNames', "Product");
unimat = zeros(nqty*npro,1);
% unimat(:,:) = weight(ipro);
M = table(weight(ipro),'VariableNames', "Qty");
% unimat(:,:) = frghts(ipro);
Frght = table(ones(length(Pay),1).*(frghts/er),'VariableNames', "E_tp");
iPay = table([mod(ii-1,nqty) + 1]', 'VariableNames', "iPayment");
Pay = table(Pay([mod(ii-1,nqty) + 1]')', 'VariableNames', "Payment");
Day = table(days([mod(ii-1,nqty) + 1])', 'VariableNames', "Day");
ProfMargin = table(zeros(nqty*npro,1),'VariableNames',"Prof(%)");
poly_IperN = poly_func();
% 计算报价
for ii=1:nqty*npro
    %% 产品
    pro = table2array(iPro(ii,1));
    tuPrice =  tuPrices(pro);
    m =  weight(pro);
    %% 客方
    pay =  table2array(Pay(ii,1));
    day =  table2array(Day(ii,1));
    %% 我方
    loanDays = day;     % 贷款时间
    loanDays(pay ~= "TT") = day(pay ~= "TT") + min(day(pay ~= "TT") * .2, 7);
    frght =  Frght{ii,1} * er;
    % 计算含税成本
    taxCost = tuPrice * m;
    % 计算不含税成本
    untaxCost = taxCost * ( 1 - taxAddValue/(1 + taxRetRate) );
    UTCost(ii,:) = table(untaxCost/er,'VariableNames',"Untaxed Cost");
    untaxunitprice = untaxCost/m;
    tax = taxCost - untaxCost;
    % 利润率
    profMargin = 0.0125 + .0025 * day/30;
    % 风险（付款）加成率
    switch pay
        case "TT"
            pma = 0;
        case "LC"
            pma = .05;
        case "DP"
            pma = .15;
        case "DA"
            pma = .2;
    end
    disc = poly_IperN(m); 
    profMargin = profMargin * (1 + pma) * disc; % 货量加成率
    if profMargin0 ~= 0
        profMargin = profMargin0;
    end
    prof = untaxCost * profMargin;
    prof = max (prof, profMin(iPro{ii,1}));
    ProfMargin{ii,1} = prof / untaxCost;

    syms insPrem int selPri misc expns 
    % 计算利润
    % 计算售价
    eqn0 = selPri == untaxCost + prof + expns;
    % 计算保费
    if Incoterms == "CFR" || Incoterms == "FOB" ;
        eqn1 = insPrem == 0;
    else
        insRate = 0.0008;   % 保险费率
        insSurchg = 0.1;    % 保险加成率
        specialbonus = 1;   % 特别补贴：公司全额承担中信保
        eqn1 = insPrem == selPri * insRate * (1 + insSurchg) * (1-specialbonus);
    end
    % 计算利息
    intrRate = 0.045;       % 利息率
    loanAmt = taxCost + frght + insPrem + misc ;
    eqn2 = int == loanAmt * intrRate * loanDays / 365;
    % 计算杂项
    misPerc = .01 * .45;     % 杂项系数 原.2%, 报关费约.3%
    eqn6 = [];
    credCost = 0;
    % 付款条件
    if contains(pay, 'LC') || contains(pay, 'DA') 
        notFee = 300;                    % 通知费（Notification Fee）
        amdFee = 125;                    % 修改费（Amendment Fee）
        sndNotFee = 0;                   % 二次通知费（Second Notification Fee）
        docDispFee = 300;                % 单据处理费（Document Dispatch Fee），初始值
        docDispFee = max(docDispFee, untaxCost * 0.00125); % 若未税成本较高，按千分之1.25计提更高单据处理费
        docPostFee = 400;                % 单据邮寄费（Document Postage Fee）
        discFee = 75 * er;               % 贴现费（Discount Fee），按汇率转换（er为汇率）
        telFee = 75;                     % 电报费（Telecommunication Fee）
        forBankFee = 300 * er;           % 外方银行手续费（Foreign Bank Fee），按汇率转换
        credCost = (notFee + amdFee + sndNotFee + docDispFee + discFee + telFee + forBankFee) * lcbRatio;
        % 信用证总成本（CredCost），乘以分摊比例lcbRatio
    elseif contains(pay, 'DP')
        credCost = 180;
    end
    if tp=="EXP"
        BaoGuanFei = 0;
    else BaoGuanFei = 350;
    end
    % 
    eqn3 = misc == (taxCost + frght + insPrem) * misPerc + credCost + BaoGuanFei;
    % 计算费用
    eqn9 = expns == insPrem + frght + int + misc;

    % 求解方程组
    Sol = vpasolve([eqn1, eqn2, eqn3, eqn0, eqn6, eqn9]);
    Prof(ii,:) = table(double(prof)/er,'VariableNames',"Prof");
    Expns(ii,:) = table(double(Sol.expns/er),'VariableNames',"Expn");
    InsPrem(ii,:) = table(double(Sol.insPrem/er),'VariableNames',"E_insp");
    Int(ii,:) = table(double(Sol.int/er),'VariableNames',"E_inte");
    Misc(ii,:) = table(double(Sol.misc/er),'VariableNames',"E_misc");
    TotPri(ii,:) = table(double(Sol.selPri/er),'VariableNames',"Total Price");
    UniPriRmb(ii,:) = TotPri(ii,:)./m;
end
UniPri = table(TotPri.("Total Price")./M.("Qty"), 'VariableNames',"Unit Price");

result = [iPro M Pay Day round(TotPri,2) round(UniPri,2) Prof ProfMargin UTCost Expns Frght InsPrem Int Misc] %[output:78512ad2]
open result
toc %[output:0ca2e32b]
%%
function poly_IperN = poly_func()
% 给定的坐标点
x = [500 5000, 10000, 20000, 40000];
y = [1 0.95, 0.9, 0.85, 0.8] ;
% 使用 polyfit 找到最佳拟合的多项式
% 这里我们使用一个三次多项式（因为我们有四个点）
p = polyfit(x, y, 3);
% 创建一个匿名函数来表示这个多项式
poly_IperN = @(xx) polyval(p, xx);
end


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":26.7}
%---
%[output:7f0093e8]
%   data: {"dataType":"textualVariable","outputData":{"name":"CommissionRate","value":"0.0300"}}
%---
%[output:51deb364]
%   data: {"dataType":"text","outputData":{"text":"    \"期望人民币价\"    \"18349.5575\"\n","truncated":false}}
%---
%[output:78512ad2]
%   data: {"dataType":"tabular","outputData":{"columnNames":["Product","Qty","Payment","Day","Total Price","Unit Price","Prof","Prof(%)","Untaxed Cost","Expn","E_tp","E_insp","E_inte","E_misc"],"columns":14,"dataTypes":["double","double","string","double","double","double","double","double","double","double","double","double","double","double"],"header":"4×14 table","name":"result","rows":4,"type":"table","value":[["1","25","\"TT\"","5","9.7433e+03","389.7300","69.9301","0.0075","9.2828e+03","390.5791","286.4336","0","6.7028","97.4428"],["1","25","\"DP\"","5","9.7698e+03","390.7900","69.9301","0.0075","9.2828e+03","417.1131","286.4336","0","8.0619","122.6176"],["1","25","\"LC\"","95","1.0366e+04","414.6500","69.9301","0.0075","9.2828e+03","1.0136e+03","286.4336","0","142.8593","584.3309"],["1","25","\"DA\"","185","1.0492e+04","419.6900","69.9301","0.0075","9.2828e+03","1.1397e+03","286.4336","0","268.9117","584.3309"]]}}
%---
%[output:0ca2e32b]
%   data: {"dataType":"text","outputData":{"text":"Elapsed time is 8.837222 seconds.\n","truncated":false}}
%---
