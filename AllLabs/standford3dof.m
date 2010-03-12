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
function standford3dof( varargin )

    d1 = 5; 
    
    orig = [[0;0;0;1],[1;0;0;1],[0;1;0;1],[0;0;1;1]];

    p = inputParser;
        % All numerics are valid
        p.addRequired('theta1', @(a)isnumeric(a));
        p.addRequired('theta2', @(a)isnumeric(a));
        p.addRequired('d3', @(a)isnumeric(a));
        

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
            error('standford3dof takes 4 numeric parameters')
        end 
    end

    theta1 = p.Results.theta1;
    theta2 = p.Results.theta2;
    d3 = p.Results.d3;
    
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
    
    T1 = DHtrans(theta1, d1, 0, pi/2);
    plotframe(DHtrans(theta1, 0, 0, 0), 'len', 2, 'label', {'-base', '-base', '-base'});   % draw xyz at base
    plotframe(T1, 'len', 2, 'label', {'-1', '-1', '-1'});    
    line([0,0],[0,0],[0,d1], 'linewidth', 2, 'color', 'magenta');
    
    
    T2 = DHtrans(theta2, 0, 0, -pi/2);
    T2 = T1 * T2;
    plotframe(T2, 'len', 2, 'label', {'-2', '-2', '-2'});
    lT2 = T2 * orig; 
    line([0,lT2(1,1)],[0,lT2(2,1)],[d1,lT2(3,1)], 'linewidth', 2, 'color', 'magenta');
    disp(lT2);
    
    
    T3 = DHtrans(0, d3, 0, 0);
    T3 = T2 * T3;
    lT3 = T3 * orig;
    plotframe(T3, 'len', 2, 'label', {'-3', '-3', '-3'});    
    line([lT2(1,1), lT3(1,1)],[lT2(2,1), lT3(2,1)],[lT2(3,1),lT3(3,1)], 'linewidth', 2, 'color', 'magenta');

end

