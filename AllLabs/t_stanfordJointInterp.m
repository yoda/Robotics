function t_standfordJointInterp

offset = [5, 2];
initialJoints = [pi/2, pi/2, 0, pi/3, pi/4, pi/2];
Tfinal = stanford6dof(pi/5, pi/5, 0,pi/5, pi/3, pi/2, 5, 2, 'coordframe', 1);

dt = 0.02;

%bestJoints(invstanford6dof(Tfinal, offset(1), offset(2)), initialJoints);

M = stanfordJointInterp(offset, initialJoints, Tfinal, dt);
movie(M);
end