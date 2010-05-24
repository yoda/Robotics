% Function to plot 4 vectors from an origin and applying a
% transformation/rotation. Returns a figure plot.
%
% Usage:  standford3dof(theta1, theta2, d3)
% Where:  
%         theta1
%         theta2
%         d3
%         'coordframe', (true/false) *optional
%         
%         Returns a figure plot.
function standford3dof( varargin )

    d1 = 5; 
    
    orig = [[0;0;0;1],[1;0;0;1],[0;1;0;1],[0;0;1;1]];

    p = inputParser;
        % All numerics are valid
        p.addRequired('theta1', @(a)isnumeric(a));
        p.addRequired('theta2', @(a)isnumeric(a));
        p.addRequired('d3', @(a)isnumeric(a));
        % inputParser Parameter being true (1) or false (0).
        p.addParamValue('coordframe', [],@(y)(y==0 || y==1));
        

    try
        % Do the validation of the parameters
        p.parse(varargin{:});
    catch exception
         disp(exception.identifier); % Debug catching correct errors
         rethrow(exception)
        % Only three numeric
        if strcmp(exception.identifier, 'MATLAB:InputParser:UnmatchedParameter')
            warning('standford3dof takes 4 numeric parameters')
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
            error('standford3dof takes 4 numeric parameters')
        end 
    end

    theta1 = p.Results.theta1;
    theta2 = p.Results.theta2;
    d3 = p.Results.d3;
    coordon = p.Results.coordframe;
    
    % Join thickness
    cyllinkradius = 0.3;
    cyljointradius = 0.6;
    
    % Figure Shading
    colormap(copper);
    
    % Figure settings
    XMIN = -5;
    XMAX = 5;
    YMIN = -5;
    YMAX = 5;
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
    
    % Link 3 Joint 3
    
    T3 = DHtrans(0, d3, 0, 0);
    T3 = T2 * T3;
    lT3 = T3 * orig;
    if coordon == 1
        plotframe(T3, 'len', 2, 'label', {'-3', '-3', '-3'});    
        line([lT2(1,1), lT3(1,1)],[lT2(2,1), lT3(2,1)],[lT2(3,1),lT3(3,1)], 'linewidth', 2, 'color', 'magenta');
    end
    
    A = [lT2(1,1), lT2(2,1), lT2(3,1)];
    B = [lT3(1,1), lT3(2,1), lT3(3,1)];
    q = sqrt((A(1)-B(1))^2 + (A(2)-B(2))^2 + (A(3)-B(3))^2);
    
    xcylinder(cyllinkradius, 0, -q,0.1, 20, T3 * roty(pi/2) * rotz(pi)); % point 2 to point 3
    

end

