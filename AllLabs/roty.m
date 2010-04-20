% Function to create a 4x4 rotation matrix around the y axis
% for an angle in radians, accepts real and symbolic values.
%
% Usage:  result = roty(angle)
% Where:  angle is an angle in radians or a symbolic.
%
%         result = 4x4 Matrix representing the rotation of the specified
%         angle around the y axis.
%
function [T] = roty(varargin)
    % Parse the parameter to make sure its within the constraints
    p = inputParser;
    % All numerics and symbolics
    p.addRequired('angle', @(x)isa(x, 'numeric') || isa(x, 'sym'));
    
    try
        % Do the validation of the parameters
        p.parse(varargin{:});
    catch exception
        % disp(exception.identifier); % Debug catching correct errors
        % Only one numeric
        if strcmp(exception.identifier, 'MATLAB:InputParser:UnmatchedParameter')
            warning('roty only takes one symbolic or numeric parameter')
        end
        % Must be a numeric
        if strcmp(exception.identifier, 'MATLAB:InputParser:ArgumentFailedValidation')
            error('Bad arguement, must be a numeric or symbol')
        end
        % Does not allow parameters (inputParser parameters)
        if strcmp(exception.identifier, 'MATLAB:InputParser:MustBeChar')
            error('Bad arguement, must be a numeric or symbol')
        end
        % Does not allow parameters (inputParser parameters)
        if strcmp(exception.identifier, 'MATLAB:InputParser:ParamMissingValue')
            error('Bad arguement, must be a numeric or symbol')
        end
        % Must have a numeric parameter
        if strcmp(exception.identifier, 'MATLAB:minrhs')
            error('Bad arguement, must be a numeric or symbol')
        end 
    end
    
    rangle = p.Results.angle;
    T = [ cos(rangle), 0, sin(rangle), 0
          0, 1, 0, 0'
          -sin(rangle), 0, cos(rangle), 0
          0, 0, 0, 1];