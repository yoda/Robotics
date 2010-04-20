% Function to create a Denevit hartenberg transformation
% matrix. Returns the transformation matrix.
%
% Usage:  DHtrans(theta, offset, length, twist)
% T = rotz(theta) * trans(0,0,offset) * trans(length,0,0) * rotx(twist);
%
%   = [ cos(theta) -sin(theta)*cos(twist)  sin(theta)*sin(twist) length*cos(theta)
%       sin(theta)  cos(theta)*cos(twist) -cos(theta)*sin(twist) length*sin(theta)
%           0             sin(twist)             cos(twist)         offset
%           0                 0                      0                 1           ];
% Where:  
%         T is the transformation/rotation matrix.
%         len is length of the links stretching from the origin.
%         label is a string appended to the 'x', 'y', 'z' labels.
%         
%         Returns a 4x4 matrix.
function [ T ] = DHtrans( varargin )
    p = inputParser;
        % All numerics are valid
        p.addRequired('theta', @(a)isnumeric(a) || isa(a, 'sym'));
        p.addRequired('offset', @(a)isnumeric(a) || isa(a, 'sym'));
        p.addRequired('length', @(a)isnumeric(a) || isa(a, 'sym'));
        p.addRequired('twist', @(a)isnumeric(a) || isa(a, 'sym'));
        

        try
            % Do the validation of the parameters
            p.parse(varargin{:});
        catch exception
             disp(exception.identifier); % Debug catching correct errors
             rethrow(exception)
            % Only 4 numeric
            if strcmp(exception.identifier, 'MATLAB:InputParser:UnmatchedParameter')
                warning('DHtrans takes 4 numeric parameters')
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
                error('DHtrans takes 4 numeric parameters')
            end 
        end
        
        theta = p.Results.theta;
        offset = p.Results.offset;
        length = p.Results.length;
        twist = p.Results.twist;
        
        T = rotz(theta) * trans(0,0,offset) * trans(length,0,0) * rotx(twist);

end

