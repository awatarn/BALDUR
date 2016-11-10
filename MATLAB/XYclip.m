function [u,v] = XYclip (x, y, Axes)
% Clip plot vectors
% This routine clips an array of plot vectors so that vectors
% that are completely outside the clipping rectangle are
% eliminated.
%  x - vector of X coordinates
%  y - vector of Y coordinates
%  Axes - 4 element vector specifying the clipping rectangle
%        [xmin xmax ymin ymax]. If this argument is missing, the
%        clipping rectangle is taken from the current axes
%        limits (use the axis command to set this before calling
%        this routine).

% $Id: XYclip.m 1.6 2006/01/31 Matlab-Plot-v1r3 $

% Notes:
% - This is not a full clipping algorithm. Vectors straddling
%   the clipping rectangle are left in place. Points between
%   invisible segments are replaced by NaN.

N = length (x);
if (N ~= length(y))
  error ('XYclip: Unequal length vectors');
end

if (nargin <= 2)
  Figs = get (0, 'Children');
  if (isempty (Figs))
    fprintf ('>>> Warning, axis size and limits are undefined\n');
  else
    XLimMode = get (gca, 'XLimMode');
    YLimMode = get (gca, 'YLimMode');
    if (strcmp (XLimMode, 'auto') | strcmp (YLimMode, 'auto'))
      fprintf ('>>> Warning, axis limits not explicitly set\n');
    end
  end
  Axes = axis;
end

% Set the location code for each point as the sum of
%  0 - The point is within the rectangle
%  1 - The point is to the Left of the rectangle
%  2 - The point is to the Right of the rectangle
%  4 - The point is Below the rectangle
%  8 - The point is Above the rectangle
% If the x is NaN, vpos is 0
vpos = (x < Axes(1)) + 2*(x > Axes(2)) + 4*(y < Axes(3)) + ...
        8*(y > Axes(4));

% Determine the visibility of each segment
% Segment i is between points i and i+1
%  0 - inside or partly inside the rectangle
%  1 - completely outside the rectangle
segvis = (bitand(vpos(1:N-1), vpos(2:N)) ~= 0);

% For the visibility of each point
%  0 - left and right segments are at least partially visible
%  1 - one side is visible, the other at least partially visible
%  2 - both sides invisible
% First point: segment to left is invisible
% Last point: segment to right is invisible
ptvis = [segvis 1] + [1 segvis];

% Set the output values
u = x;
v = y;
ind = (ptvis >= 2);	% Points with adjacent invisible segments
u(ind) = NaN;
v(ind) = NaN;

ind2 = ((ind + [1 ind(1:N-1)]) >= 2);	% Redundant NaN's
u(ind2) = [];
v(ind2) = [];
Nu = length (u);
if (isnan(u(Nu)))
  u(Nu) = [];
  v(Nu) = [];
end

fprintf ('XYclip: No. points (in/out): %d/%d\n', N, ...\
         length (u));

return
