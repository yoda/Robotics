function CP = stopCubicBez(varargin)
% This function generates the last two control
% points of a previous curve to finish off a sequence
% of cubic Bezier curves.
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

CP = [  CP;
        P - vel/3;
        P ];
end