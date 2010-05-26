function P = bezier(varargin)
%
% bezier evaluates a point along a Bezier curve
%
% Arguments:
% t is parameter along the curve 0 <= t <= 1
% CP is a nxm vector of n control points in m-space eg.   [x y z;
%                                                          x y z;
%                                                            ... ]
% Note that for some applications you may want m to be larger than 3.
% For example, if you are interpolating a robot path in 6D joint space m
% will have a value of 6.
%
% Returns
% P  a 1xm vector   eg [x,y,z] giving the point on the curve

p = inputParser;


% All numerics are valid
p.addRequired('t', @(a)isnumeric(a) && a >= 0 && a <= 1);
p.addRequired('CP', @(a)size(a, 1) > 0 && size(a, 2) > 0 && isnumeric(a));

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
t = p.Results.t;
CP = p.Results.CP;

[n, m] = size(CP);

P = zeros(1,m);
for i = 0:1:n-1,
    for j = 1:1:m,  
        P(j) = P(j) + nchoosek(n-1, i) * (1-t)^(n-1-i) * t^i * CP(i+1, j);
    end
end

end