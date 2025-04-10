function y=nan2zero(x)
y=x;
ind_nan = find(isnan(x));               % nan的索引
sub_nan = zeros(length(ind_nan),2);     % 行列式矩阵位置索引
for n=1:length(ind_nan)
	[sub_nan(n,1), sub_nan(n,2)] = ind2sub(size(x),ind_nan(n));
end
for ii=1:size(sub_nan,1)
    y(sub_nan(ii,1),sub_nan(ii,2))=0;
end
end