nodk=12;
while nodk==12
    tic
    if nodk==0
        x0=1:19;
    else
        sjs=randperm(50);
        sjs2=round(rand(1)*8)+17;
        x0=[sjs(1:sjs2)];% 17-25 家
    end
    if isok(x0)==1
        odk=1;disp('good'),disp(nodk)
        nodk=nodk+1;
        crt{nodk,1}=x0;
        [N rs]=fx22(x0);
        [pa pc RL na nc]=fx3(x0,rs);
        crt{nodk,2}=[pa pc na nc N RL];
    end
    toc
end