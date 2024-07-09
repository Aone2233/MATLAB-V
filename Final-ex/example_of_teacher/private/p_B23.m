function p = p_B23(t)
% Calculate the pressure at the boundary between region  2 and region 3
%
%  Purpose: 
%    This function calculates the boundary between regions 2 and 3 that 
%  is defined as a quadratic pressure-temperature relation as B23-equation
% 
%  Record of revisions:
%      Date       Programmer          Description of change
%      ====       ==========          =====================
%    2010/07/09   Jiyang Yu              Original code 
%
% Define variables:
%   t             -- Temperature in K
%   p            -- Pressure in MPa
%   n            -- Numerical values of the coefficients of the B23-equation
%   s             -- Sign of the range, if the temperature is inputed
%                     between 623.15K and 863.15K, s is set to be 1, 
%                     otherwise s is set to be 0 and the pressure at that
%                     point will be 0.
%
% Numerical values of the coefficients of the B23-equation
  n = [0.34805185628969e+3,-0.11671859879975e1,...
          0.10192970039326e-2,  0.57254459862746e3,  0.13918839778870e2];
% Initialize the pressure p to zeros as same size as t.
  p = t*0;
% the range coverd by the equation 
  s = t>=623.15;
% Calculate the pressure by B23-equation
  p(s) = n(1) + n(2) .* t(s) + n(3) .* t(s).^2;
  