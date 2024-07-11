function [s_0, h_0] = final_test(p, t)
% 先设置一些参数
% p_x = 16.53; % MPa P*的大小
% T_x = 1386; % T*的大小
R = 0.461526; % kJ·kg-1·K-1气体常数

% 初始化焓，熵
s_0 = t * 0;
h_0 = t * 0;
ps = p_sat(t); % 饱和蒸汽压
% pai = p ./ 16.53; % 无量纲压力
tao = 1386 ./ t; % 无量纲温度
s = t >= 273.15 & t <= 623.15 & p >= ps & p <= 100; % 判断是否在区域1内
s_0(s) = R .* (tao .* Gibbs_tao_R1(p, t) - Gibbs_R1(p, t));
h_0(s) = R .* t .* tao .* Gibbs_tao_R1(p, t);



