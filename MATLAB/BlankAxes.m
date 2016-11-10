function nax = BlankAxes ()
% Create a new set of blank axes at the same position as the
% existing ones

% $Id: BlankAxes.m 1.3 2006/01/27 Matlab-Plot-v1r3 $

nax = copyobj (gca, gcf);
delete (get (nax, 'Children'));

% No titles, labels or grid for the new axes
axes (nax);	% New axes on top
xlabel ('');
ylabel ('');
zlabel ('');
title ('');

% The new axes are on top, so we make the plot area transparent
% so the original plot shows through
% The new axes handle visibility is set to off so that gca finds
% the old axes
% N.B., The new axes must remain on top; issuing axes(gca)
%       brings the old axes to the top.
set (nax, 'Color', 'none');
set (nax, 'HandleVisibility', 'off');
set (nax, 'Visible', 'on');

set (nax, 'XTick', []);
set (nax, 'YTick', []);
set (nax, 'ZTick', []);

set (nax, 'XTickLabel', []);
set (nax, 'YTickLabel', []);
set (nax, 'ZTickLabel', []);

return
