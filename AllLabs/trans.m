% Function to create a 4x4 translation matrix accepts 
% negative and positive angles.
%
% Usage:  result = trans(x, y, z)
% Where:  x, y and z being a numeric value or a symbolic.
%
%         result = 4x4 Matrix representing the specified
%         translation.
%
function [T] = trans(varargin)
    % Parse the parameter to make sure its within the constraints
    p = inputParser;
    % All numerics are valid
    p.addRequired('x', @(a)isa(a, 'numeric') || isa(a, 'sym'));
    p.addRequired('y', @(a)isa(a, 'numeric') || isa(a, 'sym'));
    p.addRequired('z', @(a)isa(a, 'numeric') || isa(a, 'sym'));
    
    try
        % Do the validation of the parameters
        p.parse(varargin{:});
    catch exception
         disp(exception.identifier); % Debug catching correct errors
        % Only three numeric
        if strcmp(exception.identifier, 'MATLAB:InputParser:UnmatchedParameter')
            warning('trans takes 3 numeric or symbolic parameters')
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
            error('Bad arguement, must be a numeric pr symbol')
        end
        % Must have a numeric parameter
        if strcmp(exception.identifier, 'MATLAB:minrhs')
            error('trans takes 3 numeric parameters')
        end 
    end
    
    x = p.Results.x;
    y = p.Results.y;
    z = p.Results.z;
    
    T = [ [1, 0, 0, x]
          [0, 1, 0, y]
          [0, 0, 1, z]
          [0, 0, 0, 1] ];