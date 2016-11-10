function h = Yaxis (x, varargin)
% h = Yaxis (x, <plot options>)
%
% Generate a Y axis at the given x-value
% This function generates a new (nearly) zero width axes. The
% new axis is placed on top of the existing axis.
%   - position: x-value from the input value
%               y-range from the current axis
%   - ticks: tick labels are turned off. The left and right
%     Y-axes overlap (appearing as a single axis) with the tick
%     marks extending to either side of the axis.
%
% Additional axes property values for this axis can be specified
% in the variable length argument list.
%   - 'Box': Set to 'off' to get ticks only to the right or left
%   - 'YAxisLocation: With 'Box' set to 'off', setting this to
%     'left' gives rightward ticks, while 'right' gives leftward
%     ticks

% $Id: Yaxis.m 1.9 2006/05/31 Matlab-Plot-v1r3 $

XLim = get (gca, 'XLim');
Pos  = get (gca, 'Position');
YTick = get (gca, 'YTick');

if (nargin < 1)
  x = 0;
end

if (x < XLim(1) | x > XLim(2))
  disp ('Yaxis: position off scale');
  h = [];
  return;
end

Peps = 1e-6;
xn = (x - XLim(1)) / (XLim(2) - XLim(1));
xm = xn - 0.5 * Peps;
xp = xn + 0.5 * Peps;

Pos(1) = Pos(1) + xm * Pos(3);
Pos(3) = Peps * Pos(3);

DL = XLim(2) - XLim(1);
XS = XLim(1);
XLim(1) = XS + xm * DL;
XLim(2) = XS + xp * DL;

h = BlankAxes;
set (h, 'Position', Pos, ...
	'Box', 'on', ...
	'XLim', XLim, ...
	'YTick', YTick, ...
	'XTick', [], ...
	'YAxisLocation', 'left', ...
	varargin{:});

return
