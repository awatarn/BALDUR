function AvgData = GetAverageData(TimeEvoData,kind,time1,time2)
    if kind==1 % current
        ind = find(TimeEvoData.t_new>time1 & TimeEvoData.t_new<=time2);
        Ifrac = TimeEvoData.J_boot_new./TimeEvoData.J_tor_new;
        TimeEvoData.jFileName
        IbsItot = mean(Ifrac(ind(1):ind(length(ind))))        
        AvgData = IbsItot;
    elseif kind == 2 % NEVAVO
        ind = find(TimeEvoData.x_NEVAVO>time1 & TimeEvoData.x_NEVAVO<=time2);
        NEVAVO = TimeEvoData.y_NEVAVO;
        TimeEvoData.TokamakName;
        disp(TimeEvoData.FolderName)
        AvgData = mean(NEVAVO(ind(1):ind(length(ind))))
    elseif kind == 2.1 % NEVAVO
        ind = find(TimeEvoData.x_Ne0>time1 & TimeEvoData.x_Ne0<=time2);
        Ne0 = TimeEvoData.y_Ne0;
        TimeEvoData.TokamakName
        TimeEvoData.FolderName
        AvgData = mean(Ne0(ind(1):ind(length(ind))))
    elseif kind == 3 % WTOT
        ind = find(TimeEvoData.x_WTOT>time1 & TimeEvoData.x_WTOT<=time2);
        WTOT = TimeEvoData.y_WTOT;
        display(TimeEvoData.TokamakName)
        display(TimeEvoData.FolderName)
        AvgData = mean(WTOT(ind(1):ind(length(ind)))) 
    elseif kind == 4 % POHT
        ind = find(TimeEvoData.x_POHT>time1 & TimeEvoData.x_POHT<=time2);
        POHT = TimeEvoData.y_POHT;
        display(TimeEvoData.TokamakName)
        display(TimeEvoData.FolderName)
        AvgData = mean(POHT(ind(1):ind(length(ind)))) 
    elseif kind == 5 % P_alpha
        ind = find(TimeEvoData.x_PA>time1 & TimeEvoData.x_PA<=time2);
        PA = TimeEvoData.y_PA;
        display(TimeEvoData.TokamakName)
        display(TimeEvoData.FolderName)
        AvgData = mean(PA(ind(1):ind(length(ind))))         
    end
end