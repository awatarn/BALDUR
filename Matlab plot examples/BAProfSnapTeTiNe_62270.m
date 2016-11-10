%% Perfect subplot
clear
clc
close all
CurrentDir = pwd;
%%
TokamakName=sprintf('62270');
FolderName=sprintf('n01');

time1 = 3.50;
time2 = 2.90; 
time3 = 4.17;
timeMax = 4.9;
cfutz120 = 48; % the first index for SOL

Rmajor = 2.45;
Rminor = 0.80;
%%

pathOfDirectoryContainingJFile1 = '/Users/Apiwat/Research_plasma/4 SOL/02_Simulations/01_TFTR/62270/n01/';
jFileName1 = 'j62270n01';

pathOfDirectoryContainingJFile2 = '/Users/Apiwat/Research_plasma/4 SOL/02_Simulations/01_TFTR/62270/a01/';
jFileName2 = 'j62270a01';

pathOfDirectoryContainingJFile3 = '/Users/Apiwat/Research_plasma/4 SOL/02_Simulations/01_TFTR/62270_exp/';
jFileName3 = 'prof-exp';

%% ELECTRON DENSITY

sprintf('Working on electron density')
VariableName = ' ne ';
strFilterPageNo = '- 1-';
clear finputf
finputf(1,:)='pageCut_1.txt';
% GET DATA FROM JFILE AND CONVERTED INTO PAGECUT-FILE
foutput=finputf; % uses in ExtractDataFromJFile()
ExtractDataFromJFile(pathOfDirectoryContainingJFile1,...
    jFileName1,foutput,strFilterPageNo,VariableName);
cd(CurrentDir);

% 1 SET PARAMETERS FOR READING PAGECUT-FILE
timeTargetLower = time1; % time interval which contains desire time
timeTargetHigher = timeMax; % time interval which contains desire time
IgnoringLineNumber = 1; % number of lines ignoring after "TIME = XXX s" line
% READING DATA FROM PAGECUT-FILE
clear dataOut
[dataOut, timeOut]=pageCutReading(pathOfDirectoryContainingJFile1,finputf,timeTargetLower,timeTargetHigher,IgnoringLineNumber);
% TRANSFER DATA TO LOCAL VARIABLES
Ne0A = dataOut(:,7)*1e6/1e19;
Ra_Ne0A = (1:length(Ne0A))';
Ra_Ne0A = Ra_Ne0A/cfutz120; % normalized minor radius


% 2 SET PARAMETERS FOR READING PAGECUT-FILE
% GET DATA FROM JFILE AND CONVERTED INTO PAGECUT-FILE
foutput=finputf; % uses in ExtractDataFromJFile()
ExtractDataFromJFile(pathOfDirectoryContainingJFile2,...
    jFileName2,foutput,strFilterPageNo,VariableName);
cd(CurrentDir);
%
timeTargetLower = time2; % time interval which contains desire time
timeTargetHigher = timeMax; % time interval which contains desire time
IgnoringLineNumber = 1; % number of lines ignoring after "TIME = XXX s" line
% READING DATA FROM PAGECUT-FILE
clear dataOut
[dataOut, timeOut]=pageCutReading(pathOfDirectoryContainingJFile2,finputf,timeTargetLower,timeTargetHigher,IgnoringLineNumber);
% TRANSFER DATA TO LOCAL VARIABLES
Ne0B = dataOut(:,7)*1e6/1e19;
Ra_Ne0B = (1:length(Ne0B))';
Ra_Ne0B = Ra_Ne0B/cfutz120; % normalized minor radius


% 3 READING EXPERIMENTAL DATA
IgnoringLineNumber = 3; % number of lines ignoring after "TIME = XXX s" line
VariableName = 'NE';
filename_profexp = sprintf('%s%s-%s-%.2f.dat',pathOfDirectoryContainingJFile3,jFileName3,VariableName,time3);
% READING DATA FROM PROF-EXP
clear dataOut
dataOut = importdata(filename_profexp,' ',IgnoringLineNumber);
% TRANSFER DATA TO LOCAL VARIABLES
Ra_Ne0C = (dataOut.data(:,1)-Rmajor)/Rminor;
Ne0C = dataOut.data(:,2)/1e19;

%% ELECTRON TEMPERATURE
% pathOfDirectoryContainingJFile1 = '/Users/Apiwat/Research_plasma/3 Pellet/Simulation/iter/MMM95/d096/';
% jFileName1 = 'jiterd096';
sprintf('Working on electron density')
VariableName = ' ne ';
strFilterPageNo = '- 1-';
clear finputf
finputf(1,:)='pageCut_1.txt';
% GET DATA FROM JFILE AND CONVERTED INTO PAGECUT-FILE
foutput=finputf; % uses in ExtractDataFromJFile()
ExtractDataFromJFile(pathOfDirectoryContainingJFile1,...
    jFileName1,foutput,strFilterPageNo,VariableName);
cd(CurrentDir);

% 1 SET PARAMETERS FOR READING PAGECUT-FILE
timeTargetLower = time1; % time interval which contains desire time
timeTargetHigher = timeMax; % time interval which contains desire time
IgnoringLineNumber = 1; % number of lines ignoring after "TIME = XXX s" line
% READING DATA FROM PAGECUT-FILE
clear dataOut
[dataOut, timeOut]=pageCutReading(pathOfDirectoryContainingJFile1,finputf,timeTargetLower,timeTargetHigher,IgnoringLineNumber);
% TRANSFER DATA TO LOCAL VARIABLES
Te0A = dataOut(:,3);
Ra_Te0A = (1:length(Te0A))';
Ra_Te0A = Ra_Te0A/cfutz120; % normalized minor radius

% 2 SET PARAMETERS FOR READING PAGECUT-FILE
% GET DATA FROM JFILE AND CONVERTED INTO PAGECUT-FILE
foutput=finputf; % uses in ExtractDataFromJFile()
ExtractDataFromJFile(pathOfDirectoryContainingJFile2,...
    jFileName2,foutput,strFilterPageNo,VariableName);
cd(CurrentDir);
%
timeTargetLower = time2; % time interval which contains desire time
timeTargetHigher = timeMax; % time interval which contains desire time
IgnoringLineNumber = 1; % number of lines ignoring after "TIME = XXX s" line
% READING DATA FROM PAGECUT-FILE
clear dataOut
[dataOut, timeOut]=pageCutReading(pathOfDirectoryContainingJFile2,finputf,timeTargetLower,timeTargetHigher,IgnoringLineNumber);
% TRANSFER DATA TO LOCAL VARIABLES
Te0B = dataOut(:,7)*1e6/1e19;
Ra_Te0B = (1:length(Te0B))';
Ra_Te0B = Ra_Te0B/cfutz120; % normalized minor radius

% 3 READING EXPERIMENTAL DATA
IgnoringLineNumber = 3; % number of lines ignoring after "TIME = XXX s" line
VariableName = 'TE';
filename_profexp = sprintf('%s%s-%s-%.2f.dat',pathOfDirectoryContainingJFile3,jFileName3,VariableName,time3);
% READING DATA FROM PROF-EXP
clear dataOut
dataOut = importdata(filename_profexp,' ',IgnoringLineNumber);
% TRANSFER DATA TO LOCAL VARIABLES
Ra_Te0C = (dataOut.data(:,1)-Rmajor)/Rminor;
Te0C = dataOut.data(:,2);

%% ION TEMPERATURE
% pathOfDirectoryContainingJFile1 = '/Users/Apiwat/Research_plasma/3 Pellet/Simulation/iter/MMM95/d096/';
% jFileName1 = 'jiterd096';
sprintf('Working on electron density')
VariableName = ' ne ';
strFilterPageNo = '- 1-';
clear finputf
finputf(1,:)='pageCut_1.txt';
% GET DATA FROM JFILE AND CONVERTED INTO PAGECUT-FILE
foutput=finputf; % uses in ExtractDataFromJFile()
ExtractDataFromJFile(pathOfDirectoryContainingJFile1,...
    jFileName1,foutput,strFilterPageNo,VariableName);
cd(CurrentDir);

% 1 SET PARAMETERS FOR READING PAGECUT-FILE
timeTargetLower = time1; % time interval which contains desire time
timeTargetHigher = timeMax; % time interval which contains desire time
IgnoringLineNumber = 1; % number of lines ignoring after "TIME = XXX s" line
% READING DATA FROM PAGECUT-FILE
clear dataOut
[dataOut, timeOut]=pageCutReading(pathOfDirectoryContainingJFile1,finputf,timeTargetLower,timeTargetHigher,IgnoringLineNumber);
% TRANSFER DATA TO LOCAL VARIABLES
Ti0A = dataOut(:,5);
Ra_Ti0A = (1:length(Ti0A))';
Ra_Ti0A = Ra_Ti0A/cfutz120; % normalized minor radius

% 2 SET PARAMETERS FOR READING PAGECUT-FILE
% GET DATA FROM JFILE AND CONVERTED INTO PAGECUT-FILE
foutput=finputf; % uses in ExtractDataFromJFile()
ExtractDataFromJFile(pathOfDirectoryContainingJFile2,...
    jFileName2,foutput,strFilterPageNo,VariableName);
cd(CurrentDir);
%
timeTargetLower = time2; % time interval which contains desire time
timeTargetHigher = timeMax; % time interval which contains desire time
IgnoringLineNumber = 1; % number of lines ignoring after "TIME = XXX s" line
% READING DATA FROM PAGECUT-FILE
clear dataOut
[dataOut, timeOut]=pageCutReading(pathOfDirectoryContainingJFile2,finputf,timeTargetLower,timeTargetHigher,IgnoringLineNumber);
% TRANSFER DATA TO LOCAL VARIABLES
Ti0B = dataOut(:,7)*1e6/1e19;
Ra_Ti0B = (1:length(Ti0B))';
Ra_Ti0B = Ra_Ti0B/cfutz120; % normalized minor radius

% 3 READING EXPERIMENTAL DATA
IgnoringLineNumber = 3; % number of lines ignoring after "TIME = XXX s" line
VariableName = 'TI';
filename_profexp = sprintf('%s%s-%s-%.2f.dat',pathOfDirectoryContainingJFile3,jFileName3,VariableName,time3);
% READING DATA FROM PROF-EXP
clear dataOut
dataOut = importdata(filename_profexp,' ',IgnoringLineNumber);
% TRANSFER DATA TO LOCAL VARIABLES
Ra_Ti0C = (dataOut.data(:,1)-Rmajor)/Rminor;
Ti0C = dataOut.data(:,2);


%% parameters for figure and panel size
plotheight=12;
plotwidth=8;
subplotsx=1;
subplotsy=3;   
leftedge=2.0;
rightedge=0.6;   
topedge=1;
bottomedge=1.5;
spacex=2.0;
spacey=1.0;
fontsize=12;  
linewidth=2;
Pattern1 = [5 -4];
sub_pos=subplot_pos(plotwidth,plotheight,leftedge,rightedge,bottomedge,topedge,subplotsx,subplotsy,spacex,spacey);
 
%setting the Matlab figure
f = figure('visible','on');
clf(f);
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [plotwidth plotheight]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 plotwidth plotheight]);
set(gcf, 'color', 'white'); % sets the color to white

%% loop to create axes
for i=1:subplotsx
    for ii=1:subplotsy

        ax=axes('position',sub_pos{i,ii},'XGrid','off','XMinorGrid','off','FontSize',fontsize,'Box','on','Layer','top');

        if ii==1 && i ==1
            plot(Ra_Ti0A,Ti0A,'-b','LineWidth',linewidth);
            hold on
            plot(Ra_Ti0B,Ti0B,'-r','LineWidth',linewidth);
            plot(Ra_Ti0C,Ti0C,'ok','LineWidth',linewidth-1);
            hold off
            ylabel('$T_{i}$ (keV)','Interpreter','latex','fontsize',fontsize, 'Rotation', 90) 
            xlim([0 1.1]);
        elseif ii==2 && i==1
            plot(Ra_Te0A,Te0A,'-b','LineWidth',linewidth);
            hold on
            plot(Ra_Te0B,Te0B,'-r','LineWidth',linewidth);
            plot(Ra_Te0C,Te0C,'ok','LineWidth',linewidth-1);
            hold off
            ylabel('$T_{e}$ (keV)','Interpreter','latex','fontsize',fontsize, 'Rotation', 90) 
            xlim([0 1.1]);
        elseif ii==3 && i==1
            plot(Ra_Ne0A,Ne0A,'-b','LineWidth',linewidth);
            hold on
            plot(Ra_Ne0B,Ne0B,'-r','LineWidth',linewidth);
            plot(Ra_Ne0C,Ne0C,'ok','LineWidth',linewidth-1);
%             time1_legend = sprintf('t=%.2f s',time1);
%             time3_legend = sprintf('t=%.2f s',time3);
%             legend(time1_legend,time3_legend,'Location','SouthWest');
%             legend boxoff              
            hold off
            ylabel('$n_{e}$ ($10^{19}$ m$^{-3}$)','Interpreter','latex','fontsize',fontsize, 'Rotation', 90)
            xlim([0 1.1]);
        end

        if ii==subplotsy
%         title(['Title (',num2str(i),')'])
            title([TokamakName,FolderName]);
        end

        if ii>1
        set(ax,'xticklabel',[])
        end

%         if i>1
%         set(ax,'yticklabel',[])
%         end

%         if i==1
%         % ylabel(['Ylabel (',num2str(ii),')'])
%         ylabel('$<J>$','Interpreter','latex','fontsize',16, 'Rotation', 90)
%         end

        if ii==1
        % xlabel(['Ylabel (',num2str(i),')'])
        xlabel('$r/a$','Interpreter','latex','fontsize',16);
        end

    end
end 
%% Saving eps with matlab 
SAVE_OPTION = 0;
if SAVE_OPTION==1
    filename = sprintf('BBProfEvol_%s%s_test',TokamakName,FolderName);
    print(gcf, '-depsc2','-loose',[filename,'.eps']);
%     set(gcf,'PaperUnits','inches','PaperPosition',[0 0 plotwidth plotheight])
%     print('-dpng', strcat(filename, '.png') , strcat('-r',num2str(ImageDPI)))
end
%% RMSE and Offset
[NeA_RMSE,NeA_Offset] = RMSEandOffset(Ra_Ne0A,Ne0A,Ra_Ne0C,Ne0C);
[NeB_RMSE,NeB_Offset] = RMSEandOffset(Ra_Ne0B,Ne0B,Ra_Ne0C,Ne0C);

[TeA_RMSE,TeA_Offset] = RMSEandOffset(Ra_Te0A,Te0A,Ra_Te0C,Te0C);
[TeB_RMSE,TeB_Offset] = RMSEandOffset(Ra_Te0B,Te0B,Ra_Te0C,Te0C);

[TiA_RMSE,TiA_Offset] = RMSEandOffset(Ra_Ti0A,Ti0A,Ra_Ti0C,Ti0C);
[TiB_RMSE,TiB_Offset] = RMSEandOffset(Ra_Ti0B,Ti0B,Ra_Ti0C,Ti0C);

table1 = [NeA_RMSE NeA_Offset TeA_RMSE TeA_Offset TiA_RMSE TiA_Offset]
table1 = [table1; NeB_RMSE NeB_Offset TeB_RMSE TeB_Offset TiB_RMSE TiB_Offset]
