cd("D:\Program Files\Polyspace\R2021a\bin\win64\0\mine\GAME")
clear;clc;tic
DtBs = DEq();
num = size(DtBs.Eq.name);
x = 1:num ;
m = 6;
DPlan = nchoosek(x,m);
EnemyName = "射手";
id = 1;
for i = 1:size(DPlan,1)
    plan = DPlan(i,:);
    res = test(plan,EnemyName);
    Res(id,:) = res;
    id = id + 1;
end
% format long g
Result = sort1(Res);% clear Res res plan;
Result_0WuShu = shaixuan(Result,"巫术");
toc
% function prac
% % 冷却中？
% timetick = 0.25;
% time = 0:timetick:6
% yanchi = 2;
% mingzhong = [0,0+yanchi];
%
% mj.cdin = 3;
%
% for time = 0:timetick:6
%     % cd中
%     if Eq(1)==1
%         if time == mingzhong
%             ing =
%         end
%     else
%
%     end
%
% end
% % 生效
%
% end

function Output = sort1(Input,whom)
% ? whom
for i = 1:size(Input,1);
    Input(i).Recv = floor(Input(i).Recv);
    According(i,1) = Input(i).Recv;
end
[D,I] = sort(According,'descend');
Output = Input(I,:);
end

function Out = shaixuan(In,who)
DtBs = DEq(); ids = find(DtBs.Eq.name==who);
id = 1;
for i = 1:size(In,1);
    if In(i).EqPick01(ids)==0
        pick(id) = i;
        id = id+1;
    end
end
Out = In(pick,:);
end

function res = test(plan,EnemyName)
%% 决策变量
g.get = plan; % [1,6,2,3,4,7];

% EnemyName = "射手";
[Eq,g] = equip(g);
% DtBs = DEq(); Eq.name = DtBs.Eq.name; 
GetName = Eq.name(g.get)'; res.GetName = string(GetName);
GetName1 = GetName(1); i = 1;
while i<length(plan)
    i = i+1;
    GetName1 = string(GetName1) + ' ' + string(GetName(i));
end
% 信息
jc.AP = 0;
jc.ew = 0;
% Inscriptions
% 铭文    r	b 10狩猎	g 10心眼
mw.AP = 0;
mw.fc = 88;
mw.ew = 0;
% 装备；Equipments, Outfit
[Eq,g] = equip(g);
EqPick01 = zeros(g.NumEq,1);
EqPick01(g.get) = 1;

%% 约束条件
zb.AP = sum(Eq.AP(g.get));      % 不考虑毁灭特效的增益
zb.ew = sum(Eq.HP(g.get));

% huimie = 0.3;
% fqxs = 1 + huimie * EqPick01(3);
% AP = (jc.AP + mw.AP + zb.AP) * fqxs; g.AP = AP ;

ewsm = jc.ew + mw.ew + zb.ew;
jn = 2 ;
switch jn
    case 1 % 技能 1
        jineng='桑木为引';  % 桑木为引，1技能
        SkillLv = 6;        % 请输入
        MaxSkLv = 6;        % 并验证
        if SkillLv > MaxSkLv
            warning(SkillLv)
        end
        yhzl = 5;           % 萤火之力
        sh.skill.SkillBasicDamage = 500+(SkillLv-1)*100;
        zhiliao = 200+50*(SkillLv-1);
        GiveYhc = yhzl+(-floor(yhzl/5))*(yhzl-5); % 给出萤火虫的数量
        sh.skill.yhcDamage = GiveYhc* (50 + 0.1*AP + 0.04*ewsm); % 萤火虫造成的伤害量
        sh.skill.SumGiven = sh.skill.SkillBasicDamage + sh.skill.yhcDamage;
        zl1 = GiveYhc* (50 + 0.1*AP + 0.02*ewsm);
        kz.jifei = 1;% 控制
        sh.skill.kAP = 0;
    case 2 % 孙膑-1
        jineng='桑木为引';  % 桑木为引，1技能
        SkillLv = 6;        % 请输入
        MaxSkLv = 6;        % 并验证
        if SkillLv > MaxSkLv
            warning(SkillLv)
        end
        sh.skill.SkillBasicDamage = 720 + (SkillLv-1)*175;
        sh.skill.kAP = .72; % 萤火虫造成的伤害量
        kz.jiansu = .4; % 控制
end

% 计算 装备特效 伤害总量
time = 0 ;
e = enemy(EnemyName);
[tx] = texiao(EqPick01,time,g,e);
% if EqPick01(1)==1
%     tx.damage(1) = e.HP(1)*(1-(1-0.03)^1) + e.HP(e.time)*(1-(1-0.03)^3);
%     % 这样算，仍然高估了面具效果
% end
% 准备伤害属性
% 穿透
sh.fc = mw.fc+tx.fc ;
sh.fcl = tx.fcl ;
% 计算伤害总量
sh.skill.APAdd = sh.skill.kAP*AP;
sh.skill.SumGiven = sh.skill.SkillBasicDamage + sh.skill.kAP*AP;

sh.given.skill = sh.skill.SumGiven;
sh.given.tx = tx.SumDamage ;
sh.given.sum = sh.given.skill + sh.given.tx;
sh.SumGivenMagic = sh.given.sum;% 提级
% 计算反馈：接受到的伤害总量
[sh,e] = shang(sh,e,tx);
res.EqPick01 = EqPick01';
res.GetName1 = GetName1;
res.AP = AP;
res.HP = sum(Eq.HP.*EqPick01);
res.CD = sum(Eq.CD.*EqPick01);
res.Recv = sh.RecvMagic(2);
res.sh = sh;
% time = 1 ;
% [tx1] = texiao(EqPick01,time,g,e)
% sh.given.tx = tx.damage
% sh.given.sum = sh.Given.skill;
% [sh,e] = shang(sh,e,tx)
% sh.tx = tx.damage ;
% sh.given1 = sh.given+sh.tx ;
end


% DataBase
function DtBs = DEq()
DtBs.Eq.name = split(['面具 回响 帽子 日暮 法穿杖 冰杖 大书 吸血书 金剑 巫术 预言 衣服 辉月 炽热']);

end

% Equipments
function [Eq,g] = equip(g)
DtBs = DEq(); Eq.name = DtBs.Eq.name;

% [health;]
Eq.D = [800 0 0 500 500 600 0 1000 0 440 800 1000 0 0
    120 240 240 140 240 160 400 180 140 180 160 160 160 200]';
Eq.NumEq = size(Eq.D,1);
g.NumEq = Eq.NumEq;
Eq.ID = 1:Eq.NumEq';
Eq.HP = Eq.D(:,1);
Eq.AP = Eq.D(:,2);
Eq.CD = [5 0 0 10 0 5 10 10 0 0 0 0 10 0]'/100;
Eq.cata = ones(1,size(Eq.D,1));
Eq.cata([5,7]) = 0;
Eq.show = [split('名称 生命 法强')';Eq.name,num2cell(Eq.D)];
% ```排序规则
% mode 1, 技能>普攻>半肉>保命；输出>防御

end

% 特效
function tx = texiao(EqPick01,time,g,e)
tx.damage = zeros(1,g.NumEq);
% Default
tx.fc = 0; tx.fcl = 0; tx.ky.ky = 0; tx.zs.all = 0;
for id = 1:size(g.get,2)
    i = g.get(id);
    switch i
        case 1
            if EqPick01(i)==1 && time == 0
                tx.damage(i) = e.HP(e.time)*(1-(1-0.03)^1);
            end
        case 2
            if EqPick01(i)==1 && time==0
                tx.damage(i) = g.AP*0.4 + 100;
            else
            end
        case 4
            cs = 10;
            tx.fc = 28*cs;%[14 28]
        case 5
            tx.fcl = 0.45;
        case 7
            tx.ky.ky = 1;
            zs = floor(g.AP/100)*.8/100;
            if zs>.12
                zs = .12;
            end
            tx.ky.zs = zs;
            tx.zs.all(1) = tx.ky.zs;
            % cengshu
        case 6
            if EqPick01(i)==1 && time == 0
                tx.damage(i)=400*EqPick01(6);
            end
        case 10
            tx.damage(i) = 0.7 * g.AP + 80; % 不准确
    end
end
tx.SumDamage = sum(tx.damage);
tx.zs.sum = sum(tx.zs.all);
tx.SumZs = tx.zs.sum;
end

% 计算伤害、是否击杀
function [sh,e] = shang(sh,e,tx,n)
k = 602;

kk = ceil((e.fk-sh.fc)/9999);% whether e.fk > s.fc
yxfk = (e.fk-sh.fc)*kk*(1-sh.fcl);  % youxiaofakang
sh.bilv = (k/(k+yxfk)) * (1-e.ms);
sh.ms = 1-sh.bilv ;
if exist('n')==0
    sh.bilv = [sh.bilv, sh.bilv * (1+tx.SumZs)];% 前者忽略增伤，后者考虑了增伤
    sh.RecvMagic = sh.given.sum * sh.bilv ;
    e.HP(e.time+1) = e.HP(e.time) - sh.RecvMagic(2) ;
    if e.HP(length(e.HP))<=0
        sh.kill = "死亡";
    else sh.kill = "生存";
    end
    e = ee(e);
end
end

% Refresh Enemy
function e = ee(e)
e.ID = length(e.HP) ;
e.per = e.HP(e.time)/e.MaxHP ;
end

% Enemy All
function e = enemy(n)
if exist('n')==1 && n=="战士"
    e.name = '400,8285' ;
    e.fk = 400;
    e.HP = 8285;
    e.MaxHP = 8285;
    e.ms = 0;
    e = ee(e) ;
elseif exist('n')==1 && n=='射手'
    e.name = '射手' ;
    e.fk = 160;
    e.HP = 6000;
    e.MaxHP = 6000;
    e.ms = 0;
    e = ee(e) ;
elseif exist('n')==1 && n=='lan lv1'
    e.name = 'lan lv1' ;
    e.fk = 210;
    e.HP = 8285;
    e.MaxHP = 8285;
    e.ms = 0;
    e = ee(e) ;
else warning('Enemy')
end
end

