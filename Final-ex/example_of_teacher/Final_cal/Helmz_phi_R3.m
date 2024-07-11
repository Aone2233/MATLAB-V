function phi_delta = Helmz_phi_R3(rho,t)
% Calculate the dimensionless differential Gibbs function to pi at region 3
%
%  Purpose: 
%    This function calculates the differential Gibbs function to pi at
%    region 3
% 
%  Record of revisions:
%      Date       Programmer          Description of change
%      ====       ==========          =====================
%    2010/07/09   Jiyang Yu              Original code 
%
% Define variables:
%   t             -- Temperature in K
%   rho            -- density.
%   n            -- Numerical values of the coefficients of the equation (7)
%   ii and ji  -- the exponents of the dimensionless Gibbs free energy
%   ts           -- Saturation temperature at temperature t, K
%   t23         -- temperature at the boundary of region 2 and 3 at
%                  pressure p
%   s             -- Scope of the range of region 1
%                  ps <= p <= 100MPa
%                  0  <=  t <= 623.15K
%   i             -- loop index
%  tao          -- dimensionless temperature
%  delta        -- dimensionless density
% Numerical values of the coefficients 
ii = [0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,...
              4,4,4,4,5,5,5,6,6,6,7,8,9,9,10,10,11];
ji = [0,0,1,2,7,10,12,23,2,6,15,17,0,2,6,7,22,26,0,...
	          2,4,16,26,0,2,4,26,1,3,26,0,2,26,2,26,2,26,0,1,26];
n = [0.10658070028513D1, -0.15732845290239D2,...
	 0.20944396974307D2, -0.76867707878716D1,  0.26185947787954D1,...
	-0.28080781148620D1,  0.12053369696517D1, -0.84566812812502D-2,...
	-0.12654315477714D1, -0.11524407806681D1,  0.88521043984318D0,...
	-0.64207765181607D0,  0.38493460186671D0, -0.85214708824206D0,...
	 0.48972281541877D1, -0.30502617256965D1,  0.39420536879154D-1,...
	 0.12558408424308D0, -0.27999329698710D0,  0.13899799569460D1,...
	-0.20189915023570D1, -0.82147637173963D-2,-0.47596035734923D0,...
	 0.43984074473500D-1,-0.44476435428739D0,  0.90572070719733D0,...
	 0.70522450087967D0,  0.10770512626332D0, -0.32913623258954D0,...
     -0.50871062041158D0, -0.22175400873096D-1, 0.94260751665092D-1,...
      0.16436278447961D0, -0.13503372241348D-1,-0.14834345352472D-1,...
      0.57922953628084D-3, 0.32308904703711D-2, 0.80964802996215D-4,...
     -0.16557679795037D-3,-0.44923899061815D-4];
 % Initialize phi_delta as same size as t.
  delta = rho./322;
  phi_delta = n(1)./delta;
% calculate the dimensionless temperature
  tao = 647.096./t;
% Calculate the dimensionless differential Gibbs function to pi at region 1
for (i = 2:40)
  phi_delta = phi_delta + n(i)*ii(i).*delta.^(ii(i)-1) .*tao.^ji(i);
end

  