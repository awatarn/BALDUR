function [xd, yd] = DashLine (x, y, pattern, DataPt)
% [xd, yd] = DashLine (x, y, pattern [, DataPt])
% Generate data with general dash/dot line styles
%  - x: vector of X-values
%  - y: vector of Y-values
%  - pattern: vector of pattern lengths. These are alternating
%    on (positive) / off (negative) values. The absolute value
%    of each element is the length in points. The pattern is
%    repeated as needed.
%  - PtData: Optional two element conversion factor. If this
%    parameter is not supplied, this routine calculates this
%    value based on the current axis limits and axis sizes.
%    - PtData(1): X data units per point (1/72 inch)
%    - PtData(2): Y data units per point (1/72 inch)
%    If the data is to be plotted on a log scale (as indicated
%    by the XScale and YScale properties of the current plot),
%    the conversion correponding factor is log10(units) per pt.
%
% [xd yd]: output data points consisting of visible segments
%    separated by NaN values
%
%  Notes:
%    - To determine the proper lengths of the segments, the size
%      of the plot and the data ranges to be plotted have to be
%      known.
%        SetPlotSize([xdim, ydim], 'centimeters');
%        axis ([Xmin Xmax Ymin Ymax]);
%    - For log plots, this routine needs to know if a plot is
%      log or not.
%        set (gca, 'XScale', 'log')  % Use log X

% $Id: DashLine.m 1.8 2006/01/27 Matlab-Plot-v1r3 $

N = length (x);
if (N ~= length(y))
  error ('DashLine: x and y vectors not the same length');
end

XScale = 'linear';
YScale = 'linear';
if (nargin < 4)
  [DataPt, XScale, YScale] = SFdataXpt;
end

LogX = strcmp (XScale, 'log');
LogY = strcmp (YScale, 'log');
if (LogX)
  x = log10 (x);
end
if (LogY)
  y = log10 (y);
end

% Flag for long lines (could generate huge number of dashes)
Wlong = 0;
Winf = 0;
if (length (pattern) == 0)
  Maxdp = Inf;    % No pattern
else
  LenPat = sum (abs (pattern));
  Maxdp = 1000 * LenPat;
end

[vis, remain, m] = RemPat (pattern, 0);

k = 0;
xp = x(1);
yp = y(1);

for (i = (1:N))
  dx = x(i) - xp;
  dy = y(i) - yp;
  dp = sqrt ((dx / DataPt(1))^2 + (dy / DataPt(2))^2);

  if (~ isfinite (dp))
    % NaN end point or infinite line segment
    if (isinf (dp))
      if (~ Winf)
        fprintf ('>>> DashLine - Infinite line segment(s) omitted\n');
      end
      Winf = Winf + 1;
    end
    xp = x(i);
    yp = y(i);
    [vis, remain, m] = RemPat (pattern, 0);  % Reset the pattern
    continue;  % Get the next point
  end
  
  if (dp >= Maxdp)
    if (~ Wlong)
      fprintf ('>>> DashLine - Long line segment, dashes turned off\n');
    end
    Wlong = Wlong + 1;
    xp = x(i);
    yp = y(i);
    k = k + 1;
    xd(k) = xp;
    yd(k) = yp;
    continue;  % Get the next point
  end
    
  while (dp >= remain)
    % Finished a pattern segment
    % Update the position if the visibility changes
    [visN, remainN, m] = RemPat (pattern, m);
    if (vis ~= visN)
       fract = remain / dp;
      xp = xp + fract * dx;
      yp = yp + fract * dy;
      if (vis)
        k = k + 1;
        xd(k) = xp;        % End a visible segment
        yd(k) = yp;
      else
        k = k + 1;
        xd(k) = NaN;       % End an invisible segment
        yd(k) = NaN;
        k = k + 1;
        xd(k) = xp;        % Start a visible segment
        yd(k) = yp;
      end
      remain = remainN;          % Switched visibility
    else
      remain = remain + remainN; % Same visibility
    end
    vis = visN;
    dx = x(i) - xp;
    dy = y(i) - yp;
    dp = sqrt ((dx / DataPt(1))^2 + (dy / DataPt(2))^2);
  end

  % Reached a data point without finishing a pattern segment
  xp = x(i);
  yp = y(i);
  if (vis)
    k = k + 1;
    xd(k) = xp;
    yd(k) = yp;
  end
  remain = remain - dp;
end

if (LogX)
    %Note this line was modified from xd=10^xd;
  xd = 10.^xd;
end
if (LogY)
    %Note this line was modified from yd=10^yd;
  yd = 10.^yd;
end

return

%===========
function [vis, remain, m] = RemPat (pattern, m)
% Get the next pattern element (increment m, modulo the number
% of pattern elements)

Lp = length (pattern);
if (Lp <= 0)
  m = 1;
  remain = Inf;
  vis = 1;
else
  m = mod (m, Lp) + 1;
  remain = abs (pattern(m));
  vis = (pattern(m) > 0);
end

return
