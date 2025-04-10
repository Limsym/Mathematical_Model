function distance=l2s(lc0,lc1)
% lc0=p2(v,2:3);lc1=p1(a(ind(i)),2:3);
if isequal(size(lc0),size(lc1))~=1 || isequal(size(lc0),[1,2])~=1
    warning('l2s 维度错误');
    return
end
R=6371;
l0=[cos(deg2rad(lc0(1)))*cos(deg2rad(lc0(2))) cos(deg2rad(lc0(1)))*sin(deg2rad(lc0(2))) sin(deg2rad(lc0(1)))];
l1=[cos(deg2rad(lc1(1)))*cos(deg2rad(lc1(2))) cos(deg2rad(lc1(1)))*sin(deg2rad(lc1(2))) sin(deg2rad(lc1(1)))];
distance=acosd(dot(l0,l1))/180*pi*R;   % .../(norm(l0)*norm(l1))
end