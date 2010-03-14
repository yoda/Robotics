% Function to plot 4 vectors from an origin and applying a
% transformation/rotation. Returns a figure plot.
%
% Usage:  puma3dof(theta1, theta2, theta3)
% Where:  
%         theta1
%         theta2
%         theta3
%         
%         Returns a figure plot.
function puma3dof( varargin )

    offset1 = 5; 
    offset2 = 0; 
    offset3 = 0;
    
    orig = [[0;0;0;1],[1;0;0;1],[0;1;0;1],[0;0;1;1]];

    p = inputParser;
        % All numerics are valid
        p.addRequired('theta1', @(a)isnumeric(a));
        p.addRequired('theta2', @(a)isnumeric(a));
        p.addRequired('theta3', @(a)isnumeric(a));
        p.addParamValue('coordframe', [],@(y)(y==0 || y==1));

    try
        % Do the validation of the parameters
        p.parse(varargin{:});
    catch exception
         disp(exception.identifier); % Debug catching correct errors
         rethrow(exception)
        % Only three numeric
        if strcmp(exception.identifier, 'MATLAB:InputParser:UnmatchedParameter')
            warning('DHtrans takes 4 numeric parameters')
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
            error('DHtrans takes 4 numeric parameters')
        end 
    end

    theta1 = p.Results.theta1;
    theta2 = p.Results.theta2;
    theta3 = p.Results.theta3;
    coordon = p.Results.coordframe;
    
    
    cyllinkradius = 0.3;
    cyljointradius = 0.6;
    
    colormap(copper);
    
    XMIN = -10;
    XMAX = 10;
    YMIN = -10;
    YMAX = 10;
    ZMIN = -10;
    ZMAX = 10;
    axis equal;                            % make x y and z tick sizes equal
    axis([XMIN XMAX YMIN YMAX ZMIN ZMAX]); % set ranges in x y and z
    hold on;                               % freeze the current axis settings
    grid on;
    
    T1 = DHtrans(theta1, offset1, 0, pi/2);
    if coordon == 1
        plotframe(DHtrans(theta1, 0, 0, 0), 'len', 2, 'label', {'-base', '-base', '-base'});   % draw xyz at base
    end
    
    zcylinder(cyljointradius, 0, offset1/8,0.1, 20); % Base joint cylinder
    zcylinder(cyllinkradius, 0, offset1,0.1, 20); % Base tower joint cylinder
    
    if coordon == 1
        plotframe(T1, 'len', 2, 'label', {'-1', '-1', '-1'}); % Top Base tower joint coord   
    end
    
    xcylinder(cyljointradius, -offset1/8, offset1/8,0.1, 20, T1 * roty(pi/2)); % point 1 joint cylinder
    
    if coordon == 1
        line([0,0],[0,0],[0,offset1], 'linewidth', 2, 'color', 'magenta'); % Line from base to point 1
    end
    
    T2 = DHtrans(theta2, offset2, 3, 0);
    T2 = T1 * T2;
    if coordon == 1
        plotframe(T2, 'len', 2, 'label', {'-2', '-2', '-2'});
    end
    
    lT2 = T2 * orig; 
    
    X = [0,0,offset1];
    Y = [lT2(1,1), lT2(2,1), lT2(3,1)];
    d = sqrt((X(1)-Y(1))^2 + (X(2)-Y(2))^2 + (X(3)-Y(3))^2);
    
    xcylinder(cyllinkradius, 0, -d,0.1, 20, T2); % point 1 to point 2
    xcylinder(cyljointradius, -offset1/8, offset1/8,0.1, 20, T2 * roty(pi/2)); %  point 2 joint cylinder
    
    if coordon == 1
        line([0,lT2(1,1)],[0,lT2(2,1)],[offset1,lT2(3,1)], 'linewidth', 2, 'color', 'magenta');
    end
    
    
    T3 = DHtrans(theta3, offset3, 3, 0);
    T3 = T2 * T3;
    lT3 = T3 * orig;
    
    A = [lT2(1,1), lT2(2,1), lT2(3,1)];
    B = [lT3(1,1), lT3(2,1), lT3(3,1)];
    q = sqrt((A(1)-B(1))^2 + (A(2)-B(2))^2 + (A(3)-B(3))^2);
    
    xcylinder(cyllinkradius, 0, -q,0.1, 20, T3); % point 2 to point 3
    
    if coordon == 1
        plotframe(T3, 'len', 2, 'label', {'-3', '-3', '-3'});    
        line([lT2(1,1), lT3(1,1)],[lT2(2,1), lT3(2,1)],[lT2(3,1),lT3(3,1)], 'linewidth', 2, 'color', 'magenta');
    end
    
    

end

