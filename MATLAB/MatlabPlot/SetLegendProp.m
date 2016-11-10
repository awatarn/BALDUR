function h = SetLegendProp (varargin)
% h = SetLegendProp ([h], 'Property1', Value, ... )
% This routine sets properties for a plot legend. The additional
% pseudo-property 'Pattern' is recognized (see DashLine). The
% legend is also "frozen". Normally, Matlab will redraw the
% legend when the plot is printed. This redrawing may undo
% customizations such as the Pattern lines. The legend Tag is
% nulled out so that the axes box containing the legend is no
% longer recognized as a legend and will not be redrawn.
%
% $Id: SetLegendProp.m 1.4 2006/06/02 Matlab-Plot-v1r3 $

% Find the legend handle
if (ishandle (varargin{1}))
  h = varargin{1};
  varargin(1) = [];
else
  fig = get (gca, 'Parent');
  h = findobj (fig, 'Type', 'axes', 'Tag', 'legend');
end

hsave = gca;

% Pick up the pattern
Pattern = [];
i = 1;
while (i <= length (varargin))
  if (strcmpi (varargin{i}, 'Pattern'))
    Pattern = varargin{i+1};
    varargin(i) = [];
    varargin(i) = [];	
  else
    i = i + 1;
  end
end

% Set the legend options
Nv = length (varargin);
Field = {varargin{1:2:end}};
Value = {varargin{2:2:end}};
set (h, Field, Value);

% Find lines in the legend axis
hl = findobj (h, 'Type', 'line');

% Keep only sample lines
% The lines appear in reverse order to the legend, i.e. most
% recently added first
i = 1;
while (i <= length(hl))
  XData = get (hl(i), 'XData');
  if (length (XData) ~= 2)
    hl(i) = [];
  else
    i = i + 1;
  end
end
hl = flipud (hl);

% Set the patterns
Nl = length (hl);
Np = length (Pattern);
Ns = 0;
for (i = 1:min(Nl,Np))
  if (~ isempty (Pattern{i}))
    XData = get (hl(i), 'XData');
    YData = get (hl(i), 'YData');
    axes (h);	% Bring the legend to the front so that DashLine
                % sees the correct scaling
    [XData, YData] = DashLine_Legend(XData, YData, Pattern{i});
    set (hl(i), 'XData', XData);
    set (hl(i), 'YData', YData);
    Ns = Ns + 1;
  end
end

% To avoid lines in the legend being redrawn when printing
%  - Turn off the legend propery tag
%  - Make the legend axes handle invisible
% Leave the legend on top so that it is not hidden by the plot
set (h, 'Tag', '');
set (h, 'HandleVisibility', 'off');

return
