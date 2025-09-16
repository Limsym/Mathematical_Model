%% adjust_loandays.m —— 调整贷款天数
function loanDays = adjust_loandays(day,pay)
loanDays = day;
if pay~="TT"
    loanDays = day + min(day*0.2,7);
end
end
