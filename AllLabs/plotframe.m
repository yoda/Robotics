% Function to plot 4 vectors from an origin and applying a
% transformation/rotation. Returns a figure plot.
%
% Usage:  plotframe(T, len, label)
% Where:  
%         T is the transformation/rotation matrix.
%         len is length of the links stretching from the origin.
%         label is a string appended to the 'x', 'y', 'z' labels.
%         
%         Returns a figure plot.
function plotframe(varargin)
    % Parse the parameter to make sure its within the constraints
    p = inputParser;
    % All numerics are valid
    p.addRequired('T', @(a)size(a, 1) == 4 && size(a, 2) == 4 && isnumeric(a));
    p.addParamValue('len', 1, @(a)a > 0 && isnumeric(a));
    p.addParamValue('label', {'', '', ''}, @(a)iscellstr(a) && size(a,1) == 1 && size(a,2) == 3);
    
    try
        % Do the validation of the parameters
        p.parse(varargin{:});
    catch exception
         disp(exception.identifier); % Debug catching correct errors
         rethrow(exception)
        % Only three numeric
        if strcmp(exception.identifier, 'MATLAB:InputParser:UnmatchedParameter')
            warning('plotframe takes 3 numeric parameters')
        end
        % Must be a numeric
%        if strcmp(exception.identifier, 'MATLAB:InputParser:ArgumentFailedValidation')
%            error('Bad arguement, must be a numeric symbol')
%        end
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
            error('trans takes 3 numeric parameters')
        end 
    end
    
    T = p.Results.T;
    len = p.Results.len;
    label = p.Results.label;
    
    disp('Transformation Matrix');
    disp(T);
    
    orig = [[0;0;0;1],[len;0;0;1],[0;len;0;1],[0;0;len;1]];
    disp('Original Matrix')
    disp(orig);
    
    xformed = T * orig;
    
    disp('Final Matrix')
    disp(xformed);
    
    line([xformed(1,1), xformed(1,2)], [xformed(2,1),xformed(2,2)], [xformed(3,1),xformed(3,2)], 'linewidth', 2, 'color', 'red')
    text(xformed(1,2), xformed(2,2), xformed(3,2), strcat('x', label(1,1)))
    
    line([xformed(1,1), xformed(1,3)], [xformed(2,1),xformed(2,3)], [xformed(3,1),xformed(3,3)], 'linewidth', 2, 'color', 'blue')
    text(xformed(1,3), xformed(2,3), xformed(3,3), strcat('y', label(1,2)))
    
    line([xformed(1,1), xformed(1,4)], [xformed(2,1),xformed(2,4)], [xformed(3,1),xformed(3,4)], 'linewidth', 2, 'color', 'green')
    text(xformed(1,4), xformed(2,4), xformed(3,4), strcat('z', label(1,3)))