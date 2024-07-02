L = 0.1 * 10^(-3); % 电感值
R = 50; % 电阻值
C = 0.25 * 10^(-6); % 电容值
V_0 = 10 * 10^(-3); % 初始电压值

f = 1:1:1000; % 频率范围

Omega = 2 * pi * f; % 角频率

% 计算电阻电压
V_R = R * V_0 / sqrt(R^2 + (Omega * L - 1 / (Omega * C))^2);

% 输出图像
plot(f, V_R);
title('电阻电压与频率的关系');
xlabel('频率(Hz)');
ylabel('电阻电压(V)');
grid on;