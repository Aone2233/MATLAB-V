function gama_tao = Gibbs_tao_R1(p,t)
% Calculate the dimensionless differential Gibbs function to tao at region 1
%
%  Purpose: 
%    This function calculates the differential Gibbs function to tao at region 1
%  which is defined  in the table 4 in the release on the IAPWS Industrial
%  Formulation
% 
%  Record of revisions:
%      Date       Programmer          Description of change
%      ====       ==========          =====================
%    2010/07/09   Jiyang Yu              Original code 
%
% Define variables:
%   t             -- Temperature in K
%   p            -- Pressure in MPa, p and t should have same size.
%   n            -- Numerical values of the coefficients of the equation (7)
%   ii and ji  -- the exponents of the dimensionless Gibbs free energy
%   ps           -- Saturation pressure at temperature t, MPa
%   s             -- Scope of the range of region 1
%                  ps <= p <= 100MPa
%                  0  <=  t <= 623.15K
%   i             -- loop index
%  pai          -- dimensionless pressure
%  tao          -- dimensionless temperature
%
% Numerical values of the coefficients of the equation (7)
 n = [0.14632971213167D0,  -0.84548187169114D0,  -0.37563603672040D1,...
       0.33855169168385D1,  -0.95791963387872D0,   0.15772038513228D0,...
       -0.16616417199501D-1,  0.81214629983568D-3,  0.28319080123804D-3,...
       -0.60706301565874D-3, -0.18990068218419D-1, -0.32529748770505D-1,...
       -0.21841717175414D-1, -0.52838357969930D-4, -0.47184321073267D-3,...
       -0.30001780793026D-3,  0.47661393906987D-4, -0.44141845330846D-5,...
       -0.72694996297594D-15,-0.31679644845054D-4, -0.28270797985312D-5,...
       -0.85205128120103D-9, -0.22425281908000D-5, -0.65171222895601D-6,...
       -0.14341729937924D-12,-0.40516996860117D-6, -0.12734301741641D-8,...
       -0.17424871230634D-9, -0.68762131295531D-18, 0.14478307828521D-19,...
        0.26335781662795D-22,-0.11947622640071D-22, 0.18228094581404D-23,...
       -0.93537087292458D-25];
% the exponents of the dimensionless Gibbs free energy
 ii = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2,...
	   2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 8, 8, 21, 23, 29, 30, 31, 32];
 ji = [-2, -1, 0, 1, 2, 3, 4, 5, -9, -7, -1, 0, 1, 3, -3,...
      0,1,3,17,-4,0,6,-5,-2,10,-8,-11,-6,-29,-31,-38,-39,-40,-41];
% Initialize gama to zeros as same size as t.
  gama_tao = t*0;
% Calculate the saturation pressure at the temperature of t
  ps = p_sat(t);
% calculate the dimensionless pressure and temperature
  pai = p/16.53;
  tao = 1386/t;
% the range coverd by the equation 
  s = t>=0 & t <=623.15 & p>= ps & p <= 100;
% Calculate the dimensionless differential Gibbs function to tao at region 1
for (i = 1:34)
  gama_tao(s) = gama_pi(s) + n(i)*ji(i)*(7.1-pai(s)).^ii(i) .*(tao(s)-1.222).^(ji(i)-1);
end
  