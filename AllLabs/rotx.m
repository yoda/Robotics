% Function to create a 4x4 rotation matrix around the x axis
% for an angle in radians, accepts negative and positive angles.
%
% Usage:  result = rotx(angle)
% Where:  angle is an angle in radians being -ve or +ve but not 0.
%
%         result = 4x4 Matrix representing the rotation of the specified
%         angle around the x axis.
%

function [T] = rotx(varargin)
    % Parse the parameter to make sure its within the constraints
    p = inputParser;
    % All numerics that are not equal to 0 are valid
    p.addRequired('angle', @(x)isa(x, 'numeric'));
    
    try
        % Do the validation of the parameters
        p.parse(varargin{:});
    catch exception
        % disp(exception.identifier); % Debug catching correct errors
        % Only one numeric
        if strcmp(exception.identifier, 'MATLAB:InputParser:UnmatchedParameter')
            warning('rotx only takes one integer parameter')
        end
        % Must be a numeric
        if strcmp(exception.identifier, 'MATLAB:InputParser:ArgumentFailedValidation')
            error('Bad arguement, must be a numeric symbol and cannot be 0')
        end
        % Does not allow parameters (inputParser parameters)
        if strcmp(exception.identifier, 'MATLAB:InputParser:MustBeChar')
            error('Bad arguement, must be a numeric symbol and cannot be 0')
        end
        % Does not allow parameters (inputParser parameters)
        if strcmp(exception.identifier, 'MATLAB:InputParser:ParamMissingValue')
            error('Bad arguement, must be a numeric symbol and cannot be 0')
        end
        % Must have a numeric parameter
        if strcmp(exception.identifier, 'MATLAB:minrhs')
            error('Bad arguement, must be a numeric symbol and cannot be 0')
        end 
    end
    
    rangle = p.Results.angle;
    
    % Return T
    T = [1, 0, 0, 0
         0, cos(rangle), -sin(rangle), 0
         0, sin(rangle), cos(rangle), 0
         0, 0, 0, 1];