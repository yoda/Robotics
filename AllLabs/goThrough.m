function CP = goThrough(varargin)
% This function generates the last two control points of a previous curve and the first two control points of a subsequent curve and appends them to CP. P is the position of the end of the last curve/start of next curve. vel is the required rate and direction, dr/dt, at which you want to travel through the point P.
%   x0 y0 z0 |- from a previous call to startCubicBez or goThrough
%   x1 y1 z1 |
%
%   x2 y2 z2 |- two new control points to complete previous curve
%   x3 y3 z3 |
%
%   x0 y0 z0 |- two new control points to start next curve
%   x1 y1 z1 |

p = inputParser;


% All numerics are valid
p.addRequired('CP', @(a)size(a, 1) > 0 && size(a, 2) > 0 && isnumeric(a));
p.addRequired('P', @(a)size(a, 1) > 0 && size(a, 2) <= 3 && isnumeric(a));
p.addRequired('vel', @(a)size(a, 1) > 0 && size(a, 2) <= 3 && isnumeric(a));

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
vel = p.Results.vel;
CP = p.Results.CP;
P = p.Results.P;
