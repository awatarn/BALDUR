function [Xv, Yv] = quiver_vertices(U,V,X,Y)

%  Magnitude of vector.
MAG = sqrt(U.^2 + V.^2);
size(MAG)

%  Quiver stem half-thickness.
T = MAG/40;

%  Arrowhead thickness.
AH  = MAG/3;            %  Height
AHx = AH/3;             %  Width

%  Solve for angle of quiver relative to x-axis.
THETA = atan2(V,U);
size(THETA)
sinT  = sin(THETA);
cosT  = cos(THETA);

%  Solve for tips of quiver stem.
size(X)
size(U)
size(AH)
size(cosT)
Xa = X + U/2 - AH*cosT;
Xb = X - U/2;
Ya = Y + V/2 - AH*sinT;
Yb = Y - V/2;

%  Solve for quiver arrowhead vertices.
PHI = pi/2 - THETA;
Xt1 = X + U/2;
Yt1 = Y + V/2;
Xt2 = Xa + AHx*cos(PHI);
Yt2 = Ya - AHx*sin(PHI);
Xt3 = Xa - AHx*cos(PHI);
Yt3 = Ya + AHx*sin(PHI);

%  Solve for vertices of quiver stem.
Xa1 = Xa - T*sinT;
Xa2 = Xa + T*sinT;
Xb1 = Xb - T*sinT;
Xb2 = Xb + T*sinT;
Ya1 = Ya + T*cosT;
Ya2 = Ya - T*cosT;
Yb1 = Yb + T*cosT;
Yb2 = Yb - T*cosT;

%  Fill the quiver vertices.
Xv = [Xt1 Xt2 Xa2 Xb2 Xb1 Xa1 Xt3 Xt1];
Yv = [Yt1 Yt2 Ya2 Yb2 Yb1 Ya1 Yt3 Yt1];