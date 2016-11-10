function SetPlotFont (FontName, FontSize)
% SetPlotFont - Set font name and size for plots
%   SetPlotFont(FontName,FontSize)
%   SetPlotFont(FontName)          % Default 10 pt font size
%   SetPlotFont                    % Default 10 pt Times

% $Id: SetPlotFont.m 1.3 2006/06/05 Matlab-Plot-v1r3 $
if (nargin < 2)
   FontSize = 10;
end
if (nargin < 1)
   FontName = 'Times';
end

% For figure children, not yet created
set (gcf, ...
   'DefaultTextFontName', FontName, 'DefaultTextFontSize', FontSize, ...
   'DefaultAxesFontName', FontName, 'DefaultAxesFontSize', FontSize, ... 
   'DefaultLineMarkerSize', 0.5*FontSize);
% For axes already set up in the figure
set (gca, ...
   'FontName', FontName, 'FontSize', FontSize);

return
