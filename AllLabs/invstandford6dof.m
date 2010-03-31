%  INVSTANFORD6DOF
%
%  Usage:  joint = invstanford6dof(T, offset)
%
%  Function for calculating the inverse kinematics of a full 6 DOF stanford arm
%  Input arguments: T     - The homogeneous transform that describes the
%                           end-effector frame.
%                   offset1 - (The first fixed offset.)
%                   offset2 - (The second fixed offset.)
%  Return value:    joint - a 4x6 element array of joint positions.
%                           There will be four possible solutions, each 
%                           consisting of six joint positions. There will be  
%                           two arm solutions involving two theta1 values
%                           separated by pi, and for each of these arm
%                           solutions there will be two wrist solutions.
%                           (Note: ignore any extra solutions that could
%                           be obtained obtained by adding pi to theta1 and 
%                           using a negative offset on link 3)
% E.g 
%     invstandford6dof(standford6dof(   pi/4, 
%                                       pi/2,
%                                       pi/2,
%                                       pi/2,
%                                       pi/2,
%                                       3,
%                                       2,
%                                       'coordframe', 1) # T
%                       ,3 # offset1
%                       ,2) # offset2
%
function joint = invstanford6dof(varargin)

p = inputParser;

p.addRequired('T', @(a)size(a, 1) == 4 && size(a, 2) == 4 && isnumeric(a));
% All numerics are valid
p.addRequired('offset1', @(a)isnumeric(a));
p.addRequired('offset2', @(a)isnumeric(a));


try
    % Do the validation of the parameters
    p.parse(varargin{:});
catch exception
     disp(exception.identifier); % Debug catching correct errors
     rethrow(exception)
    % Only three numeric
    if strcmp(exception.identifier, 'MATLAB:InputParser:UnmatchedParameter')
        warning('invstandford6dof takes 3 parameters')
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
        error('invstandford6dof takes 3 parameters')
    end 
end

d1 = 5; % base offset 

offset1 = p.Results.offset1;
offset2 = p.Results.offset2;

T6 = p.Results.T;

% Base (Link 1, Joint 1)
T1 = DHtrans(0, d1, 0, pi/2); % theta1 missing
disp('T1');
disp(T1);

% Joint 2
T2 = DHtrans(0, 0, 0, -pi/2); % theta2 missing
T2 = T1 * T2;
disp('T2');
disp(T2);

% Link 2
T3 = DHtrans(0, offset1, 0, 0);
T3 = T2 * T3;
disp('T3');
disp(T3);

% Joint 3
T4 = DHtrans(0, 0, 0, pi/2); % theta3 missing
T4 = T3 * T4;
disp('T4');
disp(T4);

% Joint 4
T5 = DHtrans(0, 0, 0, -pi/2); % theta4 missing
T5 = T4 * T5;
disp('T5');
disp(T5);

% Joint 5
disp('T6');
disp(T6);
