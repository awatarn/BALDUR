function CO = SetPlotColors (Colors)
% CO = SetPlotColors (Colors)
% This routine sets the default colors for plot lines. The
% default settings override the lighter standard Matlab colors.
% These darker colors are rendered better on a black and white
% printer.
%
% The input cell array can be used to override the default
% colors set by this routine. Any empty cells in the input leave
% the corresponding colors unchanged.
%   SetPlotColors({[]; [0 0.2 0]});    % Darker green
%
% N.B. Call this routine before plotting

% $Id: SetPlotColors.m 1.3 2006/01/27 Matlab-Plot-v1r3 $

% Original colors
Blue        = [ 0    0    1    ];
Green       = [ 0    0.5  0    ];      % Mid-green
Red         = [ 1    0    0    ];
Cyan        = [ 0    0.75 0.75 ];
Magenta     = [ 0.75 0    0.75 ];
Yellow      = [ 0.75 0.75 0    ];
Gray        = [ 0.25 0.25 0.25 ];

% Darker colors
DarkCyan    = [ 0    0.6  0.6  ];
DarkMagenta = [ 0.5  0    0.5  ];
DarkYellow  = [ 0.6  0.6  0    ];

if (nargin < 1)
  Colors = {[]; []; []; []; []; [];};
end

CO = get (gcf, 'DefaultAxesColorOrder');
% Matlab cycles through the first six of these colors
CO(4:6,:) = [DarkCyan; DarkMagenta; DarkYellow];

% Insert the user defined colors
NC = length (Colors);
for (i = 1:NC)
  if (~ isempty (Colors{i}))
    CO(i,:) = Colors{i};
  end
end

% Set the color order
set (gcf, 'DefaultAxesColorOrder', CO);

return
