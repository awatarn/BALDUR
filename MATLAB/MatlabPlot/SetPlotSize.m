function SetPlotSize (pos, units, varargin)
% SetPlotSize  Set the size of the current plot
%   SetPlotSize(pos,units,figurecolor)
%   SetPlotSize(pos,units,options)
%   SetPlotSize(pos)        % default units "inches" assumed
%
% pos   - axes position [xsize, ysize] or
%                       [xleft, ybottom, xsize, ysize] 
% units - units for the dimensions, default 'inches'. The
%         choices are 'centimeters', 'pixels', 'inches',
%         'points', and 'normalized'.
% figurecolor - Figure and axes background color.
%         Use 'none' to get transparent axes.
% options - Paired options, e.g. to set the figure color to
%         transparent, and the axes color to white, use
%           'Color', 'none', 'DefaultAxesColor', 'w'
%
% Note: The 'Units' for the current axes are set to the units
%       specified.  If the units are absolute measurements
%       (i.e. not 'normalized'), then figure can be resized on
%       the screen using the mouse.  This feature can be used to
%       "crop" white space above and to the left of the axes.

% $Id: SetPlotSize.m 1.17 2006/01/27 Matlab-Plot-v1r3 $

% Notes:
% - The default axes position for Matlab is given in normalized
%   units as [0.130 0.110 0.775 0.815].  These values are used
%   to determine the space around the axes.

if (nargin <= 1)
  units = 'inches';
end

Np = length(pos);
if (Np ~= 2 & Np ~= 4)
  error ('SetPlotSize: pos must have 2 or 4 elements');
end

posnorm = [0.130 0.110 0.775 0.815];
if (Np == 2)
  figsize = pos ./ posnorm(3:4);
  axespos = [(posnorm(1:2) .* figsize) pos];
else
  figsize = (pos(1:2) + pos(3:4)) ./ (posnorm(1:2) + posnorm(3:4));
  axespos = pos;
end

% Set the figure
saveunits = get (gcf, 'Units');
set (gcf, 'Units', units);
figpos = get (gcf, 'Position');
set (gcf, 'Position', [figpos(1:2) figsize]);
set (gcf, 'Units', saveunits);

% Set the axes
set (gca, 'Units', units);
set (gca, 'Position', axespos);

Nv = length (varargin);
if (Nv == 1)
  set (gcf, 'Color', varargin{1}, 'DefaultAxesColor', varargin{1});
elseif (Nv > 1)
  set (gcf, varargin{:});
end

disp (sprintf ('SetPlotSize: Figure size: %g x %g', figsize));

return
