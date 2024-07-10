% 先设置一些参数
p_x = 16.53; % MPa P*的大小
T_x = 1386; % T*的大小
R = 8.314; % J/(mol*K)气体常数

% 初始化s，熵
s_0 = t * 0;
ps = p_sat(t); % 饱和蒸汽压
pai = p / p_x; % 无量纲压力
tao = T_x ./ t; % 无量纲温度
s = t >= 273.15 & t <= 623.15 & p >= ps & p <= 100; % 判断是否在区域1内
for (i = 1:34)
    s_0(s) = R * (tao .* Gibbs_tao_R1(p, t) - Gibbs_R1(p, t));
end



