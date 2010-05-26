function CP = startCubicBez(varargin)
% Generates the first two control points of a cubic Bezier curve 
% and stores them in the control point matrix CP as
%
% x0 y0 z0
% x1 y1 z1
%
% P is the position of the first control point, 
% vel is a vector giving the desired velocity (dr/dt) 
% at the start of the curve.

p = inputParser;


% All numerics are valid

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
P = p.Results.P;
