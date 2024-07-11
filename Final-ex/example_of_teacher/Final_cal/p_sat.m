function p = p_sat(t)
% Calculate the saturation pressure at region  4
%
%  Purpose: 
%    This function calculates the saturation pressure at region 4 that 
%  is defined as a relation as the equation (30) in the release on the 
%  IAPWS Industrial Formulation 
% 
%  Record of revisions:
%      Date       Programmer          Description of change
%      ====       ==========          =====================
%    2010/07/09   Jiyang Yu              Original code 
%
% Define variables:
%   t             -- Temperature in K
%   p            -- Pressure in MPa
%   n            -- Numerical values of the coefficients of the equation (30)
%   s             -- Sign of the range, logical variable
%
% Numerical values of the coefficients of the equation (30)
 n =[0.11670521452767D4,-0.72421316703206D6,...
	 -0.17073846940092D2, 0.12020824702470D5,-0.32325550322333D7,...
	  0.14915108613530D2,-0.48232657361591D4, 0.40511340542057D6,...
	 -0.23855557567849D0, 0.65017534844798D3];
% Initialize the pressure p to zeros as same size as t.
  p = t*0;
% the range coverd by the equation 
  s = t>=273.15 & t <=647.096;
% Calculate the pressure by the equation (30)
 theta(s) = t(s) +n(9)./(t(s) -n(10));
 a(s)  = theta(s) .^2+n(1)*theta(s) +n(2); 
 b(s)  = n(3)*theta(s) .^2 + n(4)*theta(s) +n(5);
 c(s)  = n(6)*theta(s) .^2 + n(7)*theta(s) +n(8); 
 p(s) = (2*c(s) ./(-b(s) +sqrt(b(s) .^2-4*a(s) .*c(s) ))).^4;
  