% Function to plot a standford manipulator arm
% with 3 variables representing aspects of the transformation/rotation. 
% Returns a figure plot.
%
% Usage:  standford6dof(theta1, theta2, theta3, theta4, theta5,
%                       d3, d2,
%                       'coordframe', true or false (1 or 0))
% Where:  
%         theta1 - base rotation
%         theta2 - first joint rotation
%         theta3 - second joint rotation
%         theta4 - third joint rotation
%         theta5 - fourth joint rotation
%
%         d3 - extension
%         d2 - extension
%         
%         'coordframe', 1 or 0 - turns off the axes.
%
%         Returns a figure plot.
function T = standford6dof( varargin )

    d1 = 5; % base offset 
    
    orig = [[0;0;0;1],[1;0;0;1],[0;1;0;1],[0;0;1;1]];

    p = inputParser;
        % All numerics are valid
        p.addRequired('theta1', @(a)isnumeric(a));
        p.addRequired('theta2', @(a)isnumeric(a));
        p.addRequired('theta3', @(a)isnumeric(a));
        p.addRequired('theta4', @(a)isnumeric(a));
        p.addRequired('theta5', @(a)isnumeric(a));
        p.addRequired('d2', @(a)isnumeric(a));
        p.addRequired('d3', @(a)isnumeric(a));
        % True or false, none is false
        p.addParamValue('coordframe', [],@(y)(y==0 || y==1));
        

    try
        % Do the validation of the parameters
        p.parse(varargin{:});
    catch exception
         disp(exception.identifier); % Debug catching correct errors
         rethrow(exception)
        % Only three numeric
        if strcmp(exception.identifier, 'MATLAB:InputParser:UnmatchedParameter')
            warning('standford6dof takes 7 numeric parameters')
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
            error('standford6dof takes 7 numeric parameters')
        end 
    end

    % Angles
    theta1 = p.Results.theta1;
    theta2 = p.Results.theta2;
    theta3 = p.Results.theta3;
    theta4 = p.Results.theta4;
    theta5 = p.Results.theta5;
    
    % Lengths
    d3 = p.Results.d3;
    d2 = p.Results.d2;
    
    % Axes on?
    coordon = p.Results.coordframe;
    
    % Joint settings / manipulator settings
    cylmanipulatorarmradius = 0.2;
    cylmanipulatorbarradius = 0.3;
    cyllinkradius = 0.4;
    cyljointradius = 0.5;
    
    % Figure Shading
    colormap(copper);
    
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
    
    % Base (Link 1, Joint 1)
    T1 = DHtrans(theta1, d1, 0, pi/2);
    
    zcylinder(cyljointradius, 0, d1/8,0.1, 20); % Base joint cylinder
    zcylinder(cyllinkradius, 0, d1,0.1, 20); % Base tower joint cylinder
    
    if coordon == 1
        plotframe(DHtrans(theta1, 0, 0, 0), 'len', 2, 'label', {'-base', '-base', '-base'});   % draw xyz at base
        plotframe(T1, 'len', 2, 'label', {'-1', '-1', '-1'});    
        line([0,0],[0,0],[0,d1], 'linewidth', 2, 'color', 'magenta');
    end
    
    xcylinder(cyljointradius, -d1/8, d1/8,0.1, 20, T1 * roty(pi/2)); % point 1 joint cylinder
    
    
    % Joint 2
    T2 = DHtrans(theta2, 0, 0, -pi/2);
    T2 = T1 * T2;
    lT2 = T2 * orig; 
    if coordon == 1
        plotframe(T2, 'len', 2, 'label', {'-2', '-2', '-2'});
        line([0,lT2(1,1)],[0,lT2(2,1)],[d1,lT2(3,1)], 'linewidth', 2, 'color', 'magenta');
    end
    
    xcylinder(cyljointradius, -d1/8, d1/8,0.1, 20, T2 * roty(pi/2)); % point 2 to point 3
    
    % Link 3 
    
    T3 = DHtrans(0, d2, 0, 0);
    T3 = T2 * T3;
    lT3 = T3 * orig;
    if coordon == 1
        plotframe(T3, 'len', 2, 'label', {'-3', '-3', '-3'});    
        line([lT2(1,1), lT3(1,1)],[lT2(2,1), lT3(2,1)],[lT2(3,1),lT3(3,1)], 'linewidth', 2, 'color', 'magenta');
    end
    
   % A = [lT2(1,1), lT2(2,1), lT2(3,1)];
   % B = [lT3(1,1), lT3(2,1), lT3(3,1)];
   % q = sqrt((A(1)-B(1))^2 + (A(2)-B(2))^2 + (A(3)-B(3))^2);
    
    xcylinder(cyllinkradius, 0, -d2,0.1, 20, T3 * roty(pi/2) * rotz(pi)); % point 2 to point 3
 
    
    % Joint 3
    T4 = DHtrans(theta3, 0, 0, pi/2);
    T4 = T3 * T4;
    lT4 = T4 * orig; 
    if coordon == 1
        plotframe(T4, 'len', 2, 'label', {'-4', '-4', '-4'});
        line([lT3(1,1),lT4(1,1)],[lT3(2,1),lT4(2,1)],[lT3(3,1),lT4(3,1)], 'linewidth', 2, 'color', 'magenta');
    end
    
    zcylinder(cyljointradius, -d1/8, d1/8,0.1, 20, T4 * rotx(pi/2)); % point 2 to point 3
    
    % Joint 4

    T5 = DHtrans(theta4, 0, 0, -pi/2);
    T5 = T4 * T5;
    lT5 = T5 * orig; 
    if coordon == 1
        plotframe(T5, 'len', 2, 'label', {'-5', '-5', '-5'});
        line([lT4(1,1),lT5(1,1)],[lT4(2,1),lT5(2,1)],[lT4(3,1),lT5(3,1)], 'linewidth', 2, 'color', 'magenta');
    end
    
    zcylinder(cyljointradius, -d1/8, d1/8,0.1, 20, T5 * rotx(pi/2)); % point 2 to point 3
    
    % Link 4 Joint 5
    
    T6 = DHtrans(theta5, d3, 0, 0);
    T6 = T5 * T6;
    lT6 = T6 * orig; 
    if coordon == 1
        plotframe(T6, 'len', 2, 'label', {'-6', '-6', '-6'});
        line([lT3(1,1),lT6(1,1)],[lT3(2,1),lT6(2,1)],[lT3(3,1),lT6(3,1)], 'linewidth', 2, 'color', 'magenta');
    end
    
   % C = [lT5(1,1), lT5(2,1), lT5(3,1)];
   % D = [lT6(1,1), lT6(2,1), lT6(3,1)];
   % r = sqrt((C(1)-D(1))^2 + (C(2)-D(2))^2 + (C(3)-D(3))^2);
    
    xcylinder(cyllinkradius, 0, d3,0.1, 20, T6 * roty(pi/2)); % point 2 to point 3
    
    % Manipulator
    xcylinder(cylmanipulatorbarradius, -0.5, 0.5,0.1, 20, T6); % point 2 to point 3
    zcylinder(cylmanipulatorarmradius, 0, 0.5,0.1, 20, T6 * trans(0.5, 0, 0)); % point 2 to point 3
    zcylinder(cylmanipulatorarmradius, 0, 0.5,0.1, 20, T6 * trans(-0.5, 0, 0)); % point 2 to point 3
    
    T = T6;
end

