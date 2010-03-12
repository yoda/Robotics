% TRANSSURF
% 
% Function transforms X Y Z matrices defining a parametric surface 
% according to the 4x4 homogeneous transformation T.
% 
% Usage:   [Xt, Yt, Zt] = transsurf(T, X, Y, Z)
%
%     Arguments:   T     - 4x4 homogeneous transformation matrix
%                  X,Y,Z - Matrices defining a parametric surface
%
%     Returns:     Xt,Yt,Zt - Matrices defining the transformed parametric
%                             surface 
%

% Peter Kovesi
% School of Computer Science & Software Engineering
% The University of Western Australia
%
% August 2001 - original version
% August 2006 - cleanup and error checks

function [Xt, Yt, Zt] = transsurf(T, X, Y, Z)

    if nargin ~= 4
	error('Usage: [Xt, Yt, Zt] = transsurf(T, X, Y, Z)');
    end
    
    if ~all(size(X)==size(Y)) || ~all(size(X)==size(Z)) 
	error('X Y and Z matrices must have same dimension');
    end
    
    if ~all(size(T)==[4 4])
	error('T must be a 4x4 homogeneous transformation matrix');
    end
    
    [rows, cols]  = size(X);
    rc = rows*cols;
    
    X = reshape(X,1,rc);   % reshape X Y & Z into row vectors
    Y = reshape(Y,1,rc);
    Z = reshape(Z,1,rc);
    
    one = ones(1,rc);      % A long row vector of ones
    PTS = [X               % Put vectors together to form positions in
	   Y               % in homogeneous coordinates.
	   Z 
	   one];    
    
    PTS = T*PTS;           % Transform the points.
    
    Xt = reshape(PTS(1,:),rows,cols);  % Extract the separate coordinates and
    Yt = reshape(PTS(2,:),rows,cols);  % reshape them back to their original shape.
    Zt = reshape(PTS(3,:),rows,cols);  % We assume scale remains at 1...
    
%--------------------------------------------------------------------




