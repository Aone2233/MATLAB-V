function t = t_B23(p)
% Calculate the temperature at the boundary between region  2 and region 3
%
%  Purpose: 
%    This function calculates the boundary between regions 2 and 3 that 
%  is defined as a backward equation of the B23-equation
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
%   s             -- Sign of the range, if the pressure is inputed
%                     between 16.5292MPa to 100MPa, s is set to be 1, 
%                     otherwise s is set to be 0 and the temperature at that
%                     point will be set to 0.
%%   
% Numerical values of the coefficients of the B23-equation
  n = [0.34805185628969e+3,-0.11671859879975e1,...
          0.10192970039326e-2,  0.57254459862746e3,  0.13918839778870e2];
% Initialize the temperature t to zeros as same size as p.
  t = p*0;
% the range coverd by the equation 
  s = p>=16.5292;
% Calculate the temperature by the backward B23-equation
  t(s) = n(4) + sqrt((p(s)-n(5))/n(3));
  