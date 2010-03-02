function [ output_args ] = testParse( script, varargin )
%TESTPARSE Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    
    p.addRequired('a', @(x)x<=360&&x>=1==1);
    p.addOptional('b',1);
    p.addParamValue('awesomefactor', 2);
    
    p.parse(script, varargin{:});
    res = p.Results
    


end

