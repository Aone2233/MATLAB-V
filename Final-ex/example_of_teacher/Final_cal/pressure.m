function p = pressure(rho,t)
% Calculate the pressure 
%
%  Purpose: 
%    This function calculates  the pressure by density and temperature 
% 
%  Record of revisions:
%      Date       Programmer          Description of change
%      ====       ==========          =====================
%    2010/07/09   Jiyang Yu              Original code 
%
% Define variables:
%   t             -- Temperature in K
%   p            -- Pressure in MPa, p and t should have same size.
%   rho         -- density in kg/m^3
%
%   use Newton mathod to calculate the backward equation
%   p(k+1) = p(k) - (density(p,t)-rho)/df(p,t)
%
% Initialize the parameters needed
%set the initial pressure at 1MPa
p1 = rho*0+50;
p2 = p1+1e-6;
r1 = p1; r2 = p1; df = p1; err = p1;
s = err>1.0e-4;
while(s)
    p2(s) = p1(s)+1e-6;
% calculate f1 and f2
    r1(s) = density(p1(s),t(s))-rho(s);
    r2(s) = density(p2(s),t(s))-rho(s);
% use (f1-f2)/(x1-x2) to calculate the differential term of df(p,t)
% have to change MPa to Pa
    df(s)= (r1(s) - r2(s))./((p1(s) - p2(s)).*1e6);
% get new pressure p1, change back to MPa
    p1(s) = p1(s)-r1(s)./df(s).*1.0e-6;
% calculate the errors
    err = abs(r1(s)./df(s));
    s = err>1.0e-4;
end
p = p1;
p(isnan(p1)) = 0;
p(p1<0) = 0;
