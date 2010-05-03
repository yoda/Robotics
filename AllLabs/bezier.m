function P = bezier(t, CP)
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
end