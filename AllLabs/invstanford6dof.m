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



d1 = p.Results.offset1;
offset2 = p.Results.offset2;

T6 = p.Results.T;
% disp('T6 Bitches');
% disp(T6);

orig = [[0;0;0;1],[1;0;0;1],[0;1;0;1],[0;0;1;1]];
col1temp = (T6 * orig);
col1 = [col1temp(1,1);col1temp(2,1);col1temp(3,1);col1temp(4,1)];

% disp('Final Position');
% disp(col1);

T6Px = T6(1,4);
T6Py = T6(2,4);
T6Pz = T6(3,4);

% disp('Manipulator');
% disp(T6Px);
% disp(T6Py);
% disp(T6Pz);

% n, s , a (National Security Agency)
%orig = [[0;0;0;1],[1;0;0;1],[0;1;0;1],[0;0;1;1]];

%T6 = T6*orig;
% disp('ns');
nx = T6(1,1);
% disp(nx);
ny = T6(2,1);
% disp(ny);
nz = T6(3,1);
% disp(nz);

% disp('ss');
sx = T6(1,2);
% disp(sx);
sy = T6(2,2);
% disp(sy);
sz = T6(3,2);
% disp(sz);

% disp('as');
ax = T6(1,3);
% disp(ax);
ay = T6(2,3);
% disp(ay);
az = T6(3,3);
% disp(az);

% disp('Joint 3');
T3Px = T6Px - (T6(1,3) * offset2);
T3Py = T6Py - (T6(2,3) * offset2);
T3Pz = T6Pz - (T6(3,3) * offset2);
% disp(T3Px);
% disp(T3Py);
% disp(T3Pz);

J3 = [T3Px; T3Py; T3Pz; 1];

d3 = sqrt((T3Px - 0)^2 + (T3Py - 0)^2 + (T3Pz - d1)^2);

% disp('d3');
% disp(d3);

c2 = (T3Pz - d1) / d3;
theta2 = atan(sqrt(1 - c2^2)/c2);
theta22 = atan(-sqrt(1 - c2^2)/c2); % solution 2

% disp('Theta2');
% Can be positive or negative of the same value depending on theta1
% disp(theta2);

c = d3 - c2 * (T3Pz - d1);
a = -sin(theta2) * T3Px;
b = -sin(theta2) * T3Py;


theta1 = atan2(b, a) + atan(sqrt(a^2 + b^2 - c^2) / c);
theta1 = real(theta1); % fuck off imaginary.
if theta1 < 0,
    theta12 = theta1 + pi;
else 
    theta12 = theta1 - pi;
end

% disp('Theta1');
% Can be opposite by 180 degrees
% disp(theta1);
    

theta3 = 0;



% disp('Theta3');
% disp(theta3)

% from col3 equating with inv of T0T3

d = -ax * cos(theta1) * sin(theta2) - ay * sin(theta1) * sin(theta2) + az * cos(theta2);
theta5 = atan((sqrt(1 - d^2)/d)); % solution 1
theta52 = atan((-sqrt(1 - d^2)/d)); % solution 2



% disp('Theta5');
% disp(theta5);
% disp('Theta52');
% disp(theta52);



% from row2,col1,2 equating with inv of T0T3

k = ax * sin(theta1) - ay * cos(theta1);
i = -ax * cos(theta1) * cos(theta2) - ay * cos(theta2) * sin(theta1) - az * sin(theta2);
theta4 = atan2(k, i);
% disp('Theta4');
% disp(theta4);
theta42 = atan2(-k, -i); % solution 2



m = -cos(theta1) * sin(theta2) * nx - sin(theta1) * sin(theta2) * ny + cos(theta2) * nz;
n = cos(theta1) * sin(theta2) * sx + sin(theta1) * sin(theta2) * sy - cos(theta2) * sz;
theta6 = atan2(n,m); % solution 1
theta62 = atan2(-n,-m); % solution 2


% disp('Theta6');
% disp(theta6);
% disp('Theta62');
% disp(theta62);


joint = [[theta1, theta2, theta3, theta4, theta5, theta6]
         [theta1, theta2, theta3, theta4, theta5, theta62]
         [theta1, theta2, theta3, theta42, theta52, theta6]
         [theta1, theta2, theta3, theta42, theta52, theta62]
         [theta12, theta22, theta3, theta4, theta52, theta6]
         [theta12, theta22, theta3, theta4, theta52, theta62]
         [theta12, theta22, theta3, theta42, theta5, theta6]
         [theta12, theta22, theta3, theta42, theta5, theta62]];
     
% Test fnc    
% for j = 1:1:8,
%     stanford6dof(joint(j,1), joint(j,2), joint(j,4), joint(j,5), joint(j,6), d3, offset2, 'coordframe', 1);
% end
    
