%  Function for calculating forward kinematics of a 2 link planar arm
%
%  Usage:  [J1, J2] = planar2dof(J0, l1, l2, theta1, theta2)
%
%  Arguments:  J0     - 2-vector giving x y coords of the robot base
%              l1     - length of link 1
%              l2     - length of link 2
%              theta1 - angle of first joint
%              theta2 - angle of second joint relative to first link
%
%  Returns:    J1     - x y coords of the end of link 1
%              J2     - x y coords of the end of link 2 (end-effector)
%
% Example of use:
%  [j1, J2] = planar2dof([0 0], 1, 1, pi/4, pi/8);

function [J1, J2] = planar2dof(J0, l1, l2, theta1, theta2)
    rtheta1 = theta1 * pi / 180;
    rtheta2 = theta2 * pi / 180;
    
    x = l1 * cos(rtheta1) + J0(1);
    y = l1 * sin(rtheta1) + J0(2);
    J1 = [x, y];
    
    x1 = l2 * cos(rtheta2 + rtheta1) + J1(1);
    y1 = l2 * sin(rtheta2 + rtheta1) + J1(2);
    J2 = [x1, y1];