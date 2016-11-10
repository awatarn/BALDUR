%% PLOT RMSE of TFTR discharges
clear
close all
clc
%%
NeRMS = [45966	21.97	23.30
45980	17.68	18.36
45984	5.32	5.98
46290	12.40	10.82
50904	11.89	13.01
50911	11.68	11.44
50921	14.60	15.87
62270	21.76	26.05];
mean(NeRMS(:,2:3))

TeRMS = [45966	14.41	14.36
45980	14.67	34.77
45984	10.00	27.59
46290	6.79	50.88
50904	22.63	6.89
50911	25.97	34.63
50921	16.15	8.80
62270	19.80	6.70];
mean(TeRMS(:,2:3))

TiRMS = [45966	17.30	18.62
45980	7.14	18.28
45984	6.98	22.36
46290	17.87	70.49
50904	26.24	13.66
50911	20.86	19.97
50921	21.05	14.13
62270	13.19	11.89];
mean(TiRMS(:,2:3))
%%
% figure(1);
% bar(NeRMS(:,2:3));
% xname ={'45966','45980','45984','46290','50904','50911','50921','62270'};
% set(gca,'xticklabel',xname)
%% parameters for figure and panel size
plotheight=12;
plotwidth=16;
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
        
        if ii==3
            bar(NeRMS(:,2:3));
            ylabel('N$_e$ RMS[\%]','Interpreter','latex','fontsize',fontsize, 'Rotation', 90);
        elseif ii==2
            bar(TeRMS(:,2:3));
            ylabel('T$_e$ RMS[\%]','Interpreter','latex','fontsize',fontsize, 'Rotation', 90);
        elseif ii==1
            bar(TiRMS(:,2:3));
            ylabel('T$_i$ RMS[\%]','Interpreter','latex','fontsize',fontsize, 'Rotation', 90);
        end
        
        
        if ii==subplotsy
            title('RMS Comparison (TFTR)');
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
            xname = num2str(NeRMS(:,1));
            ax=gca;
            set(ax,'xticklabel',xname)
        end

    end
end 
%% Saving eps with matlab 
SAVE_OPTION = 0;
if SAVE_OPTION==1
    filename = sprintf('TFTR_RMS_synopsis');
    print(gcf, '-depsc2','-loose',[filename,'.eps']);
%     set(gcf,'PaperUnits','inches','PaperPosition',[0 0 plotwidth plotheight])
%     print('-dpng', strcat(filename, '.png') , strcat('-r',num2str(ImageDPI)))
end


