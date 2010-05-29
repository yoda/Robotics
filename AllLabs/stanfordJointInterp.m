function M = stanfordJointInterp(varargin)
% Function to perform joint space interpolation control of a stanford type robot
% arm.  
%
% Arguments:
%            offset        - [offset1 offset6] specifyig the two fixed offsets 
%                            that define the arm.
%            initialJoints - a 6-vector specifying the joint positions 
%                            of the robot at its initial position.
%            Tfinal        - The homogeneous transform that describes the
%                            desired effector frame at the robots final position.
%            dt            - The parameter increment rate to use as the robot
%                            travels along the bezier path in joint space.
%
%
% The initial position of the robot arm is specified by the set of initial joint
% positions and the final position is specified by a desired end effector 
% transformation frame.  The function solves the inverse kinematics of the arm for
% the final position and selects the solution that is closest to the initial set of
% joint positions.  A straight line Bezier path in joint space is then generated 
% from the initial joint positions to the final joint positions.  The Bezier path
% is a simple cubic path with control points superimposed at each end of the path
% to ensure start and finish velocities of the joints are zero.  An animation of
% the robot is displayed as it travels along the path.
%
p = inputParser;


% All numerics are valid
p.addRequired('offset', @(a)isvector(a) && length(a) == 2 && isnumeric(a));
p.addRequired('initialJoints', @(a)isvector(a) && length(a) == 6 && isnumeric(a));
p.addRequired('Tfinal', @(a)size(a, 1) == 4 && size(a, 2) == 4 && isnumeric(a));
p.addRequired('dt', @(a)isnumeric(a) && a >= 0 && a <= 1);

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
offset = p.Results.offset;
initialJoints = p.Results.initialJoints;
Tfinal = p.Results.Tfinal;
dt = p.Results.dt;

Tstart = stanford6dof(  initialJoints(1), initialJoints(2), initialJoints(4), initialJoints(5), initialJoints(6), offset(1), offset(2), 'coordframe', 1);


jointArray = invstanford6dof(Tfinal, offset(1), offset(2));
disp(jointArray);


closestJoints = bestJoints(jointArray, initialJoints);

CP = [initialJoints; initialJoints; closestJoints; closestJoints];


P = [];

for t = 0:dt:1
    P(end +1, :) = bezier(t, CP);
end

[nn,mm] = size(P);
clf;
M(nn) = getframe;
for x = 1:1:nn,
    
    BJ = P(x,:);
    clf;
    stanford6dof(BJ(1), BJ(2), BJ(4), BJ(5), BJ(6), offset(1), offset(2), 'coordframe', 0);
    M(x) = getframe;
    
end


