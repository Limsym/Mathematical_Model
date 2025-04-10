clear;clc
% cd '�ĳ��Լ�����ġ�Shade���������ڵ�·��'
%% ga�����Ĳ�������
fx = @sharea;            % ������Ӧ�Ⱥ���������ڶ���ĺ�����ǰ�Ӹ�@����
nvars = 5;              % �Ա�������������Ϊ5���Ա���
A = [];  b = [];        % ���Բ���ʽԼ�� Ax \leq b
Aeq = [];  beq = [];    % ���Ե�ʽԼ�� Aeq \cdot x= beq
lb = [165;185;225;245;65];  ub = [185;205;245;265;100];  % ���Ա���x������
nonlcon = [];
%% ����ga��������
% ���ø�ʽ[x_best,fval] = ga(fun,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options); 
% fx�Ǻ�������� nvars��������A,b,Aeq,Beq������Լ����lb,ub����X��Χ��
% nonlcon�Ƿ�����Լ���������Թ滮Ѱ��ʱ��ֵΪ�ռ��ɡ�options���趨�����Ľṹ��
% ������Ҫ���ã��������õ�����Ⱥ��С100���������0.8������200��
options = gaoptimset('PopulationSize',100, 'CrossoverFraction', 0.8, 'Generations', 100);
[x_best, fval] = ga(fx,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options);
%% ��ͼ
[pT,t]=Tv2p([x_best(1:4) 25],x_best(5));
figure
h1=plot(t,pT,'b','LineWidth',4);hold on
h2=plot([0 size(pT,2)/2],[217 217],'r--','linewidth',2);hold on
h3=plot([t(find(pT==max(pT))) t(find(pT==max(pT)))],[0 max(pT)*1.1],'r--','linewidth',2,'Color',[1 0.41 0.16]);hold on
point=8*10^5;
x=unifrnd(t(min(find(pT>=217))),t(find(pT==max(pT))),[1,point]);
y=unifrnd(217,max(pT),[1,point]);
for i=1:point
    for j=min(find(pT>=217)):max(find(pT>=217))
        if x(i) >= t(j) && x(i) <=t(j+1) && y(i) >= pT(j)
            y(i)=[nan];x(i)=[nan];
        end
    end
end
h4=plot(x,y,'--','LineWidth',2,'Color',[0.65 0.65 0.65]);hold on
xlabel('ʱ�� t(s)');ylabel('�¶� u(��)');grid on
legend('¯������','T=217','t=[{T(t)=maxT}]','������Ӱ');hold on
set(gca,'child',[h1 h2 h3 h4])
axis([190 233,210,245])


