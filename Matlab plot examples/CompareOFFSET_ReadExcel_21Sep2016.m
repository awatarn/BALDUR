clc
clear
close all
%%
ExcelFilename = 'SummaryRMSE_Offset_Sep.xls';
% data = xlsread(ExcelFilename,'Sheet1','','basic')
sheetName = 'ForMatlab';
[numbers, strings] = xlsread(ExcelFilename,sheetName);
data = numbers;
totalNo = length(data)/2;
%%
NeOffset = [];
TeOffset = [];
TiOffset = [];
for i=0:totalNo-1
    NeOffset = [NeOffset; data(2*i+1,1) data(2*i+1,4) data(2*i+2,4)];
    TeOffset = [TeOffset; data(2*i+1,1) data(2*i+1,6) data(2*i+2,6)];
    TiOffset = [TiOffset; data(2*i+1,1) data(2*i+1,8) data(2*i+2,8)];
end
%% parameters for figure and panel size
plotheight=12;
plotwidth=30;
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
        
        ax=axes('position',sub_pos{i,ii},'XGrid','on','XMinorGrid','on','FontSize',fontsize,'Box','on','Layer','top');
        
        if ii==3
            b = bar(NeOffset(:,2:3));
            set(b(1),'FaceColor',[0 0 1],'LineWidth', 1,'EdgeColor',[0 0 1]);
            set(b(2),'FaceColor',[1 0 0],'LineWidth', 1,'EdgeColor',[1 0 0]);
            ylabel('N$_e$ Offset[\%]','Interpreter','latex','fontsize',fontsize, 'Rotation', 90);
            xlim=get(gca,'xlim');
            hold on
            plot(xlim,[mean(NeOffset(:,2)) mean(NeOffset(:,2))],'--b','linewidth',2)
            plot(xlim,[mean(NeOffset(:,3)) mean(NeOffset(:,3))],'--r','linewidth',2)
            hold off
        elseif ii==2
            b=bar(TeOffset(:,2:3));
            set(b(1),'FaceColor',[0 0 1],'LineWidth', 1,'EdgeColor',[0 0 1]);
            set(b(2),'FaceColor',[1 0 0],'LineWidth', 1,'EdgeColor',[1 0 0]);            
            ylabel('T$_e$ Offset[\%]','Interpreter','latex','fontsize',fontsize, 'Rotation', 90);
            xlim=get(gca,'xlim');
            hold on
            plot(xlim,[mean(TeOffset(:,2)) mean(TeOffset(:,2))],'--b','linewidth',2)
            plot(xlim,[mean(TeOffset(:,3)) mean(TeOffset(:,3))],'--r','linewidth',2)
            hold off            
        elseif ii==1
            b=bar(TiOffset(:,2:3));
            set(b(1),'FaceColor',[0 0 1],'LineWidth', 1,'EdgeColor',[0 0 1]);
            set(b(2),'FaceColor',[1 0 0],'LineWidth', 1,'EdgeColor',[1 0 0]);            
            ylabel('T$_i$ Offset[\%]','Interpreter','latex','fontsize',fontsize, 'Rotation', 90);
            xlim=get(gca,'xlim');
            hold on
            plot(xlim,[mean(TiOffset(:,2)) mean(TiOffset(:,2))],'--b','linewidth',2)
            plot(xlim,[mean(TiOffset(:,3)) mean(TiOffset(:,3))],'--r','linewidth',2)
            hold off
        end
        
        
        if ii==subplotsy
            title('Offset Comparison (TFTR-D3D-JET)');
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
            xtemp = 10:38;
            xname=[' 1';' 2';' 3';' 4';' 5';' 6';' 7';' 8';' 9'; num2str(xtemp')];
%             xname = num2str(NeOffset(:,1));
            ax=gca;
            set(ax,'XLim',[0.5 38.5]);
            set(ax,'XTick',[1:38]);
            set(ax,'XTickLabel',xname)
            xlabel('Discharge Number');
        end

    end
end 
%% Saving eps with matlab 
SAVE_OPTION = 1;
if SAVE_OPTION==1
    filename = sprintf('ALL_Offset');
    print(gcf, '-depsc2','-loose',[filename,'.eps']);
%     set(gcf,'PaperUnits','inches','PaperPosition',[0 0 plotwidth plotheight])
%     print('-dpng', strcat(filename, '.png') , strcat('-r',num2str(ImageDPI)))
end