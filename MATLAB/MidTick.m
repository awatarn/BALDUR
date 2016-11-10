function h = MidTick (varargin)
% h = MidTick ([[ax,] Axes])
% h = MidTick ([ax,] <Tick locations>)
% Generate intermediate ticks on a plot axis.
% This function generates intermediate ticks between the
% existing X, Y, or Z axis ticks in a plot. For a linear axis,
% the intermediate ticks (0.75 of the normal length) lie midway
% between the existing ticks. For a log axis, the ticks (0.5 of
% the normal length) lie at 1, 2, ..., 9 times the decade
% points.
%
% There are two basic call sequences.
% (1) Specify the axes to have mid-ticks 'X', 'Y', or 'Y' or a
%     combination.
%     h = MidTick ('XY');
% (2) Specify mid-tick locations using 'XTick', 'YTick', and/or
%     'ZTick'.
%     h = MidTick ('XTick', [x1, ..., xN],...);
% Any remaining arguments are used to set other plot options,
% such as 'TickLength'.
%
% Note that Matlab generates minor ticks for log axes. The only
% reason to have this routine do so for log axes is for those
% cases where some of the minor ticks are missing due to a bug
% in Matlab (for versions up to 7.2 at least).
%
%  A new transparent axis is generated on top of the existing
%  axis. Note that this new axis must remain on top for the
%  newly generated ticks to be visible. The handle for this new
%  axis is returned.
%  *** Invoke this routine after all plotting and labelling is
%      done ***
%  *** It is suggested that the graph limits be set (using
%      a call to 'axis', for instance) before invoking this
%      routine ***

% $Id: MidTick.m 1.22 2006/06/01 Matlab-Plot-v1r3 $

[ax, XA, YA, ZA, varg] = Proc_Args (varargin{:});

Freeze = [];
XTick = [];
YTick = [];
ZTick = [];
if (XA)
  XTick = Gen_Tick (get (ax, 'XTick'), get (ax, 'XScale'));
  if (~ isempty (XTick) & ...
      strcmpi (get (ax, 'XLimMode'), 'auto')) 
    Lim = get (ax, 'XLim');
    set (ax, 'XLim', Lim);
    Freeze = [Freeze 'X'];
  end
end
if (YA)
  YTick = Gen_Tick (get (ax, 'YTick'), get (ax, 'YScale'));
  if (~ isempty (YTick) & ...
      strcmpi (get (ax, 'YLimMode'), 'auto'))
    Lim = get (ax, 'YLim');
    set (ax, 'YLim', Lim);
    Freeze = [Freeze 'Y'];
  end
end
if (ZA)
  ZTick = Gen_Tick (get (ax, 'ZTick'), get (ax, 'ZScale'));
  if (~ isempty (ZTick) & ...
      strcmpi (get (ax, 'ZLimMode'), 'auto'))
    Lim = get (ax, 'ZLim');
    set (ax, 'ZLim', Lim);
    Freeze = [Freeze 'Z'];
  end
end

% Generate short ticks at the mid-points
% There is only one TickLength parameter for the whole plot
% (not one per axis)
if (strcmpi (get (ax, 'XScale'), 'log') || ...
    strcmpi (get (ax, 'YScale'), 'log') || ...
    strcmpi (get (ax, 'ZScale'), 'log'))
  TickLength = 0.5 * get (ax, 'TickLength');
else
  TickLength = 0.75 * get (ax, 'TickLength');
end

h = BlankAxes;
set (h, 'TickLength', TickLength);
set (h, 'XTick', XTick);
set (h, 'XMinorTick', 'off');
if (length (XTick) > 1 )
  set (ax, 'XMinorTick', 'off');
end
set (h, 'YTick', YTick);
set (h, 'YMinorTick', 'off');
if (length (YTick) > 1)
  set (h, 'YMinorTick', 'off');
end
set (h, 'ZTick', ZTick);
set (h, 'ZMinorTick', 'off');
if (length (ZTick) > 1)
  set (h, 'ZMinorTick', 'off');
end

% Appy the rest of the arguments
if (length (varg) > 1)
  set (h, varg{1:2:end}, varg{2:2:end});
end
  
if (~ isempty (Freeze))
  disp (['>>> MidTick - Plot limits (', Freeze, ') frozen']);
end

return

%==========
% Process arguments, filling in defaults
function [ax, XA, YA, ZA, varg] = Proc_Args (varargin)

% Axis, default to gca
if (nargin > 0)
  if (ischar (varargin{1}))
    varargin = {gca, varargin{:}};
  end
end
ax = varargin{1};

% The plot options are paired. If the current number of
% arguments is even, the Axes option is present:
%   ax, Axes, paired-arguments
%   ax, paired-arguments
N = length (varargin);

XA = 0;
YA = 0;
ZA = 0;
if (mod (N, 2) == 0)
  option = varargin{2};
  if (length (varargin) > 2)
    varargin = {varargin{1} varargin{3:end}};    % Remove the
                                                 % argument
  end
  if (~ isempty (strfind (option, 'X')))
    XA = 1;
  end
  if (~ isempty (strfind (option, 'Y')))
    YA = 1;
  end
  if (~ isempty( strfind (option, 'Z')))
    ZA = 1;
  end
end

% Rest of the arguments
varg = {};
if (length (varargin) >= 2)
  varg = {varargin{2:end}};
end

return

%==========
% Generate ticks midway between existing ticks
function htick = Gen_Tick (Tick, Scale)

NTick = length (Tick);
htick = [];

if (NTick > 1)
  if (strcmpi (Scale, 'linear'))
    htick = 0.5 * (Tick(1:NTick-1) + Tick(2:NTick));

  else
    LTick = floor (log10(Tick));
    htick = [1 2 3 4 5 6 7 8 9]' * 10.^LTick;
    htick = (htick(:))';
    htick = htick (htick >= Tick(1) & htick <= Tick(end));
  end

end

return
