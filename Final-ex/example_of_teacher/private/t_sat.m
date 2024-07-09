function t = t_sat(p)
% Calculate the saturation temperature at region  4
%
%  Purpose: 
%    This function calculates the saturation temperature at region 4 that 
%  is defined as a relation as the equation (31) in the release on the 
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
%   n            -- Numerical values of the coefficients of the equation (31) 
%   s             -- Sign of the range, logical variable
%
% Numerical values of the coefficients of the equation (31)
 n =[0.11670521452767D4,-0.72421316703206D6,...
	 -0.17073846940092D2, 0.12020824702470D5,-0.32325550322333D7,...
	  0.14915108613530D2,-0.48232657361591D4, 0.40511340542057D6,...
	 -0.23855557567849D0, 0.65017534844798D3];
% Initialize the pressure p to zeros as same size as t.
  t = p*0;
% the range coverd by the equation 
  s = p>=611.213e-6 & t <=22.064;
% Calculate the temperature by the equation (31)
 beta(s) = p(s).^0.25;
 e(s)  = beta(s) .^2+n(3)*beta(s) +n(6); 
 f(s)  = n(1)*beta(s) .^2 + n(4)*beta(s) +n(7);
 g(s)  = n(2)*beta(s) .^2 + n(5)*beta(s) +n(8); 
 d(s) = 2*g(s)./(-f(s)-sqrt(f(s).^2-4*e(s).*g(s)));
 t(s) = n(10)/2+d(s)/2-sqrt((n(10)+d(s)).^2-4*(n(9)+n(10)*d(s)))/2;
  