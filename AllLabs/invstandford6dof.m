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
%                                       'coordframe', 0) # T
%                       ,3 # offset1
%                       ,2) # offset2
%
function joint = invstandford6dof(varargin)

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

% Figure Settings
XMIN = -10;
XMAX = 10;
YMIN = -10;
YMAX = 10;
ZMIN = 0;
ZMAX = 10;
axis equal;                            % make x y and z tick sizes equal
axis([XMIN XMAX YMIN YMAX ZMIN ZMAX]); % set ranges in x y and z
hold on;                               % freeze the current axis settings
grid on;

d1 = 5; % base offset 

offset1 = p.Results.offset1;
offset2 = p.Results.offset2;

T6 = p.Results.T;

% Base (Link 1, Joint 1)
T1 = DHtrans(0, d1, 0, pi/2); % theta1 missing
plotframe(T1, 'len', 2, 'label', {'-1', '-1', '-1'});
disp('T1');
disp(T1);

% Joint 2
T2 = DHtrans(0, 0, 0, -pi/2); % theta2 missing

plotframe(T2, 'len', 2, 'label', {'-2', '-2', '-2'});
disp('T2');
disp(T2);

% Link 2
T3 = DHtrans(0, offset1, 0, 0);

disp('T3');
disp(T3);

% Joint 3
T4 = DHtrans(0, 0, 0, pi/2); % theta3 missing

plotframe(T4, 'len', 2, 'label', {'-3', '-3', '-3'});
disp('T4');
disp(T4);

% Joint 4
T5 = DHtrans(0, 0, 0, -pi/2); % theta4 missing

plotframe(T5, 'len', 2, 'label', {'-4', '-4', '-4'});
disp('T5');
disp(T5);

T7 = DHtrans(pi/2,offset2,0,0);

% Joint 5
disp('T6');
plotframe(T6, 'len', 2, 'label', {'-5', '-5', '-5'});
disp(T6);


xcylinder(0.1, -0.1, 0.1,1, 20, T6);

orig = [[0;0;0;1],[1;0;0;1],[0;1;0;1],[0;0;1;1]];
col1temp = (T6 * orig);
col1 = [col1temp(1,1);col1temp(2,1);col1temp(3,1);col1temp(4,1)];

disp('Final Position');
disp(col1);
disp('Tentative Position');
disp(T1' * col1);
xcylinder(0.1, -0.1, 0.1,1, 20, T7'*T6);

T6Px = T6(1,4);
T6Py = T6(2,4);
T6Pz = T6(3,4);

disp('Manipulator');
disp(T6Px);
disp(T6Py);
disp(T6Pz);

disp('Joint 3');
T3Px = T6Px - (T6(1,3) * offset2);
T3Py = T6Py - (T6(2,3) * offset2);
T3Pz = T6Pz - (T6(3,3) * offset2);
disp(T3Px);
disp(T3Py);
disp(T3Pz);
%J3 = [[0;0;0;T3Px],[1;0;0;T3Py],[0;1;0;T3Pz],[0;0;1;1]];
J3 = [T3Px; T3Py; T3Pz; 1];

d3 = sqrt((T3Px - 0)^2 + (T3Py - 0)^2 + (T3Pz - d1)^2);

c2 = (T3Pz - d1) / d3;
theta2 = atan(sqrt(1 - c2^2)/c2);

disp('Theta2');
% Can be positive or negative of the same value depending on theta1
disp(theta2);

c = d3 - c2 * (T3Pz - d1);
a = -sin(theta2) * T3Px;
b = -sin(theta2) * T3Py;

theta1 = atan2(b, a) + atan(sqrt(a^2 + b^2 - c^2) / c);
disp('Theta1');
% Can be opposite by 180 degrees
disp(theta1);




% This is the wrist of the robot
%  x y z p
%  _ _ _ T3Px
%  _ _ _ T3Py
%  _ _ _ T3Pz
%



% disp('Origin');
% disp(T6);
% 
% disp('Back without angle');
% intermit = T1'*col1;
% disp(intermit);
% d_2 = intermit(3,1); % d2 
% disp('d2');
% disp(d_2);
% 
% Px = T6(1,4);
% Py = T6(2,4);
% Pz = T6(3,4);
% disp('Px');
% disp(Px);
% disp('Py');
% disp(Py);
% disp('Pz');
% disp(Pz);
% 
% 
% r = sqrt(Px^2 + Py^2);
% 
% theta1_1 = atan2(Py, Px) - atan2(d_2, sqrt(r^2 - d_2^2));
% theta1_2 = atan2(Py, Px) - atan2(d_2, -sqrt(r^2 - d_2^2));
% disp('Positive----------');
% disp('Radians');
% disp(theta1_1);
% disp('Degrees');
% disp(radtodeg(theta1_1));
% disp('Negative----------');
% disp('Radians');
% disp(theta1_2);
% disp('Degrees');
% disp(radtodeg(theta1_2));
% 
