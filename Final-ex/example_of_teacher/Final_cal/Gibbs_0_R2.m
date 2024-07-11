function gama_0 = Gibbs_0_R2(p, t)
    % Calculate the dimensionless differential Gibbs function to pi at region 2
    %
    %  Purpose:
    %    This function calculates the differential Gibbs function to pi at
    %    region 2
    %
    %  Record of revisions:
    %      Date       Programmer          Description of change
    %      ====       ==========          =====================
    %    2024/7/11   AONE 2233              Original code
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
    n = [- 0.96927686500217D1, 0.10086655968018D2, ...
             -0.56087911283020D-2, 0.71452738081455D-1, -0.40710498223928, ...
             0.14240819171444D1, -0.43839511319450D1, -0.28408632460772, ...
             0.21268463753307D-1];
    ji = [0, 1, -5, -4, -3, -2, -1, 2, 3];
    % Initialize gama to zeros as same size as t.
    gama_0 = t * 0;
    % Calculate the saturation pressure at the temperature of t
    ts = t_sat(p);
    t23 = t_B23(p);
    % calculate the dimensionless pressure and temperature
    pai = p;
    tao = 540 ./ t;
    % the range coverd by the equation
    s = ((t >= ts & t <= 623.15) | t >= t23);
    % Calculate the dimensionless differential Gibbs function to pi at region 1
    for i = 1:9
        gama_0(s) = gama_0(s) + n(i) .* tao(s) .^ ji(i);
    end
    gama_0(s) = gama_0(s) + log(pai);
