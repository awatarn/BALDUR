%Example plotting script for generating high resolution Matlab plots
%suitable for a thesis or paper.
close all
clear all

%Parameters for saved images
ImageDPI=500;
ImageSizeX=6;
ImageSizeY=6;
ImageFontSize=9;
FileLabel='MatlabPlotv1r3';
FontName='Garamond';
AxisFontName='CMU Serif';

%===============
%Generate data to plot
t=linspace(-pi, pi, 201);
signal(1,:)=sin(t);
signal(2,:)=sin(t-1);
signal(3,:)=sin(t-2);
signal(4,:)=sin(t-3);
signal(5,:)=sin(t-4);
signal(6,:)=sin(t-5);
%===============

figure2=figure(2);
%Make dash/dot line styles
Pattern1{1} = []; % Line
Pattern1{2} = [5 -4]; % 5 unit dash, 4 unit blank
Pattern1{3} = [2 -2]; % 2 unit dash, 2 unit blank
Pattern1{4} = [5 -2 1 -2]; % 5 unit dash, 2 unit blank, 1 unit dash, 2 unit blank
Pattern1{5} = [5 -2 1 -2 1 -2]; % 5 unit dash, 2 unit blank, 1 unit dash, 2 unit blank, 1 unit dash, 2 unit blank
Pattern1{6} = [5 -2 2 -2]; % 5 unit dash, 2 unit blank, 2 unit dash, 2 unit blank

%Set the axis limits prior to calling DashLine
axes1=axes('Parent',figure2,...
'Position',[0.131785714285714 0.363963963963964 0.775 0.586800931366149],...
'FontSize',ImageFontSize,...
'FontName',AxisFontName);

axis([min(t) max(t) -1 1]);
axdata=axis;

%Combine data for plot into two arrays
%Number of data sets in the plot
Ngraph=6;
for (i=1:Ngraph)
X1(:,i)=t;
end
Y1(:,1)=signal(1,:);
Y1(:,2)=signal(2,:);
Y1(:,3)=signal(3,:);
Y1(:,4)=signal(4,:);
Y1(:,5)=signal(5,:);
Y1(:,6)=signal(6,:);

%Create the dashed lines
for i=1:Ngraph
[X1d{i} Y1d{i}] = DashLine(X1(:,i), Y1(:,i), Pattern1{i});
end

%Plot the data
h=plot(X1d{1},Y1d{1},'k',...
X1d{2},Y1d{2},'k',...
X1d{3},Y1d{3},'k',...
X1d{4},Y1d{4},'k',...
X1d{5},Y1d{5},'k',...
X1d{6},Y1d{6},'k');
axis(axdata);
set(h(4), 'LineWidth',2)
set(gca,'FontName',AxisFontName,'FontSize',ImageFontSize)

%Legend entries
%IMPORTANT NOTE
%Matlab has problems drawing the box around the legend if the font has been
%changed. The only way that I have found to get around this is to force
%blank spaces at the end of the longest legend entry. In this case 
%the 'Another Signal{ }' has three blank spaces after it.
m1=legend('Signal','Total Signal','Another Signal',...
'Noise', 'More Noise', 'Unknown Noise{ }');
set(m1,'FontName',FontName,'FontSize',ImageFontSize, 'Location','SouthOutside',...
'Position',[0.326807142857143 0.0216096096096096 0.383885714285714 0.246870870870871])
SetLegendProp(m1, 'Pattern', Pattern1);

%Set Axis Font and Size
xlabel('Frequency (Hz)','fontsize',ImageFontSize)
ylabel('Current Noise (A/\surdHz)','fontsize',ImageFontSize)
xlhand=get(gca,'xlabel');
ylhand=get(gca,'ylabel');
set(xlhand,'FontName',FontName);
set(ylhand,'FontName',FontName);

%====================
%Set the image size and save to [FileLabel].png where FileLabel is set at line 11. 
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 ImageSizeX ImageSizeY])
print('-dpng', strcat(FileLabel, '.png') , strcat('-r',num2str(ImageDPI)))