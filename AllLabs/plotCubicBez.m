function plotCubicBez(varargin)
% This function treats the matrix of control points as a sequence of
% groupings of 4 control points at a time.  Each group of 4 control
% points forms a cubic Bezier curve.  The function simply plots each
% cubic curve in sequence.
%
%  Arguments:
%  dt   - the parameter increment size that you want points along the
%         curve to be plotted at.  Remember the parameter varies from
%         0 - 1 along the curve, dt = .01 will give 100 points per curve
%  CP   - a nxm vector of n control points in 3-space.  The  number of
%         control points must be a multiple of 4.
%
%  Produces:
%  - a plot of the characteristic polygon
%  - a plot of the curve as a series of equi-spaced points in terms of
%    the curve parameter t.
%  - a separate plot of velocity variation as a function of the parameter t
p = inputParser;


% All numerics are valid
p.addRequired('dt', @(a)size(a, 1) > 0 && size(a, 2) <= 3 && isnumeric(a));
p.addRequired('CP', @(a)size(a, 1) > 0 && size(a, 2) <= 3 && isnumeric(a));


try
    % Do the validation of the parameters
    p.parse(varargin{:});
catch exception
    disp(exception.identifier); % Debug catching correct errors
    rethrow(exception)
    % Only three numeric
    if strcmp(exception.identifier, 'MATLAB:InputParser:UnmatchedParameter')
        warning('bezier takes 2 parameters')
    end
    % Does not allow parameters (inputParser parameters)
    if strcmp(exception.identifier, 'MATLAB:InputParser:MustBeChar')
        error('Bad arguement, must be a numeric symbol')
    end
    % Does not allow parameters (inputParser parameters)
    if strcmp(exception.identifier, 'MATLAB:InputParser:ParamMissingValue')
        error('Bad arguement, must be a numeric symbol')
    end
    % Must have a numeric parameter
    if strcmp(exception.identifier, 'MATLAB:minrhs')
        error('bezier takes 2 parameters')
    end
end
dt = p.Results.dt;
CP = p.Results.CP;

clf;
axis equal;                            % make x y and z tick sizes equal
grid on;
hold on;

[n, m] = size(CP);


V = [];
pprevious = CP(1,:);
x = pprevious;

for i = 1:4:n
    for t = 0:dt:1
        pnext = bezier(t, CP(i:i+3,:));
        V = [V norm(pnext - pprevious)];
        pprevious = pnext;
        x = [x; pprevious];
    end
end

[n, m] = size(x);
subplot(1,2,1)
if m == 2
    line(CP(:,1),CP(:,2), 'Marker', 'x', 'MarkerEdgeColor','b' );
    line(x(:,1),x(:,2),'LineStyle','none', 'Marker', '.', 'MarkerEdgeColor','r' );
end
if m == 3
    line(CP(:,1),CP(:,2),CP(:,3), 'Marker', 'x', 'MarkerEdgeColor','b' ); 
    line(x(:,1),x(:,2),x(:,3),'LineStyle','none', 'Marker', '.', 'MarkerEdgeColor','r' );
end
subplot(1,2,2), plot(V)

end