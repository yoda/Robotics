% Function to create a 4x4 rotation matrix around the x axis
% for an angle in degrees, accepts negative and positive angles.
%
% Usage:  result = rotx(angle)
% Where:  angle is an angle in degrees being -ve or +ve but not 0.
%
%         result = 4x4 Matrix representing the rotation of the specified
%         angle around the x axis.
%

function [T] = rotx(varargin)
    % Parse the parameter to make sure its within the constraints
    p = inputParser;
    p.addRequired('angle', @(x)x ~= 0 && isa(x, 'numeric'));
    
    try
        p.parse(varargin{:});
    catch exception
        disp(exception.identifier);
        if strcmp(exception.identifier, 'MATLAB:InputParser:UnmatchedParameter')
            warning('rotx only takes one integer parameter')
        end
        if strcmp(exception.identifier, 'MATLAB:InputParser:ArgumentFailedValidation')
            error('Bad arguement, must be a numeric symbol and cannot be 0')
        end
        MATLAB:InputParser:MustBeChar
        MATLAB:InputParser:ParamMissingValue
        MATLAB:minrhs
            
    end
    angle = p.Results.angle;
    
    rangle = angle * pi / 180;
    T = [1, 0, 0, 0
         0, cos(rangle), -sin(rangle), 0
         0, sin(rangle), cos(rangle), 0
         0, 0, 0, 1];