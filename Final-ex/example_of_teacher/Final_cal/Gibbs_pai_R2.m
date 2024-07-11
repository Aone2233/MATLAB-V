function gama_pai = Gibbs_pai_R2(p,t)
% Calculate the dimensionless differential Gibbs function to pi at region 2
%
%  Purpose: 
%    This function calculates the differential Gibbs function to pi at
%    region 2
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
%   ts           -- Saturation temperature at temperature t, K
%   t23         -- temperature at the boundary of region 2 and 3 at
%                  pressure p
%   s             -- Scope of the range of region 1
%                  ps <= p <= 100MPa
%                  0  <=  t <= 623.15K
%   i             -- loop index
%  pai          -- dimensionless pressure
%  tao          -- dimensionless temperature
%
% Numerical values of the coefficients 
n = [-0.17731742473213D-2, -0.17834862292358D-1,...
	-0.45996013696365D-1, -0.57581259083432D-1, -0.50325278727930D-1,...
	-0.33032641670203D-4, -0.18948987516315D-3, -0.39392777243355D-2,...
	-0.43797295650573D-1, -0.26674547914087D-4,  0.20481737692309D-7,...
	 0.43870667284435D-6, -0.32277677238570D-4, -0.15033924542148D-2,...
	-0.40668253562649D-1, -0.78847309559367D-9,  0.12790717852285D-7,...
	 0.48225372718507D-6,  0.22922076337661D-5, -0.16714766451061D-10,...
	-0.21171472321355D-2, -0.23895741934104D2,  -0.59059564324270D-17,...
	-0.12621808899101D-5, -0.38946842435739D-1,  0.11256211360459D-10,...
	-0.82311340897998D1,   0.19809712802088D-7,  0.10406965210174D-18,...
	-0.10234747095929D-12,-0.10018179379511D-8, -0.80882908646985D-10,...
	 0.10693031879409D0,  -0.33662250574171D0,   0.89185845355421D-24,...
	 0.30629316876232D-12,-0.42002467698208D-5, -0.59056029685639D-25,...
	 0.37826947613457D-5, -0.12768608934681D-14, 0.73087610595061D-28,...
	 0.55414715350778D-16,-0.94369707241210D-6];
ii = [1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,5,6,6,6,7,7,7,...
	 8,8,9,10,10,10,16,16,18,20,20,20,21,22,23,24,24,24];
ji = [0,1,2,3,6,1,2,4,7,36,0,1,3,6,35,1,2,3,7,3,16,35,0,...
	 11,25,8,36,13,4,10,14,29,50,57,20,35,48,21,53,39,26,40,58];
% Initialize gama to zeros as same size as t.
  gama_pai = t*0;
% Calculate the saturation pressure at the temperature of t
  ts = t_sat(p);
  t23 = t_B23(p);
% calculate the dimensionless pressure and temperature
  pai = p;
  tao = 540./t;
% the range coverd by the equation 
  s = ((t>= ts & t<=623.15)|t >= t23) ;
% Calculate the dimensionless differential Gibbs function to pi at region 1
for (i = 1:43)
  gama_pai(s) = gama_pai(s) + n(i)*ii(i).*pai(s).^(ii(i)-1) .*(tao(s)-0.5).^ji(i);
end
  