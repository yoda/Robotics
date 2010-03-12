% XCYLINDER
%
% Generates an n-sided cylinder with the axis centred on the x axis
% running from xmin to xmax.
%
% Usage:  [X,Y,Z] = xcylinder(radius, xmin, xmax, roundness, n, T)
%
% Arguments:  radius     - Radius of cylinder to generate
%             xmin, xmax - x coordinates defining the positions of the ends
%                          of the cylinder along the x axis
%             roundness  - Parameter controlling the 'roundness' of the ends
%                          of the generated cylinder.  A small value (say,
%                          0.1) produces square ends. A value around 1 will
%                          produce rounded ends. Larger values make the ends
%                          pointed. 
%             n          - Optional parameter specifying the number of
%                          subdivisions on the parametric surface. This
%                          specifies the sizes of X, Y and Z. Defaults to 20.
%             T          - Optional 4x4 homogeneous transformation matrix to
%                          be used to transform the generated surface to a
%                          desired position and orientation.
% Returns:
%             X, Y, Z    - Matrices specifying the parametric surface.
%
% If the result is not assigned to any output arguments the function
% plots the surface for you, otherwise the x, y and z parametric
% coordinates are returned for subsequent display using, say, SURFL.
%
% See also: zcylinder, superquad, transsurf

% Peter Kovesi
% School of Computer Science & Software Engineering
% The University of Western Australia
%
% July 2006 

function [X,Y,Z] = xcylinder(radius, xmin, xmax, roundness, n, T)

    if nargin < 5
	n = 20;
    end
    if nargin < 4
	roundness = 0.05;
    end
    if nargin < 6
	T = eye(4);
    end
    [X,Y,Z] = zcylinder(radius, xmin, xmax, roundness, n, T*roty(pi/2));

    if nargout == 0   % Assume we want the surface drawn
	surfl(X,Y,Z); shading interp
	clear X Y Z;  % ... and do not return any values
    end    
    
%---------------------------------------------------------------------
