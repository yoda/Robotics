function plotbezier(varargin)
%  Arguments:
%  dt   - the parameter increment size that you want points along the 
%         curve to be plotted at.  Remember the parameter varies from 
%         0 - 1 along the curve, dt = .01 will give 100 points
%  CP   - a nxm vector of n control points in 2 or 3-space 
%
%  Produces:
%  - a plot of the characteristic polygon
%  - a plot of the curve as a series of equi-spaced points in terms of
%    the curve parameter t.
%  - a separate plot of velocity variation as a function of the parameter t
p = inputParser;


% All numerics are valid
p.addRequired('dt', @(a)isnumeric(a) && a >= 0 && a <= 1);
p.addRequired('CP', @(a)size(a, 1) > 0 && size(a, 2) > 0 && isnumeric(a));

try
    % Do the validation of the parameters
    p.parse(varargin{:});
catch exception
     disp(exception.identifier); % Debug catching correct errors
     rethrow(exception)
    % Only three numeric
    if strcmp(exception.identifier, 'MATLAB:InputParser:UnmatchedParameter')
        warning('plotbezier takes 2 parameters')
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
        error('plotbezier takes 2 parameters')
    end 
end
dt = p.Results.dt;
CP = p.Results.CP;

clf;
% Figure Settings
XMIN = 0;
XMAX = 5;
YMIN = 0;
YMAX = 5;
axis equal;                            % make x y and z tick sizes equal
axis([XMIN XMAX YMIN YMAX]); % set ranges in x y and z
grid on;
hold on;

plot(CP(:,1), CP(:,2), 'X');
x = 0;
while x <= 1,
    P = bezier(x, CP);
    plot(P(1), P(2), '.');
    x = x + dt;
end

end