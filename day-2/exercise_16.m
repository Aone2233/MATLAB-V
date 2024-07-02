L = 0.1 * 10^(-3); % 电感值
R = 50; % 电阻值
C = 0.25 * 10^(-6); % 电容值
V_0 = 10 * 10^(-3); % 初始电压值

% 定义电阻电压函数，接受标量f
V_R = @(f) R * V_0 ./ sqrt(R^2 + (2 * pi * f * L - 1 ./ (2 * pi * f * C)).^2);

% 反转函数以找到最小值（原函数最大值）
neg_V_R = @(f) -V_R(f);

% 使用fminbnd函数找到最大值
[f_max, neg_V_R_min] = fminbnd(neg_V_R, 10, 1000000);

% 计算原函数最大值
V_R_max = V_R(f_max);

% 显示结果
fprintf('最大电阻电压是：%e，对应的频率是：%e。\n', V_R_max, f_max);

% 由于fminbnd用于寻找最大电阻电压，绘图部分需要调整
f_plot = 10:10:1000000; % 用于绘图的频率范围
V_R_plot = arrayfun(V_R, f_plot); % 计算绘图用的电阻电压值, arrayfun用于将函数应用于数组的每个元素

% arrayfun的具体内容：
% 基本语法：B = arrayfun(fun, A)
% fun: 要应用于数组的函数句柄，指向想要应用在数组A中每个元素上的函数
% A: 要应用于函数的数组
% B: 输出数组，其元素为fun(A(i))的结果
% 举例：arrayfun(@(x) x^2, [1, 2, 3]) 返回 [1, 4, 9]

% 输出图像
plot(f_plot, V_R_plot);
title('电阻电压与频率的关系');
xlabel('频率(Hz)');
ylabel('电阻电压(V)');
grid on;